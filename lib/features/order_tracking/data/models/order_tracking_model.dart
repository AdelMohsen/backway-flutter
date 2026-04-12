import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/features/order_tracking/data/models/tracking_model.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

// Note: We'll keep DriverInfo and DeliveryStatus here or in separate file, but for now we adapt existing classes.

class DeliveryStatus {
  final String title;
  final String? subtitle;
  final DateTime? timestamp;
  final bool isCompleted;
  final bool isCurrent;

  DeliveryStatus({
    required this.title,
    this.subtitle,
    this.timestamp,
    required this.isCompleted,
    this.isCurrent = false,
  });
}

class StatusMapper {
  static final List<String> orderedStatuses = [
    'driver_on_way_to_pickup',
    'arrived_at_pickup',
    'picked_up',
    'on_delivery',
    'arrived_at_delivery',
    'delivered',
  ];

  static String getLabelForStatus(String key) {
    switch (key) {
      case 'driver_on_way_to_pickup':
        return AppStrings.driverOnWayToPickup.tr;
      case 'arrived_at_pickup':
        return AppStrings.arrivedAtPickup.tr;
      case 'picked_up':
        return AppStrings.pickedUp.tr;
      case 'on_delivery':
        return AppStrings.onDelivery.tr;
      case 'arrived_at_delivery':
        return AppStrings.arrivedAtDelivery.tr;
      case 'delivered':
        return AppStrings.deliveredStatus.tr;
      case 'cancelled':
        return AppStrings.cancelledStatus.tr;
      default:
        return AppStrings.underProcess.tr; // Default fallback
    }
  }

  static List<DeliveryStatus> mapStatusToHistory(TrackingModel trackingData) {
    final String currentStatus = trackingData.order.status.key;
    final List<DeliveryStatus> history = [];

    if (currentStatus == 'cancelled') {
        history.add(DeliveryStatus(
          title: getLabelForStatus('cancelled'),
          timestamp: trackingData.order.cancelledAt != null ? DateTime.parse(trackingData.order.cancelledAt!) : null,
          isCompleted: false, // Inactive means not an active task
        ));
        return history;
    }

    int currentIdx = orderedStatuses.indexOf(currentStatus);
    
    // If not found, maybe just show the current status or pending
    if (currentIdx == -1) {
       history.add(DeliveryStatus(
          title: getLabelForStatus(currentStatus),
          isCompleted: false,
          isCurrent: true,
        ));
        return history;
    }

    for (int i = 0; i < orderedStatuses.length; i++) {
      String statusKey = orderedStatuses[i];
      bool isCompleted = i < currentIdx || (currentStatus == 'delivered' && i == currentIdx);
      bool isCurrent = i == currentIdx && currentStatus != 'delivered';
      
      // You can inject specific timestamps here if they exist in trackingData, e.g., trackingData.order.pickedUpAt
      DateTime? timestamp;
      if (statusKey == 'picked_up' && trackingData.order.pickedUpAt != null) {
          timestamp = DateTime.parse(trackingData.order.pickedUpAt!);
      } else if (statusKey == 'delivered' && trackingData.order.deliveredAt != null) {
          timestamp = DateTime.parse(trackingData.order.deliveredAt!);
      } else if ((isCompleted || isCurrent) && trackingData.order.updatedAt != null) {
          // Fallback to updated at for other completed/current statuses
          timestamp = DateTime.parse(trackingData.order.updatedAt!);
      }

      history.add(DeliveryStatus(
        title: getLabelForStatus(statusKey),
        timestamp: timestamp,
        isCompleted: isCompleted,
        isCurrent: isCurrent,
      ));
    }

    return history;
  }
}

