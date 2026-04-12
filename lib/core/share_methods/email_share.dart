import 'dart:developer' as developer;
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

/// EmailShare class for handling email-specific sharing
///
/// This class provides functionality for sharing content via email
/// using the mailto: URI scheme.
class EmailShare {
  /// Share content via email
  /// 
  /// [message] - Optional custom message to include in the email body
  /// [url] - Deep link URL to include in the email body
  /// [subject] - Optional email subject line
  /// [recipient] - Optional email recipient address
  /// 
  /// Returns true if email app was opened, false otherwise
  static Future<bool> shareToEmail({
    String? message,
    required String url,
    String? subject,
    String? recipient,
  }) async {
    try {
      developer.log(
        'Sharing via email: message=${message ?? 'none'}, url=$url, subject=${subject ?? 'none'}, recipient=${recipient ?? 'none'}',
        name: 'EmailShare',
      );

      // Prepare email content
      final String body = message != null 
          ? '$message\n\n$url' 
          : url;
      
      // Construct mailto URI
      Uri emailUri;
      bool canLaunch = false;
      
      if (recipient != null && recipient.isNotEmpty) {
        // Try with specific recipient
        emailUri = Uri(
          scheme: 'mailto',
          path: recipient,
          query: encodeQueryParameters({
            'subject': subject ?? 'Shared Content',
            'body': body,
          }),
        );
        
        canLaunch = await canLaunchUrl(emailUri);
        if (canLaunch) {
          await launchUrl(emailUri);
          developer.log('Successfully opened email app with recipient', name: 'EmailShare');
          return true;
        }
      }
      
      // If that fails, try without recipient
      emailUri = Uri(
        scheme: 'mailto',
        query: encodeQueryParameters({
          'subject': subject ?? 'Shared Content',
          'body': body,
        }),
      );

      // Try launch with mailto scheme
      canLaunch = await canLaunchUrl(emailUri);
      if (canLaunch) {
        await launchUrl(emailUri);
        developer.log('Successfully opened email app', name: 'EmailShare');
        return true;
      }
      
      // Try generic share as fallback
      try {
        // Use native share sheet as last resort
        final shareContent = '$message\n\n$url';
        await Share.share(
          shareContent,
          subject: subject ?? 'Shared Content',
        );
        
        developer.log('Falling back to generic share for email content', name: 'EmailShare');
        return true; // Assume success if no exception
      } catch (fallbackError) {
        developer.log('All email sharing methods failed: $fallbackError', name: 'EmailShare');
        return false;
      }
    } catch (e) {
      developer.log('Error sharing via email: $e', name: 'EmailShare');
      return false;
    }
  }

  /// Check if email sharing is available
  /// 
  /// Returns true if email app is available, false otherwise
  static Future<bool> isAvailable() async {
    try {
      // Check if email app is available
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: '',
      );
      
      return await canLaunchUrl(emailUri);
    } catch (e) {
      developer.log('Error checking email availability: $e', name: 'EmailShare');
      return false;
    }
  }

  /// Helper method to encode query parameters
  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
