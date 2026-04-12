import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Instagram-specific sharing functionality
/// 
/// This module handles sharing content to Instagram. Since Instagram doesn't
/// support direct URL sharing via API, this implementation copies the content
/// to clipboard and opens Instagram for manual sharing.
class InstagramShare {
  /// Share content to Instagram
  /// 
  /// [message] - Optional custom message to share
  /// [url] - Deep link URL to include in the message
  /// 
  /// Note: Instagram doesn't support direct URL sharing, so this method
  /// copies the content to clipboard and opens Instagram for manual sharing.
  /// 
  /// Returns true if Instagram was opened successfully, false otherwise
  static Future<bool> shareToInstagram({
    String? message,
    required String url,
  }) async {
    try {
      // Construct the complete message with URL
      final String fullMessage = message != null 
          ? '$message\n\n$url'
          : url;
      
      developer.log(
        'Sharing to Instagram: message=${message ?? 'none'}, url=$url',
        name: 'InstagramShare',
      );
      
      // Copy message to clipboard since Instagram doesn't support direct sharing
      await Clipboard.setData(ClipboardData(text: fullMessage));
      developer.log('Content copied to clipboard', name: 'InstagramShare');
      
      // Try to open Instagram app
      const String instagramUrl = 'instagram://app';
      final Uri uri = Uri.parse(instagramUrl);
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        developer.log('Successfully opened Instagram', name: 'InstagramShare');
        return true;
      } else {
        // Fallback to Instagram web
        const String instagramWebUrl = 'https://www.instagram.com/';
        final Uri webUri = Uri.parse(instagramWebUrl);
        
        if (await canLaunchUrl(webUri)) {
          await launchUrl(webUri, mode: LaunchMode.externalApplication);
          developer.log('Opened Instagram web as fallback', name: 'InstagramShare');
          return true;
        } else {
          developer.log('Instagram is not available', name: 'InstagramShare');
          return false;
        }
      }
    } catch (e) {
      developer.log('Error sharing to Instagram: $e', name: 'InstagramShare');
      return false;
    }
  }

  /// Check if Instagram is available on the device
  /// 
  /// Returns true if Instagram can be opened, false otherwise
  static Future<bool> isAvailable() async {
    try {
      const String instagramUrl = 'instagram://app';
      final Uri uri = Uri.parse(instagramUrl);
      return await canLaunchUrl(uri);
    } catch (e) {
      developer.log('Error checking Instagram availability: $e', name: 'InstagramShare');
      return false;
    }
  }
}
