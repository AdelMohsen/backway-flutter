import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/features/orders/data/models/orders_model.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';

class DetailsOrder extends StatelessWidget {
  final OrderModel order;
  final int tabIndex;
  const DetailsOrder({super.key, required this.order, required this.tabIndex});

  String _getVehicleTypeName() {
    // 1. Check root order vehicle type first
    if (order.vehicleType != null) {
      return (mainAppBloc.isArabic
              ? order.vehicleType?.nameAr
              : order.vehicleType?.nameEn) ??
          order.vehicleType?.name ??
          '';
    }

    // 2. Return empty if the API does not provide a specific vehicle type for the order
    // to avoid displaying an incorrect random vehicle from the driver's list.
    return '';
  }

  @override
  Widget build(BuildContext context) {
    String timeDifferenceText = '--';

    if (order.createdAt != null && order.acceptedAt != null) {
      try {
        final created = DateTime.parse(order.createdAt!);
        final accepted = DateTime.parse(order.acceptedAt!);
        final difference = accepted.difference(created);

        if (difference.inMinutes > 0) {
          timeDifferenceText =
              '${difference.inMinutes} ${AppStrings.minutes.tr}';
        } else {
          timeDifferenceText = '0 ${AppStrings.minutes.tr}';
        }
      } catch (e) {
        // Fallback to '--' if parsing fails
      }
    }

    switch (tabIndex) {
      case 0: // Scheduled - Under Process
        return const SizedBox.shrink();

      case 1: // In Transit - In Delivery
      case 2: // Previous - Delivered
      default:
        return _buildChipsRow([
          _buildInfoChip(
            icon: SvgPicture.asset(AppSvg.clock),
            textStyle: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
              color: AppColors.kBlack,
            ),
            title: timeDifferenceText,
            subTitle: const SizedBox.shrink(),
          ),
          _buildInfoChip(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(AppSvg.vector3),
            ),
            title: order.pricing?.finalPrice ?? '',
            subTitle: SvgPicture.asset(
              width: 16,
              height: 16,
              AppSvg.riyal,
              colorFilter: const ColorFilter.mode(
                Color.fromRGBO(184, 184, 184, 1),
                BlendMode.srcIn,
              ),
            ),
          ),
          _buildInfoChip(
            icon: SvgPicture.asset(AppSvg.vector4),
            title: _getVehicleTypeName(),
            textStyle: GoogleFonts.mada(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.kPrimaryBlack,
            ),
          ),
          _buildInfoChip(
            icon: SvgPicture.asset(AppSvg.vector5),
            title: order.package?.size?.label ?? '',
            textStyle: GoogleFonts.mada(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.kPrimaryBlack,
            ),
          ),
        ]);
    }
  }

  Widget _buildChipsRow(List<Widget?> chipList) {
    final chips = chipList.whereType<Widget>().toList();
    if (chips.isEmpty) return const SizedBox.shrink();

    final children = <Widget>[];
    for (int i = 0; i < chips.length; i++) {
      children.add(chips[i]);
      if (i != chips.length - 1) {
        children.add(const SizedBox(width: 18));
      }
    }

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget? _buildInfoChip({
    required Widget icon,
    required String title,
    TextStyle? textStyle,
    Widget? subTitle,
  }) {
    if (title.trim().isEmpty || title == '--') return null;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.primaryGreenHub.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: icon,
        ),
        const SizedBox(width: 4),
        Row(
          children: [
            Text(title, style: textStyle, overflow: TextOverflow.ellipsis),
            if (subTitle != null) ...[const SizedBox(width: 3), subTitle],
          ],
        ),
      ],
    );
  }
}
