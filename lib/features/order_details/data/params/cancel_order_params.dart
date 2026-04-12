import 'package:equatable/equatable.dart';

class CancelOrderParams extends Equatable {
  final String reason;

  const CancelOrderParams({required this.reason});

  Map<String, dynamic> returnedMap() {
    final map = <String, dynamic>{};
    if (reason.isNotEmpty) {
      map['reason'] = reason;
    }
    return map;
  }

  @override
  List<Object?> get props => [reason];
}
