import 'package:equatable/equatable.dart';

class VerifyOtpThenLoginParams extends Equatable {
  const VerifyOtpThenLoginParams({
    required this.phoneNumber,
    required this.otp,
  });

  final String phoneNumber;
  final String otp;

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'phone': _normalizePhone(phoneNumber),
      'otp': otp,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  String _normalizePhone(String value) {
    // Remove spaces and dashes
    String cleaned = value.replaceAll(RegExp(r'[\s\-]'), '');

    // Remove leading + if present
    if (cleaned.startsWith('+')) {
      cleaned = cleaned.substring(1);
    }

    // Check if it contains only digits after cleaning
    if (!RegExp(r'^[0-9]+$').hasMatch(cleaned)) {
      return value;
    }

    // Normalize based on prefix pattern
    if (cleaned.startsWith('966')) {
      return cleaned;
    } else if (cleaned.startsWith('05')) {
      return '966${cleaned.substring(1)}';
    } else if (cleaned.startsWith('0')) {
      return '966${cleaned.substring(1)}';
    } else if (cleaned.startsWith('5')) {
      return '966$cleaned';
    }

    return '966$cleaned';
  }

  @override
  List<Object?> get props => [phoneNumber, otp];
}
