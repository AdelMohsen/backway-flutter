import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/features/negotiation_offers/ui/widgets/bottom_choice_services_type.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class NegotiationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int orderId;
  final String name;
  final String? avatarUrl;
  final String? phone;

  const NegotiationAppBar({
    super.key,
    required this.orderId,
    required this.name,
    this.avatarUrl,
    this.phone,
  });

  Future<void> _launchPhoneCall() async {
    if (phone != null && phone!.isNotEmpty) {
      final Uri callUri = Uri(scheme: 'tel', path: phone);
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,

      leading: Padding(
        padding: const EdgeInsets.only(right: 4.0, top: 4, bottom: 4, left: 4),
        child: InkWell(
          onTap: () => context.pop(),
          borderRadius: BorderRadius.circular(22),
          child: Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromRGBO(159, 159, 159, 1),
              size: 16,
            ),
          ),
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: avatarUrl != null && avatarUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: avatarUrl!,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      placeholder: (context, url) => Image.asset(
                        AppImages.imageCarriers,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        AppImages.imageCarriers,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(Icons.person_2_outlined),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.ibmPlexSansSize14w700Black.copyWith(
                color: const Color.fromRGBO(60, 60, 60, 1),
              ),
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: _launchPhoneCall,
              borderRadius: BorderRadius.circular(22),
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(4, 131, 114, 0.05),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SvgPicture.asset(AppSvg.callIcon),
                ),
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () {
                BottomChoiceServicesTypeBottomSheet.show(context, orderId: orderId);
              },
              borderRadius: BorderRadius.circular(22),
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: AppColors.primaryGreenHub,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
