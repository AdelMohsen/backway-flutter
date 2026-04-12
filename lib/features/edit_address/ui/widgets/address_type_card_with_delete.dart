import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class AddressTypeCardWithDelete extends StatelessWidget {
  final String addressType;
  final String location;
  final Widget icon;
  final VoidCallback? onDeleteTap;

  const AddressTypeCardWithDelete({
    super.key,
    required this.addressType,
    required this.location,
    required this.icon,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        border: Border.all(color: const Color.fromRGBO(243, 243, 243, 1)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                // Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(247, 247, 247, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: icon,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Text Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        addressType,
                        style: AppTextStyles.ibmPlexSansSize16w600Black,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(4, 131, 114, 0.08),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.location_on_outlined,
                                size: 15,
                                color: Color(0xFF009688),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              location,
                              style: AppTextStyles.ibmPlexSansSize11w500Grey
                                  .copyWith(color: AppColors.kTitleText),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Delete Button (Left side in RTL)
          const SizedBox(width: 12),
          InkWell(
            onTap: onDeleteTap,
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 240, 240, 1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Center(
                child: Icon(
                  Icons.delete_outline,
                  size: 20,
                  color: Color(0xFFFF5252),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
