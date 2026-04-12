import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class AddressCardWidget extends StatelessWidget {
  final String addressType;
  final String location;
  final Widget icon;
  final VoidCallback? onEditTap;
  final bool isDefault;

  const AddressCardWidget({
    super.key,
    required this.addressType,
    required this.location,
    required this.icon,
    this.onEditTap,
    this.isDefault = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        border: Border.all(
          color:
              isDefault
                  ? AppColors.primaryGreenHub
                  : const Color.fromRGBO(243, 243, 243, 1),
          width: isDefault ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Address Type and Location (Right side in RTL)
          Expanded(
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                // Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(247, 247, 247, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: icon,
                    ),
                  ),
                ),
                const SizedBox(width: 12), // Text Info
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
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        textDirection: TextDirection.rtl,
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(4, 131, 114, 0.08),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.location_on_outlined,
                                size: 12,
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
                              textAlign: TextAlign.start,
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
          // Edit Button (Left side in RTL)
          const SizedBox(width: 12),
          InkWell(
            onTap: onEditTap,
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Color.fromRGBO(247, 247, 247, 1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(AppSvg.edit4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
