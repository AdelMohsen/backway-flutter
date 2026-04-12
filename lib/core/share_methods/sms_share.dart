import 'dart:developer' as developer;
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

/// SMSShare class for handling SMS-specific sharing
///
/// This class provides functionality for sharing content via SMS
/// using the sms: URI scheme.
class SMSShare {
  /// Share content via SMS
  /// 
  /// [message] - Optional custom message to include in the SMS body
  /// [url] - Deep link URL to include in the SMS body
  /// [phoneNumber] - Optional phone number to send SMS to
  /// 
  /// Returns true if SMS app was opened, false otherwise
  static Future<bool> shareToSms({
    String? message,
    required String url,
    String? phoneNumber,
  }) async {
    try {
      developer.log(
        'Sharing via SMS: message=${message ?? 'none'}, url=$url, phoneNumber=${phoneNumber ?? 'none'}',
        name: 'SMSShare',
      );

      // Prepare SMS content
      final String body = message != null 
          ? '$message\n\n$url' 
          : url;
      
      // Construct SMS URI
      Uri smsUri;
      
      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        // Use direct phone number if provided
        smsUri = Uri(
          scheme: 'sms',
          path: phoneNumber,
          queryParameters: {'body': body},
        );
      } else {
        // No specific recipient
        smsUri = Uri(
          scheme: 'sms',
          queryParameters: {'body': body},
        );
      }

      // Launch SMS app
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
        developer.log('Successfully opened SMS app', name: 'SMSShare');
        return true;
      }
      
      // If direct SMS URI fails, try generic share as fallback
      try {
        // Use native share sheet as fallback
        final shareContent = body;
        await Share.share(
          shareContent,
          subject: 'Shared via SMS',
        );
        
        developer.log('Falling back to generic share for SMS content', name: 'SMSShare');
        return true; // Assume success if no exception
      } catch (fallbackError) {
        developer.log('All SMS sharing methods failed: $fallbackError', name: 'SMSShare');
        return false;
      }
    } catch (e) {
      developer.log('Error sharing via SMS: $e', name: 'SMSShare');
      return false;
    }
  }

  /// Check if SMS sharing is available
  /// 
  /// Returns true if SMS app is available, false otherwise
  static Future<bool> isAvailable() async {
    try {
      // Check if SMS app is available
      final Uri smsUri = Uri(
        scheme: 'sms',
        path: '',
      );
      
      return await canLaunchUrl(smsUri);
    } catch (e) {
      developer.log('Error checking SMS availability: $e', name: 'SMSShare');
      return false;
    }
  }
}
