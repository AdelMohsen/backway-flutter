import 'package:flutter/material.dart';
import 'package:greenhub/features/messages/ui/widgets/message_avatar.dart';
import 'package:greenhub/features/messages/ui/widgets/message_content.dart';
import 'package:greenhub/features/messages/ui/widgets/message_meta_data.dart';

class MessageItemWidget extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int unreadCount;
  final bool showStatus;
  final String? avatarUrl;
  final VoidCallback? onTap;

  const MessageItemWidget({
    Key? key,
    required this.name,
    required this.message,
    required this.time,
    required this.unreadCount,
    this.showStatus = false,
    this.avatarUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              offset: const Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Row(
          children: [
            MessageAvatar(showStatus: showStatus, avatarUrl: avatarUrl),
            const SizedBox(width: 8),
            Expanded(
              child: MessageContent(name: name, message: message),
            ),
            const SizedBox(width: 12),
            MessageMetaData(time: time, unreadCount: unreadCount),
          ],
        ),
      ),
    );
  }
}
