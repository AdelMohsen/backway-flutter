import 'dart:developer' as developer;
import 'package:url_launcher/url_launcher.dart';

/// Facebook-specific sharing functionality
/// 
/// This module handles sharing content to Facebook using the Facebook
/// web sharing API and mobile app integration.
class FacebookShare {
  /// Share content to Facebook
  /// 
  /// [message] - Optional custom message to share (used as quote)
  /// [url] - Deep link URL to share
  /// 
  /// Returns true if sharing was successful, false otherwise
  static Future<bool> shareToFacebook({
    String? message,
    required String url,
  }) async {
    try {
      developer.log(
        'Sharing to Facebook: message=${message ?? 'none'}, url=$url',
        name: 'FacebookShare',
      );
      
      // Try Facebook app first
      final bool appSuccess = await _shareViaFacebookApp(message, url);
      if (appSuccess) {
        return true;
      }
      
      // Fallback to Facebook web sharing
      return await _shareViaFacebookWeb(message, url);
      
    } catch (e) {
      developer.log('Error sharing to Facebook: $e', name: 'FacebookShare');
      return false;
    }
  }

  /// Share via Facebook mobile app
  static Future<bool> _shareViaFacebookApp(String? message, String url) async {
    try {
      // Facebook app URL scheme for sharing
      final String facebookAppUrl = 'fb://sharer/sharer.php?u=${Uri.encodeComponent(url)}';
      final Uri uri = Uri.parse(facebookAppUrl);
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        developer.log('Shared via Facebook app', name: 'FacebookShare');
        return true;
      }
      return false;
    } catch (e) {
      developer.log('Facebook app sharing failed: $e', name: 'FacebookShare');
      return false;
    }
  }

  /// Share via Facebook web interface
  static Future<bool> _shareViaFacebookWeb(String? message, String url) async {
    try {
      // Build Facebook web sharing URL
      String facebookWebUrl = 'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(url)}';
      
      // Add quote parameter if message is provided
      if (message != null && message.isNotEmpty) {
        facebookWebUrl += '&quote=${Uri.encodeComponent(message)}';
      }
      
      final Uri uri = Uri.parse(facebookWebUrl);
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        developer.log('Shared via Facebook web', name: 'FacebookShare');
        return true;
      } else {
        developer.log('Facebook web sharing not available', name: 'FacebookShare');
        return false;
      }
    } catch (e) {
      developer.log('Facebook web sharing failed: $e', name: 'FacebookShare');
      return false;
    }
  }

  /// Check if Facebook is available on the device
  /// 
  /// Returns true if Facebook can be opened, false otherwise
  static Future<bool> isAvailable() async {
    try {
      // Check Facebook app first
      final Uri appUri = Uri.parse('fb://');
      if (await canLaunchUrl(appUri)) {
        return true;
      }
      
      // Check Facebook web as fallback
      final Uri webUri = Uri.parse('https://www.facebook.com/');
      return await canLaunchUrl(webUri);
    } catch (e) {
      developer.log('Error checking Facebook availability: $e', name: 'FacebookShare');
      return false;
    }
  }
}
