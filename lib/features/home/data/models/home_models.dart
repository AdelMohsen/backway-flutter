import 'dart:ui';

class OfferModel {
  final int id;
  final String title;
  final String image;
  final String discount;

  OfferModel({
    required this.id,
    required this.title,
    required this.image,
    required this.discount,
  });
}

class ServiceModel {
  final int id;
  final String title;
  final String image;
  final String description;
  final Color? buttonColor;
  final Color? buttonTextColor;

  ServiceModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    this.buttonColor,
    this.buttonTextColor,
  });
}
