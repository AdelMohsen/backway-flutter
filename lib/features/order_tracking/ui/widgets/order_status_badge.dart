import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class OrderStatusBadge extends StatelessWidget {
  final String status;

  const OrderStatusBadge({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _getStatusColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getStatusIcon(), size: 16, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            _getStatusText(),
            style: AppTextStyles.ibmPlexSansSize12w500Title.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case 'driver_on_way_to_pickup':
      case 'arrived_at_pickup':
      case 'picked_up':
      case 'on_delivery':
      case 'arrived_at_delivery':
        return const Color.fromRGBO(255, 152, 0, 1); // Orange
      case 'delivered':
        return const Color.fromRGBO(76, 175, 80, 1); // Green
      case 'cancelled':
        return Colors.red;
      case 'pending':
        return const Color.fromRGBO(158, 158, 158, 1); // Gray
      default:
        return const Color.fromRGBO(255, 152, 0, 1);
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case 'driver_on_way_to_pickup':
      case 'arrived_at_pickup':
      case 'picked_up':
      case 'on_delivery':
      case 'arrived_at_delivery':
        return Icons.local_shipping;
      case 'delivered':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      case 'pending':
        return Icons.schedule;
      default:
        return Icons.local_shipping;
    }
  }

  String _getStatusText() {
    switch (status) {
      case 'driver_on_way_to_pickup':
        return 'السائق في الطريق للاستلام';
      case 'arrived_at_pickup':
        return 'السائق في موقع الاستلام';
      case 'picked_up':
        return 'تم الاستلام';
      case 'on_delivery':
        return 'في الطريق للتسليم';
      case 'arrived_at_delivery':
        return 'السائق في موقع التسليم';
      case 'delivered':
        return 'تم التسليم';
      case 'cancelled':
        return 'ملغي';
      case 'pending':
        return 'قيد الانتظار';
      default:
        return 'قيد التسليم';
    }
  }
}
