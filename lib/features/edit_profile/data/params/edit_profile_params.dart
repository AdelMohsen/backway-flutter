import 'package:equatable/equatable.dart';

class EditProfileParams extends Equatable {
  const EditProfileParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
  });

  final String name;
  final String email;
  final String phone;
  final String gender;

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender,
    };
    map.removeWhere((key, value) => value == null || value == '');
    return map;
  }

  @override
  List<Object?> get props => [name, email, phone, gender];
}
