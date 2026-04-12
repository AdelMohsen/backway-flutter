import 'package:equatable/equatable.dart';

class EnableNotificationParams extends Equatable {
  final bool notificationsEnabled;

  const EnableNotificationParams({
    required this.notificationsEnabled,
  });

  Map<String, dynamic> returnedMap() {
    return {
      "notifications_enabled": notificationsEnabled,
    };
  }

  @override
  List<Object?> get props => [notificationsEnabled];
}
