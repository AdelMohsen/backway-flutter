import 'package:equatable/equatable.dart';
import '../../address/data/models/address_model.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
    this.birthDate,
    this.gender,
    this.status,
    this.profilePictureUrl,
    this.avatarInitials,
    this.rating,
    this.totalRatings,
    this.walletBalance,
    this.createdAt,
    this.contractNotifications,
    this.quoteNotifications,
    this.promotionalNotifications,
    this.notificationsEnabled,
    this.defaultAddress,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final String token;
  final String? birthDate;
  final String? gender;
  final String? status;
  final String? profilePictureUrl;
  final String? avatarInitials;
  final String? rating;
  final num? totalRatings;
  final String? walletBalance;
  final String? createdAt;
  final bool? contractNotifications;
  final bool? quoteNotifications;
  final bool? promotionalNotifications;
  final bool? notificationsEnabled;
  final AddressModel? defaultAddress;

  UserEntity copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? token,
    String? birthDate,
    String? gender,
    String? status,
    String? profilePictureUrl,
    String? avatarInitials,
    String? rating,
    num? totalRatings,
    String? walletBalance,
    String? createdAt,
    bool? contractNotifications,
    bool? quoteNotifications,
    bool? promotionalNotifications,
    bool? notificationsEnabled,
    AddressModel? defaultAddress,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      token: token ?? this.token,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      avatarInitials: avatarInitials ?? this.avatarInitials,
      rating: rating ?? this.rating,
      totalRatings: totalRatings ?? this.totalRatings,
      walletBalance: walletBalance ?? this.walletBalance,
      createdAt: createdAt ?? this.createdAt,
      contractNotifications:
          contractNotifications ?? this.contractNotifications,
      quoteNotifications: quoteNotifications ?? this.quoteNotifications,
      promotionalNotifications:
          promotionalNotifications ?? this.promotionalNotifications,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      defaultAddress: defaultAddress ?? this.defaultAddress,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'token': token,
    'birth_date': birthDate,
    'gender': gender,
    'status': status,
    'profile_picture_url': profilePictureUrl,
    'avatar_initials': avatarInitials,
    'rating': rating,
    'total_ratings': totalRatings,
    'wallet_balance': walletBalance,
    'created_at': createdAt,
    'contract_notifications': contractNotifications,
    'quote_notifications': quoteNotifications,
    'promotional_notifications': promotionalNotifications,
    'notifications_enabled': notificationsEnabled,
    'default_address': defaultAddress?.toJson(),
  };

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    token,
    birthDate,
    gender,
    status,
    profilePictureUrl,
    avatarInitials,
    rating,
    totalRatings,
    walletBalance,
    createdAt,
    contractNotifications,
    quoteNotifications,
    promotionalNotifications,
    notificationsEnabled,
    defaultAddress,
  ];
}
