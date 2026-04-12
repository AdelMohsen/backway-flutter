import 'package:flutter/material.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/utils/widgets/misc/zoom_image.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class ShipmentImagesWidget extends StatelessWidget {
  final List<String> images;

  const ShipmentImagesWidget({Key? key, required this.images})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            offset: Offset(0, 4),
            blurRadius: 18,
          ),
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.shipmentImages.tr,
            style: AppTextStyles.ibmPlexSansSize16w600Black.copyWith(
              color: AppColors.kTitleText,
            ),
          ),
          const SizedBox(height: 4),
          const Divider(color: Color.fromRGBO(247, 247, 247, 1), thickness: 1),
          const SizedBox(height: 12),
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ZoomImageScreen(urlImage: images[index]),
                      ),
                    );
                  },
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: const Color.fromRGBO(240, 240, 240, 1),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
