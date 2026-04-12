import 'package:equatable/equatable.dart';

class AppSettingsModel extends Equatable {
  final AppSettingsData data;

  const AppSettingsModel({required this.data});

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) =>
      AppSettingsModel(data: AppSettingsData.fromJson(json['data'] ?? {}));

  @override
  List<Object?> get props => [data];
}

class AppSettingsData extends Equatable {
  final StaticPages staticPages;
  final SocialMedia socialMedia;
  final ContactInfo contact;
  final AppInfo appInfo;

  const AppSettingsData({
    required this.staticPages,
    required this.socialMedia,
    required this.contact,
    required this.appInfo,
  });

  factory AppSettingsData.fromJson(Map<String, dynamic> json) =>
      AppSettingsData(
        staticPages: StaticPages.fromJson(json['static_pages'] ?? {}),
        socialMedia: SocialMedia.fromJson(json['social_media'] ?? {}),
        contact: ContactInfo.fromJson(json['contact'] ?? {}),
        appInfo: AppInfo.fromJson(json['app_info'] ?? {}),
      );

  @override
  List<Object?> get props => [staticPages, socialMedia, contact, appInfo];
}

class StaticPages extends Equatable {
  final String aboutUs;
  final String terms;
  final String privacy;

  const StaticPages({
    required this.aboutUs,
    required this.terms,
    required this.privacy,
  });

  factory StaticPages.fromJson(Map<String, dynamic> json) => StaticPages(
    aboutUs: json['about_us'] ?? '',
    terms: json['terms'] ?? '',
    privacy: json['privacy'] ?? '',
  );

  @override
  List<Object?> get props => [aboutUs, terms, privacy];
}

class SocialMedia extends Equatable {
  final String facebook;
  final String twitter;
  final String instagram;
  final String linkedin;
  final String tiktok;
  final String snapchat;
  final String youtube;

  const SocialMedia({
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.linkedin,
    required this.tiktok,
    required this.snapchat,
    required this.youtube,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
    facebook: json['facebook'] ?? '',
    twitter: json['twitter'] ?? '',
    instagram: json['instagram'] ?? '',
    linkedin: json['linkedin'] ?? '',
    tiktok: json['tiktok'] ?? '',
    snapchat: json['snapchat'] ?? '',
    youtube: json['youtube'] ?? '',
  );

  @override
  List<Object?> get props => [
    facebook,
    twitter,
    instagram,
    linkedin,
    tiktok,
    snapchat,
    youtube,
  ];
}

class ContactInfo extends Equatable {
  final String phone;
  final String whatsapp;
  final String email;
  final String address;

  const ContactInfo({
    required this.phone,
    required this.whatsapp,
    required this.email,
    required this.address,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
    phone: json['phone'] ?? '',
    whatsapp: json['whatsapp'] ?? '',
    email: json['email'] ?? '',
    address: json['address'] ?? '',
  );

  @override
  List<Object?> get props => [phone, whatsapp, email, address];
}

class AppInfo extends Equatable {
  final String name;
  final String logo;

  const AppInfo({required this.name, required this.logo});

  factory AppInfo.fromJson(Map<String, dynamic> json) =>
      AppInfo(name: json['name'] ?? '', logo: json['logo'] ?? '');

  @override
  List<Object?> get props => [name, logo];
}
