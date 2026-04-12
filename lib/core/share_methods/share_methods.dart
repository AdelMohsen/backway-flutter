/// Share Methods Module
/// 
/// This module provides platform-specific sharing functionality for various
/// social media platforms and messaging apps. Each platform has its own
/// dedicated implementation to handle the specific requirements and limitations
/// of that platform's sharing API.
/// 
/// Usage:
/// ```dart
/// import 'package:mutamd/core/share_methods/share_methods.dart';
/// 
/// // Share to WhatsApp
/// await WhatsAppShare.shareToWhatsApp(
///   message: 'Check this out!',
///   url: 'https://example.com',
/// );
/// 
/// // Share to Facebook
/// await FacebookShare.shareToFacebook(
///   message: 'Amazing content',
///   url: 'https://example.com',
/// );
/// ```
library;

// Platform-specific share methods
export 'whatsapp_share.dart';
export 'instagram_share.dart';
export 'facebook_share.dart';
export 'snapchat_share.dart';
export 'generic_share.dart';
export 'email_share.dart';
export 'sms_share.dart';

/// Enum for supported sharing platforms
enum SharePlatform {
  whatsapp,
  instagram,
  facebook,
  snapchat,
  email,
  sms,
  generic,
}

/// Extension to get platform display names
extension SharePlatformExtension on SharePlatform {
  String get displayName {
    switch (this) {
      case SharePlatform.whatsapp:
        return 'WhatsApp';
      case SharePlatform.instagram:
        return 'Instagram';
      case SharePlatform.facebook:
        return 'Facebook';
      case SharePlatform.snapchat:
        return 'Snapchat';
      case SharePlatform.email:
        return 'Email';
      case SharePlatform.sms:
        return 'SMS';
      case SharePlatform.generic:
        return 'Share';
    }
  }

  String get identifier {
    switch (this) {
      case SharePlatform.whatsapp:
        return 'whatsapp';
      case SharePlatform.instagram:
        return 'instagram';
      case SharePlatform.facebook:
        return 'facebook';
      case SharePlatform.snapchat:
        return 'snapchat';
      case SharePlatform.email:
        return 'email';
      case SharePlatform.sms:
        return 'sms';
      case SharePlatform.generic:
        return 'generic';
    }
  }
}
