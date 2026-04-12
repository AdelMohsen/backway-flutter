import 'package:flutter/material.dart';

enum ChatStatus {
  active,
  completed,
  closed;

  static ChatStatus fromString(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
        return ChatStatus.active;
      case 'completed':
        return ChatStatus.completed;
      case 'closed':
        return ChatStatus.closed;
      default:
        return ChatStatus.active;
    }
  }

  String get displayName {
    switch (this) {
      case ChatStatus.active:
        return 'Active';
      case ChatStatus.completed:
        return 'Completed';
      case ChatStatus.closed:
        return 'Closed';
    }
  }

  String get displayNameAr {
    switch (this) {
      case ChatStatus.active:
        return 'نشط';
      case ChatStatus.completed:
        return 'مكتمل';
      case ChatStatus.closed:
        return 'مغلق';
    }
  }

  Color get statusColor {
    switch (this) {
      case ChatStatus.active:
        return const Color(0xFF4CAF50); // Green
      case ChatStatus.completed:
        return const Color(0xFF2196F3); // Blue
      case ChatStatus.closed:
        return const Color(0xFF9E9E9E); // Grey
    }
  }

  Color get statusBackgroundColor {
    switch (this) {
      case ChatStatus.active:
        return const Color(0xFFE8F5E9); // Light Green
      case ChatStatus.completed:
        return const Color(0xFFE3F2FD); // Light Blue
      case ChatStatus.closed:
        return const Color(0xFFF5F5F5); // Light Grey
    }
  }
}
