import 'package:equatable/equatable.dart';

import '../../../../../core/shared/entity/error_entity.dart';
import '../../data/models/logout_model.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

final class LogoutInitial extends LogoutState {
  const LogoutInitial();
}

final class LogoutLoading extends LogoutState {
  const LogoutLoading();
}

final class LogoutSuccess extends LogoutState {
  final LogoutModel logoutModel;

  const LogoutSuccess(this.logoutModel);

  @override
  List<Object> get props => [logoutModel];
}

final class LogoutError extends LogoutState {
  final ErrorEntity error;

  const LogoutError(this.error);

  @override
  List<Object> get props => [error];
}
