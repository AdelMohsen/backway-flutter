import 'package:flutter/material.dart';

class ShipmentUtils {
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return const Color.fromRGBO(59, 130, 246, 1);
      case 'picking up':
        return const Color.fromRGBO(0, 150, 136, 1);
      case 'in progress':
        return const Color.fromRGBO(255, 179, 0, 1);
      case 'delivered':
      case 'completed':
        return const Color.fromRGBO(16, 185, 129, 1);
      case 'canceled':
      case 'cancelled':
        return const Color.fromRGBO(239, 68, 68, 1);
      default:
        return const Color.fromRGBO(59, 130, 246, 1);
    }
  }
}
