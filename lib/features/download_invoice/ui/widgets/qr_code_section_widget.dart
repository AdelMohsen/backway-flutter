import 'package:flutter/material.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

import 'package:cached_network_image/cached_network_image.dart';

class QrCodeSectionWidget extends StatelessWidget {
  final String? qrImagePath;

  const QrCodeSectionWidget({Key? key, this.qrImagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Generate a scannable QR code from the value provided by the API
    // This ensures that even if 'qrImagePath' is a plain value or a non-QR URL,
    // it will be rendered as a scannable QR code.
    final String qrData = qrImagePath ?? "";
    final String qrDisplayUrl =
        qrData.isNotEmpty &&
            qrData.startsWith('http') &&
            qrData.toLowerCase().contains('qr')
        ? qrData
        : "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=${Uri.encodeComponent(qrData.isEmpty ? "No Data" : qrData)}";

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          // Divider
          const Divider(color: Color.fromRGBO(247, 247, 247, 1), thickness: 1),
          const SizedBox(height: 16),
          // QR Label
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  AppStrings.qrCodeLabel.tr,
                  style: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
                    color: const Color.fromRGBO(107, 114, 128, 1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // QR Code Image
          Container(
            width: 75,
            height: 75,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFF0F0F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: qrData.isEmpty
                ? Image.asset(AppImages.qr, fit: BoxFit.contain)
                : CachedNetworkImage(
                    imageUrl: qrDisplayUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    errorWidget: (context, url, error) =>
                        Image.asset(AppImages.qr, fit: BoxFit.contain),
                  ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
