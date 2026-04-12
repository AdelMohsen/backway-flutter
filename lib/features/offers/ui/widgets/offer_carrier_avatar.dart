import 'package:flutter/material.dart';
import 'package:greenhub/core/assets/app_images.dart';

class OfferCarrierAvatar extends StatelessWidget {
  final String? imageUrl;
  const OfferCarrierAvatar({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? Image.network(
              imageUrl!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.person, size: 50, color: Colors.grey);
              },
            )
          : Icon(Icons.person, size: 50, color: Colors.grey),
    );
  }
}
