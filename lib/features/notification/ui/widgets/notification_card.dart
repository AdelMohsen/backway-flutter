import 'package:flutter/material.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/text/main_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum NotificationType { offer, update, orderSuccess, message }

class NotificationCard extends StatelessWidget {
  final String title;
  final String? body;
  final String time;
  final NotificationType type;
  final String? orderId;
  final String? iconUrl;
  final VoidCallback? onTap;

  final bool isUnread;

  const NotificationCard({
    super.key,
    required this.title,
    this.body,
    required this.time,
    required this.type,
    this.orderId,
    this.iconUrl,
    this.isUnread = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(4, 131, 114, 0.04),
              offset: Offset(0, 2),
              blurRadius: 10,
            ),
          ],
          border: Border.all(
            color: const Color.fromRGBO(4, 131, 114, 0.04),
            width: 1,
          ),
          color: isUnread
              ? const Color.fromRGBO(4, 131, 114, 0.04)
              : Colors.white, // Light green tint if unread
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(247, 247, 247, 1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: _buildIcon(),
                  ),
                  const SizedBox(width: 12),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainText(
                          text: title,
                          style: AppTextStyles.ibmPlexSansSize12w600Grey
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 7),
                        MainText(
                          text: body ?? '',
                          style: AppTextStyles.cairoW400Size12.copyWith(
                            fontSize: 9,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 7),

                        if (orderId != null)
                          Row(
                            children: [
                              MainText(
                                text: 'رقم الطلب:',
                                style: AppTextStyles.ibmPlexSansSize11w500Grey
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(width: 4),
                              MainText(
                                text: orderId!,
                                style: AppTextStyles.ibmPlexSansSize11w500Grey
                                    .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.primaryGreenHub,
                                    ),
                              ),
                            ],
                          ),

                        const SizedBox(height: 8),

                        // Time
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(4, 131, 114, 0.08),
                              ),
                              child: const Icon(
                                Icons.access_time_rounded,
                                size: 14,
                                color: AppColors.teal,
                              ),
                            ),
                            const SizedBox(width: 6),
                            MainText(
                              text: time,
                              style: AppTextStyles.ibmPlexSansSize10w400
                                  .copyWith(
                                    fontSize: 8,
                                    color: const Color.fromRGBO(
                                      107,
                                      114,
                                      128,
                                      1,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isUnread)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: mainAppBloc.isArabic
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.kLightGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  static NotificationType resolveType(String? type) {
    switch (type) {
      case 'new_order':
        return NotificationType.orderSuccess;
      case 'offer':
        return NotificationType.offer;
      case 'new_message':
        return NotificationType.message;
      case 'update_order':
      case 'general':
      default:
        return NotificationType.update;
    }
  }

  Widget _buildIcon() {
    const String defaultIconUrl =
        'https://greenhub.sa-fvs.com/favicon-16x16.png';

    if (iconUrl != null && iconUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: iconUrl!,
        placeholder: (context, url) =>
            const CircularProgressIndicator(strokeWidth: 2),
        errorWidget: (context, url, error) =>
            CachedNetworkImage(imageUrl: defaultIconUrl),
      );
    }
    return _buildDefaultIcon();
  }

  Widget _buildDefaultIcon() {
    switch (type) {
      case NotificationType.offer:
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(AppSvg.notificationGift),
        );
      case NotificationType.update:
        return CachedNetworkImage(
          imageUrl: 'https://greenhub.sa-fvs.com/favicon-16x16.png',
          placeholder: (context, url) =>
              const CircularProgressIndicator(strokeWidth: 2),
          errorWidget: (context, url, error) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: SvgPicture.asset(AppSvg.notificationSettingsIcon),
          ),
        );
      case NotificationType.orderSuccess:
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(AppSvg.notificationDone),
        );
      case NotificationType.message:
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(AppSvg.massageIcon),
        );
    }
  }
}
