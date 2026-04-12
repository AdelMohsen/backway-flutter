import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import '../share_methods/share_methods.dart';

/// Reusable ShareService for handling platform-specific sharing
/// 
/// This service provides a unified interface for sharing content across
/// different social media platforms and messaging apps. It automatically
/// selects the appropriate platform-specific sharing method and handles
/// fallbacks gracefully.
/// 
/// Usage:
/// ```dart
/// // Share to a specific platform
/// await ShareService.share(
///   message: 'Check out this transaction!',
///   url: 'myapp://transaction/share?id=123',
///   platform: SharePlatform.whatsapp,
/// );
/// 
/// // Share with generic dialog
/// await ShareService.share(
///   url: 'myapp://transaction/share?id=123',
///   platform: SharePlatform.generic,
/// );
/// ```
class ShareService {
  /// Share content to a specific platform
  /// 
  /// [message] - Optional custom message to include with the share
  /// [url] - Required deep link URL to share
  /// [platform] - Target platform enum (SharePlatform.whatsapp, SharePlatform.instagram, etc.)
  /// [sharePositionOrigin] - Optional position for iPad share popover (generic sharing only)
  /// 
  /// Returns true if sharing was successful, false otherwise
  static Future<bool> share({
    String? message,
    required String url,
    required SharePlatform platform,
    Rect? sharePositionOrigin,
  }) async {
    try {
      developer.log(
        'ShareService.share called: platform=${platform.name}, message=${message ?? 'none'}, url=$url',
        name: 'ShareService',
      );

      // Route to appropriate platform-specific sharing method
      // ignore: exhaustive_cases
      switch (platform) {
        case SharePlatform.whatsapp:
          return await WhatsAppShare.shareToWhatsApp(
            message: message,
            url: url,
          );

        case SharePlatform.instagram:
          return await InstagramShare.shareToInstagram(
            message: message,
            url: url,
          );
          
        case SharePlatform.email:
          return await EmailShare.shareToEmail(
            message: message,
            url: url,
          );
          
        case SharePlatform.sms:
          return await SMSShare.shareToSms(
            message: message,
            url: url,
          );

        case SharePlatform.facebook:
          return await FacebookShare.shareToFacebook(
            message: message,
            url: url,
          );

        case SharePlatform.snapchat:
          return await SnapchatShare.shareToSnapchat(
            message: message,
            url: url,
          );

        case SharePlatform.generic:
          // Fallback to generic sharing
          developer.log(
            'Using generic sharing for platform: ${platform.name}',
            name: 'ShareService',
          );
          return await GenericShare.shareGeneric(
            message: message,
            url: url,
            sharePositionOrigin: sharePositionOrigin,
          );
      }
    } catch (e) {
      developer.log(
        'Error in ShareService.share: $e',
        name: 'ShareService',
      );
      return false;
    }
  }

  /// Share content to WhatsApp specifically
  /// 
  /// [message] - Optional custom message
  /// [url] - Deep link URL to share
  /// [phoneNumber] - Optional specific phone number to share to
  /// 
  /// Returns true if sharing was successful, false otherwise
  static Future<bool> shareToWhatsApp({
    String? message,
    required String url,
    String? phoneNumber,
  }) async {
    return await WhatsAppShare.shareToWhatsApp(
      message: message,
      url: url,
      phoneNumber: phoneNumber,
    );
  }

  /// Share content to Instagram specifically
  /// 
  /// [message] - Optional custom message
  /// [url] - Deep link URL to share
  /// 
  /// Returns true if sharing was successful, false otherwise
  static Future<bool> shareToInstagram({
    String? message,
    required String url,
  }) async {
    return await InstagramShare.shareToInstagram(
      message: message,
      url: url,
    );
  }

  /// Share content to Facebook specifically
  /// 
  /// [message] - Optional custom message
  /// [url] - Deep link URL to share
  /// 
  /// Returns true if sharing was successful, false otherwise
  static Future<bool> shareToFacebook({
    String? message,
    required String url,
  }) async {
    return await FacebookShare.shareToFacebook(
      message: message,
      url: url,
    );
  }

