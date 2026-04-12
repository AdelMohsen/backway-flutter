import 'dart:developer' as developer;
import 'package:url_launcher/url_launcher.dart';

/// WhatsApp-specific sharing functionality
/// 
/// This module handles sharing content specifically to WhatsApp using
/// the WhatsApp URL scheme and web API.
class WhatsAppShare {
  /// Share content to WhatsApp
  /// 
  /// [message] - Optional custom message to share
  /// [url] - Deep link URL to include in the message
  /// [phoneNumber] - Optional specific phone number to share to
  /// 
  /// Returns true if sharing was successful, false otherwise
  static Future<bool> shareToWhatsApp({
    String? message,
    required String url,
    String? phoneNumber,
  }) async {
    try {
      // Construct the complete message with URL
      final String fullMessage = message != null 
          ? '$message\n\n$url'
          : url;
      
      developer.log(
        'Sharing to WhatsApp: message=${message ?? 'none'}, url=$url',
        name: 'WhatsAppShare',
      );
      
      // Build WhatsApp URL
      String whatsappUrl;
      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        // Share to specific contact
        whatsappUrl = 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(fullMessage)}';
      } else {
        // Open WhatsApp with message ready to send
        whatsappUrl = 'https://wa.me/?text=${Uri.encodeComponent(fullMessage)}';
      }

      final Uri uri = Uri.parse(whatsappUrl);
      
      // Check if WhatsApp can be launched
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        developer.log('Successfully shared to WhatsApp', name: 'WhatsAppShare');
        return true;
      } else {
        developer.log('WhatsApp is not available', name: 'WhatsAppShare');
        return false;
      }
    } catch (e) {
      developer.log('Error sharing to WhatsApp: $e', name: 'WhatsAppShare');
      return false;
    }
  }

  /// Check if WhatsApp is available on the device
  /// 
  /// Returns true if WhatsApp can be opened, false otherwise
  static Future<bool> isAvailable() async {
    try {
      final Uri uri = Uri.parse('https://wa.me/');
      return await canLaunchUrl(uri);
    } catch (e) {
      developer.log('Error checking WhatsApp availability: $e', name: 'WhatsAppShare');
      return false;
    }
  }
}
