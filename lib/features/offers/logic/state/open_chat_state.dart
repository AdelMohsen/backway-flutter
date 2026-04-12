import 'package:equatable/equatable.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../data/models/open_chat_model.dart';

sealed class OpenChatState extends Equatable {
  const OpenChatState();

  @override
  List<Object?> get props => [];
}

class OpenChatInitial extends OpenChatState {}

class OpenChatLoading extends OpenChatState {}

class OpenChatSuccess extends OpenChatState {
  final OpenChatModel model;

  const OpenChatSuccess(this.model);

  @override
  List<Object?> get props => [model];
}

class OpenChatError extends OpenChatState {
  final ErrorEntity error;

  const OpenChatError(this.error);

  @override
  List<Object?> get props => [error];
}