  /// Share content to Snapchat specifically
  /// 
  /// [message] - Optional custom message
  /// [url] - Deep link URL to share
  /// 
  /// Returns true if sharing was successful, false otherwise
  static Future<bool> shareToSnapchat({
    String? message,
    required String url,
  }) async {
    return await SnapchatShare.shareToSnapchat(
      message: message,
      url: url,
    );
  }

  /// Share using the generic native share dialog
  /// 
  /// [message] - Optional custom message
  /// [url] - Deep link URL to share
  /// [sharePositionOrigin] - Optional position for iPad share popover
  /// 
  /// Returns true if sharing was successful, false otherwise
  static Future<bool> shareGeneric({
    String? message,
    required String url,
    Rect? sharePositionOrigin,
  }) async {
    return await GenericShare.shareGeneric(
      message: message,
      url: url,
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  /// Check if a specific platform is available on the device
  /// 
  /// [platform] - SharePlatform enum to check
  /// 
  /// Returns true if the platform is available, false otherwise
  static Future<bool> isPlatformAvailable(SharePlatform platform) async {
    try {
      switch (platform) {
        case SharePlatform.whatsapp:
          return await WhatsAppShare.isAvailable();
        case SharePlatform.instagram:
          return await InstagramShare.isAvailable();
        case SharePlatform.facebook:
          return await FacebookShare.isAvailable();
        case SharePlatform.snapchat:
          return await SnapchatShare.isAvailable();
        case SharePlatform.email:
          return await EmailShare.isAvailable();
        case SharePlatform.sms:
          return await SMSShare.isAvailable();
        case SharePlatform.generic:
          return await GenericShare.isAvailable();
      }
    } catch (e) {
      developer.log(
        'Error checking platform availability for $platform: $e',
        name: 'ShareService',
      );
      return false;
    }
  }

  /// Get a list of available platforms on the current device
  /// 
  /// Returns a list of platform identifiers that are available
  static Future<List<String>> getAvailablePlatforms() async {
    final List<String> availablePlatforms = [];
    
    final List<SharePlatform> allPlatforms = [
      SharePlatform.whatsapp,
      SharePlatform.instagram,
      SharePlatform.facebook,
      SharePlatform.snapchat,
      SharePlatform.email,
      SharePlatform.sms,
      SharePlatform.generic,
    ];

    for (final SharePlatform platform in allPlatforms) {
      if (await isPlatformAvailable(platform)) {
        availablePlatforms.add(platform.name);
      }
    }

    developer.log(
      'Available platforms: $availablePlatforms',
      name: 'ShareService',
    );

    return availablePlatforms;
  }

  /// Get platform display name
  /// 
  /// [platform] - SharePlatform enum 
  /// 
  /// Returns human-readable platform name
  /// Share content to Email specifically
  /// 
  /// [message] - Optional custom message
  /// [url] - Deep link URL to share
  /// [subject] - Optional email subject line
  /// [recipient] - Optional email recipient address
  /// 
  /// Returns true if sharing was successful, false otherwise
  static Future<bool> shareToEmail({
    String? message,
    required String url,
    String? subject,
    String? recipient,
  }) async {
    return await EmailShare.shareToEmail(
      message: message,
      url: url,
      subject: subject,
      recipient: recipient,
    );
  }

  /// Share content to SMS specifically
  /// 
  /// [message] - Optional custom message
  /// [url] - Deep link URL to share
  /// [phoneNumber] - Optional phone number to send SMS to
  /// 
  /// Returns true if sharing was successful, false otherwise
  static Future<bool> shareToSms({
    String? message,
    required String url,
    String? phoneNumber,
  }) async {
    return await SMSShare.shareToSms(
      message: message,
      url: url,
      phoneNumber: phoneNumber,
    );
  }

  /// Get platform display name
  /// 
  /// [platform] - SharePlatform enum 
  /// 
  /// Returns human-readable platform name
  static String getPlatformDisplayName(SharePlatform platform) {
    switch (platform) {
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
}
