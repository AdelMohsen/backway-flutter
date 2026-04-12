import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String? email;
  final String? avatar;
  final String rating;
  final int totalRatings;
  final String walletBalance;

  const UserDataModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.rating,
    required this.totalRatings,
    required this.walletBalance,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    phone: json['phone'] ?? '',
    email: json['email'],
    avatar: json['avatar'],
    rating: json['rating'] ?? '0.00',
    totalRatings: json['total_ratings'] ?? 0,
    walletBalance: json['wallet_balance'] ?? '0.00',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'avatar': avatar,
    'rating': rating,
    'total_ratings': totalRatings,
    'wallet_balance': walletBalance,
  };

  @override
  List<Object?> get props => [
    id,
    name,
    phone,
    email,
    avatar,
    rating,
    totalRatings,
    walletBalance,
  ];
}
