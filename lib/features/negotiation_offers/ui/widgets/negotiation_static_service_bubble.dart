import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class NegotiationStaticServiceBubble extends StatelessWidget {
  final String? avatarUrl;
  final String time;
  final bool isMe;
  final String serviceType;
  final String message;

  const NegotiationStaticServiceBubble({
    super.key,
    this.avatarUrl,
    required this.time,
    required this.isMe,
    required this.serviceType,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildBubble(context),
                  const SizedBox(height: 12),
                  Text(
                    time,
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _buildAvatar(),
          ] else ...[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBubble(context),
                  const SizedBox(height: 12),
                  Text(
                    time,
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: avatarUrl != null && avatarUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: avatarUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Icon(Icons.person, color: Colors.grey),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.person, color: Colors.grey),
              )
            : const Icon(Icons.person, color: Colors.grey),
      ),
    );
  }

  Widget _buildBubble(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.fromRGBO(237, 255, 253, 1),
        borderRadius: BorderRadius.only(
          topLeft: isMe ? const Radius.circular(20) : const Radius.circular(0),
          topRight: const Radius.circular(0),
          bottomLeft: !isMe
              ? const Radius.circular(20)
              : const Radius.circular(20),
          bottomRight: isMe
              ? const Radius.circular(20)
              : const Radius.circular(20),
        ),
        border: Border.all(
          color: const Color.fromRGBO(225, 233, 239, 1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Bell is first so it appears on the Right in RTL layout
          SvgPicture.asset(AppSvg.bell, width: 32, height: 32),
          const SizedBox(width: 10),
          // Texts Column
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.isNotEmpty ? message : 'طلب إضافة خدمة $serviceType',
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(195, 194, 200, 1),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  serviceType,
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryGreenHub,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
