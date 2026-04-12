import 'dart:developer' as developer;
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';

/// Generic sharing functionality
/// 
/// This module provides fallback sharing functionality using the native
/// share dialog when platform-specific sharing is not available.
class GenericShare {
  /// Share content using the native share dialog
  /// 
  /// [message] - Optional custom message to share
  /// [url] - Deep link URL to include in the message
  /// [sharePositionOrigin] - Optional position for iPad share popover
  /// 
  /// Returns true if sharing was successful, false otherwise
  static Future<bool> shareGeneric({
    String? message,
    required String url,
    Rect? sharePositionOrigin,
  }) async {
    try {
      // Construct the complete message with URL
      final String fullMessage = message != null 
          ? '$message\n\n$url'
          : url;
      
      developer.log(
        'Sharing via native dialog: message=${message ?? 'none'}, url=$url',
        name: 'GenericShare',
      );
      
      // Use the native share dialog
      await Share.share(
        fullMessage,
        sharePositionOrigin: sharePositionOrigin,
      );
      
      // Since Share.share doesn't return a result in older versions,
      // we assume success if no exception was thrown
      developer.log('Successfully shared via native dialog', name: 'GenericShare');
      return true;
    } catch (e) {
      developer.log('Error sharing via native dialog: $e', name: 'GenericShare');
      return false;
    }
  }

  /// Share content with just the URL (no custom message)
  /// 
  /// [url] - Deep link URL to share
  /// [sharePositionOrigin] - Optional position for iPad share popover
  /// 
  /// Returns true if sharing was successful, false otherwise
  static Future<bool> shareUrl({
    required String url,
    Rect? sharePositionOrigin,
  }) async {
    return await shareGeneric(
      url: url,
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  /// Check if native sharing is available
  /// 
  /// Returns true (native sharing is always available)
  static Future<bool> isAvailable() async {
    // Native sharing is always available on mobile platforms
    return true;
  }
}
