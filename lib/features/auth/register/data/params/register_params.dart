import 'package:equatable/equatable.dart';

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.name,
    required this.phone,
    required this.email,
    required this.currentLat,
    required this.currentLng,
    required this.address,
  });

  final String name;
  final String phone;
  final String email;
  final String currentLat;
  final String currentLng;
  final String address;

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'name': name,
      'phone': _normalizePhone(phone),
      'email': email,
      'current_lat': currentLat,
      'current_lng': currentLng,
      'address': address,
    };
    map.removeWhere((key, value) => value == null || value == '');
    return map;
  }

  String _normalizePhone(String value) {
    String cleaned = value.replaceAll(RegExp(r'[\s\-]'), '');

    if (cleaned.startsWith('+')) {
      cleaned = cleaned.substring(1);
    }

    if (cleaned.contains('@')) {
      return value;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(cleaned)) {
      return value;
    }

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
  List<Object?> get props => [
    name,
    phone,
    email,
    currentLat,
    currentLng,
    address,
  ];
}
