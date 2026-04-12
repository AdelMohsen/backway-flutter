import 'package:equatable/equatable.dart';

class SocialLinksModel extends Equatable {
  final bool? success;
  final SocialLinksData? data;

  const SocialLinksModel({
    this.success,
    this.data,
  });

  factory SocialLinksModel.fromJson(Map<String, dynamic> json) {
    return SocialLinksModel(
      success: json['success'] as bool?,
      data: json['data'] != null ? SocialLinksData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }

  @override
  List<Object?> get props => [success, data];
}

class SocialLinksData extends Equatable {
  final String? title;
  final List<SocialLinkItem>? items;

  const SocialLinksData({
    this.title,
    this.items,
  });

  factory SocialLinksData.fromJson(Map<String, dynamic> json) {
    return SocialLinksData(
      title: json['title'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => SocialLinkItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'items': items?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [title, items];
}

class SocialLinkItem extends Equatable {
  final String? name;
  final String? url;

  const SocialLinkItem({
    this.name,
    this.url,
  });

  factory SocialLinkItem.fromJson(Map<String, dynamic> json) {
    return SocialLinkItem(
      name: json['name'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }

  @override
  List<Object?> get props => [name, url];
}
