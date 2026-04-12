import 'package:flutter/material.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../../utils/widgets/misc/default_network_image.dart';
import '../models/notification_model.dart';

class InAppNotificationWidget extends StatefulWidget {
  final NotificationModel notification;
  final VoidCallback onDismiss;
  final VoidCallback onTap;

  const InAppNotificationWidget({
    super.key,
    required this.notification,
    required this.onDismiss,
    required this.onTap,
  });

  @override
  State<InAppNotificationWidget> createState() =>
      _InAppNotificationWidgetState();
}

class _InAppNotificationWidgetState extends State<InAppNotificationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _dismiss() async {
    await _animationController.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Notification Icon/Image
                    _buildNotificationIcon(),
                    const SizedBox(width: 12),

                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.notification.title != null)
                            Text(
                              widget.notification.title!,
                              style: AppTextStyles.bodySmMedium.copyWith(
                                color: AppColors.kBlack,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          if (widget.notification.body != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              widget.notification.body!,
                              style: AppTextStyles.bodySmMedium.copyWith(
                                color: AppColors.kBlack,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Dismiss Button
                    GestureDetector(
                      onTap: _dismiss,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: AppColors.kBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon() {
    // If notification has image, show it
    if (widget.notification.hasImage) {
      // return ClipRRect(
      //   borderRadius: BorderRadius.circular(8),
      //   child: DefaultNetworkImage(
      //     widget.notification.imageUrl!,
      //     width: 48,
      //     height: 48,
      //   ),
      // );
    }

    // Show default icon
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: _getNotificationColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Icon(
          Icons.notifications_rounded,
          size: 24,
          color: _getNotificationColor(),
        ),
      ),
    );
  }

  Color _getNotificationColor() {
    switch (widget.notification.type?.toLowerCase()) {
      case 'booking':
      case 'order':
        return Colors.blue;
      case 'service':
        return AppColors.kPrimary;
      case 'package':
        return AppColors.kPrimary;
      case 'payment':
        return Colors.green;
      case 'promotion':
        return Colors.orange;
      case 'favourite':
        return Colors.red;
      case 'cart':
        return AppColors.kPrimary;
      case 'provider':
        return Colors.purple;
      case 'alert':
        return Colors.red;
      default:
        return AppColors.kPrimary;
    }
  }
}
