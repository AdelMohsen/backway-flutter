import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Snapchat-specific sharing functionality
/// 
/// This module handles sharing content to Snapchat. Since Snapchat doesn't
/// support direct URL sharing via API, this implementation copies the content
/// to clipboard and opens Snapchat for manual sharing.
class SnapchatShare {
  /// Share content to Snapchat
  /// 
  /// [message] - Optional custom message to share
  /// [url] - Deep link URL to include in the message
  /// 
  /// Note: Snapchat doesn't support direct URL sharing, so this method
  /// copies the content to clipboard and opens Snapchat for manual sharing.
  /// 
  /// Returns true if Snapchat was opened successfully, false otherwise
  static Future<bool> shareToSnapchat({
    String? message,
    required String url,
  }) async {
    try {
      // Construct the complete message with URL
      final String fullMessage = message != null 
          ? '$message\n\n$url'
          : url;
      
      developer.log(
        'Sharing to Snapchat: message=${message ?? 'none'}, url=$url',
        name: 'SnapchatShare',
      );
      
      // Copy message to clipboard since Snapchat doesn't support direct sharing
      await Clipboard.setData(ClipboardData(text: fullMessage));
      developer.log('Content copied to clipboard', name: 'SnapchatShare');
      
      // Try to open Snapchat app
      const String snapchatUrl = 'snapchat://app';
      final Uri uri = Uri.parse(snapchatUrl);
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        developer.log('Successfully opened Snapchat', name: 'SnapchatShare');
        return true;
      } else {
        // Snapchat doesn't have a reliable web interface for sharing
        developer.log('Snapchat app is not available', name: 'SnapchatShare');
        return false;
      }
    } catch (e) {
      developer.log('Error sharing to Snapchat: $e', name: 'SnapchatShare');
      return false;
    }
  }

  /// Check if Snapchat is available on the device
  /// 
  /// Returns true if Snapchat can be opened, false otherwise
  static Future<bool> isAvailable() async {
    try {
      const String snapchatUrl = 'snapchat://app';
      final Uri uri = Uri.parse(snapchatUrl);
      return await canLaunchUrl(uri);
    } catch (e) {
      developer.log('Error checking Snapchat availability: $e', name: 'SnapchatShare');
      return false;
    }
  }
}
