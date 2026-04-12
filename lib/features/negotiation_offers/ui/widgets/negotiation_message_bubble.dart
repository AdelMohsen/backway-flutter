import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:greenhub/core/utils/widgets/misc/default_network_image.dart';
import 'package:greenhub/core/app_config/app_config.dart';

class NegotiationMessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final String? avatarUrl;
  final String? type;
  final String? attachmentUrl;

  const NegotiationMessageBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isMe,
    this.avatarUrl,
    this.type,
    this.attachmentUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: isMe
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMe) ...[
                Flexible(child: _buildBubble(context)),
                const SizedBox(width: 12),
                _buildAvatar(),
              ] else ...[
                Flexible(child: _buildBubble(context)),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(
              left: isMe ? 0 : 60, // Align text under bubble?
              right: isMe ? 0 : 0,
            ),

            child: Text(
              time,
              style: AppTextStyles.ibmPlexSansSize10w500White.copyWith(
                color: Color.fromRGBO(119, 119, 119, 1),
              ),
              textAlign: TextAlign.start,
            ),
          ),
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
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: avatarUrl != null && avatarUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: avatarUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Icon(Icons.person_2_outlined),
                errorWidget: (context, url, error) =>
                    Icon(Icons.person_2_outlined),
              )
            : Icon(Icons.person_2_outlined),
      ),
    );
  }

  Widget _buildBubble(BuildContext context) {
    Widget content;
    if (type == 'image' && attachmentUrl != null) {
      final baseUrl = AppConfig.BASE_URL.split('/api')[0];
      final fullUrl = '$baseUrl/storage/$attachmentUrl';
      content = GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(10),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  InteractiveViewer(
                    panEnabled: true,
                    minScale: 1.0,
                    maxScale: 4.0,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DefaultNetworkImage(fullUrl, fit: BoxFit.contain),
                    ),
                  ),
                  Positioned(
                    top: -10,
                    right: -10,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: 200,
            height: 200,
            child: DefaultNetworkImage(fullUrl, fit: BoxFit.cover),
          ),
        ),
      );
    } else {
      content = Text(
        message,
        style: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
          color: const Color.fromRGBO(60, 60, 60, 1),
        ),
        textAlign: TextAlign.right, // Arabic usually right aligned
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: isMe ? Color.fromRGBO(237, 255, 253, 1) : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: isMe ? const Radius.circular(20) : const Radius.circular(0),
          topRight: !isMe ? Radius.circular(20) : const Radius.circular(0),
          bottomLeft: !isMe
              ? const Radius.circular(20)
              : const Radius.circular(20),
          bottomRight: isMe
              ? const Radius.circular(20)
              : const Radius.circular(20),
        ),
        border: !isMe
            ? Border.all(color: Color.fromRGBO(242, 242, 242, 1))
            : Border.all(color: Color.fromRGBO(242, 242, 242, 1)),
        boxShadow: !isMe
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                ),
              ]
            : null,
      ),
      child: content,
    );
  }
}
