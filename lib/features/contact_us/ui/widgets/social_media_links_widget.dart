import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/shimmer/custom_shimmer.dart';
import 'package:greenhub/features/contact_us/logic/cubit/social_links_cubit.dart';
import 'package:greenhub/features/contact_us/logic/state/social_links_state.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaLinksWidget extends StatelessWidget {
  const SocialMediaLinksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialLinksCubit, SocialLinksState>(
      builder: (context, state) {
        if (state is SocialLinksLoading) {
          return _buildLoadingState();
        } else if (state is SocialLinksSuccess) {
          final data = state.data.data;
          if (data == null || data.items == null || data.items!.isEmpty) {
            return const SizedBox.shrink();
          }
          return Column(
            children: [
              _buildTitle(data.title ?? ""),
              const SizedBox(height: 20),
              ...data.items!.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: _buildSocialCard(
                    item.name ?? "",
                    item.name?.toLowerCase() ?? "",
                    item.url ?? "",
                  ),
                ),
              ),
            ],
          );
        } else if (state is SocialLinksError) {
          // Fallback to static if error or just show empty
          return _buildStaticContent();
        }
        return _buildStaticContent();
      },
    );
  }

  Widget _buildTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.ibmPlexSansSize16w700Black.copyWith(),
          ),
        ),
      ],
    );
  }

  Widget _buildStaticContent() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppStrings.followUsOn.tr,
                    style: AppTextStyles.ibmPlexSansSize16w700Black.copyWith(),
                  ),
                  TextSpan(
                    text: AppStrings.socialMedia.tr,
                    style: AppTextStyles.ibmPlexSansSize16w700Black.copyWith(
                      color: AppColors.primaryGreenHub,
                    ),
                  ),
                  const TextSpan(text: ' 📱📢', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildSocialCard(AppStrings.instagram.tr, 'instagram', ''),
        const SizedBox(height: 15),
        _buildSocialCard(AppStrings.facebook.tr, 'facebook', ''),
        const SizedBox(height: 15),
        _buildSocialCard(AppStrings.tiktok.tr, 'tiktok', ''),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: [
        const CustomShimmerContainer(height: 25, width: 200),
        const SizedBox(height: 20),
        const CustomShimmerContainer(height: 60),
        const SizedBox(height: 15),
        const CustomShimmerContainer(height: 60),
        const SizedBox(height: 15),
        const CustomShimmerContainer(height: 60),
      ],
    );
  }

  Widget _buildSocialCard(String title, String name, String url) {
    final Color bgColor = _getBgColor(name, url);
    return InkWell(
      onTap: url.isNotEmpty ? () => _launchURL(url) : null,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.ibmPlexSansSize10w600White.copyWith(
                fontSize: 12,
                color: AppColors.kBlack,
              ),
            ),
            _getSocialIcon(name, url),
          ],
        ),
      ),
    );
  }

  Widget _getSocialIcon(String name, String url) {
    String iconPath = AppImages.instagram; // Default
    if (name.contains('facebook') ||
        name.contains('فيسبوك') ||
        url.contains('facebook')) {
      iconPath = AppImages.facebook;
    } else if (name.contains('tiktok') ||
        name.contains('تيك توك') ||
        url.contains('tiktok')) {
      iconPath = AppImages.tiktok;
    } else if (name.contains('instagram') ||
        name.contains('انستجرام') ||
        url.contains('instagram')) {
      iconPath = AppImages.instagram;
    }
    return Image.asset(iconPath, width: 35, height: 35);
  }

  Color _getBgColor(String name, String url) {
    if (name.contains('facebook') ||
        name.contains('فيسبوك') ||
        url.contains('facebook')) {
      return const Color(0xFFF4F9FF);
    } else if (name.contains('tiktok') ||
        name.contains('تيك توك') ||
        url.contains('tiktok')) {
      return const Color.fromRGBO(255, 238, 243, 1);
    } else if (name.contains('instagram') ||
        name.contains('انستجرام') ||
        url.contains('instagram')) {
      return const Color(0xFFFBF4FF);
    }
    return Colors.grey[100]!;
  }

  Future<void> _launchURL(String? url) async {
    if (url == null || url.trim().isEmpty) return;
    final Uri uri = Uri.parse(url.trim());
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching $url: $e');
    }
  }
}
