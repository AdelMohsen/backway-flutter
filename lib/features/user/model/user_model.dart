import '../../address/data/models/address_model.dart';
import '../entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.token,
    super.birthDate,
    super.gender,
    super.status,
    super.profilePictureUrl,
    super.avatarInitials,
    super.rating,
    super.totalRatings,
    super.walletBalance,
    super.createdAt,
    super.contractNotifications,
    super.quoteNotifications,
    super.promotionalNotifications,
    super.notificationsEnabled,
    super.defaultAddress,
  });

  /// Parse from /user endpoint response
  factory UserModel.fromJson(
    Map<String, dynamic> json, {
    required String token,
  }) {
    final data = json['data'];
    return UserModel(
      id: data['id'] as int,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      phone: data['phone'] as String? ?? '',
      token: token,
      birthDate: data['birth_date'] as String?,
      gender: data['gender'] as String?,
      status: data['status'] as String?,
      profilePictureUrl: data['profile_picture_url'] as String?,
      avatarInitials: data['avatar_initials'] as String?,
      rating: data['rating'] as String?,
      totalRatings: data['total_ratings'] as num?,
      walletBalance: data['wallet_balance'] as String?,
      createdAt: data['created_at'] as String?,
      contractNotifications: data['contract_notifications'] as bool?,
      quoteNotifications: data['quote_notifications'] as bool?,
      promotionalNotifications: data['promotional_notifications'] as bool?,
      notificationsEnabled: data['notifications_enabled'] as bool?,
      defaultAddress: data['default_address'] != null
          ? AddressModel.fromJson(
              data['default_address'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  /// Parse from login/register response (includes token in response)
  factory UserModel.fromAuthResponse(Map<String, dynamic> json) {
    final data = json['data'];
    return UserModel(
      id: data['id'] as int,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      phone: data['phone'] as String? ?? '',
      token: data['token'] as String? ?? '',
      birthDate: data['birth_date'] as String?,
      gender: data['gender'] as String?,
      status: data['status'] as String?,
      profilePictureUrl: data['profile_picture_url'] as String?,
      avatarInitials: data['avatar_initials'] as String?,
      rating: data['rating'] as String?,
      totalRatings: data['total_ratings'] as num?,
      walletBalance: data['wallet_balance'] as String?,
      createdAt: data['created_at'] as String?,
      contractNotifications: data['contract_notifications'] as bool?,
      quoteNotifications: data['quote_notifications'] as bool?,
      promotionalNotifications: data['promotional_notifications'] as bool?,
      notificationsEnabled: data['notifications_enabled'] as bool?,
      defaultAddress: data['default_address'] != null
          ? AddressModel.fromJson(
              data['default_address'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}
