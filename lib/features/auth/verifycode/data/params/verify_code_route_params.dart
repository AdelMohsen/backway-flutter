import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/enums.dart';

class VerifyCodeRouteParams extends Equatable {
  const VerifyCodeRouteParams({
    required this.phoneNumber,
    required this.fromScreen,
  });

  final String phoneNumber;
  final VerifyCodeFromScreen fromScreen;

  @override
  List<Object?> get props => [phoneNumber, fromScreen];
}
