import 'package:equatable/equatable.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../data/models/messages_model.dart';

sealed class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object?> get props => [];
}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesSuccess extends MessagesState {
  final List<ChatModel> chats;
  final bool isLastPage;

  const MessagesSuccess({
    required this.chats,
    required this.isLastPage,
  });

  @override
  List<Object?> get props => [chats, isLastPage];
}

class MessagesError extends MessagesState {
  final ErrorEntity error;

  const MessagesError(this.error);

  @override
  List<Object?> get props => [error];
}

class MessagesPaginationLoading extends MessagesState {}

class MessagesPaginationError extends MessagesState {
  final ErrorEntity error;

  const MessagesPaginationError(this.error);

  @override
  List<Object?> get props => [error];
}
