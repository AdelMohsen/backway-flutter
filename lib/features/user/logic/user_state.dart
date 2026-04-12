import 'package:equatable/equatable.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../entity/user_entity.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  const UserLoaded(this.user);
  final UserEntity user;

  @override
  List<Object> get props => [user];
}

final class UserError extends UserState {
  const UserError(this.error);
  final ErrorEntity error;

  @override
  List<Object> get props => [error];
}
