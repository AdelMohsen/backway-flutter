import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  const LoginParams({required this.phoneNumber});

  final String phoneNumber;

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {'phone': _normalizeEmailOrPhone(phoneNumber)};
    map.removeWhere((key, value) => value == null);
    return map;
  }

  String _normalizeEmailOrPhone(String value) {
    // Remove spaces and dashes
    String cleaned = value.replaceAll(RegExp(r'[\s\-]'), '');

    // Remove leading + if present
    if (cleaned.startsWith('+')) {
      cleaned = cleaned.substring(1);
    }

    // Check if it's all digits (phone number) or contains @ (email)
    if (cleaned.contains('@')) {
      // It's an email, return original
      return value;
    }

    // Check if it contains only digits after cleaning
    if (!RegExp(r'^[0-9]+$').hasMatch(cleaned)) {
      // Contains non-digit characters (other than + which was removed), return original
      return value;
    }

    // Normalize based on prefix pattern
    if (cleaned.startsWith('966')) {
      // Already has country code: 966XXXXXXXXX -> return as is
      return cleaned;
    } else if (cleaned.startsWith('05')) {
      // Local format with leading zero: 05XXXXXXXX -> 9665XXXXXXXX
      return '966${cleaned.substring(1)}';
    } else if (cleaned.startsWith('0')) {
      // Just starts with 0 but not 05, remove leading 0 and add 966
      return '966${cleaned.substring(1)}';
    } else if (cleaned.startsWith('5')) {
      // Direct format: 5XXXXXXXX -> 9665XXXXXXXX
      return '966$cleaned';
    }

    // Other digit-only input, add 966 prefix
    return '966$cleaned';
  }

  @override
  List<Object?> get props => [phoneNumber];
}
