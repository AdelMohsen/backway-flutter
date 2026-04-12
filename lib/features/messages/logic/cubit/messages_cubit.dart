import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/features/messages/data/models/messages_model.dart';
import 'package:greenhub/features/messages/data/params/messages_params.dart';
import 'package:greenhub/features/messages/data/repository/messages_repository.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';

import '../state/messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesInitial()) {
    fetchMessages();
  }

  int _currentPage = 1;
  bool _isLastPage = false;
  final List<ChatModel> _chats = [];

  bool get isLastPage => _isLastPage;
  List<ChatModel> get chats => _chats;

  Future<void> fetchMessages({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _isLastPage = false;
      _chats.clear();
      emit(MessagesLoading());
    } else {
      if (_isLastPage || state is MessagesPaginationLoading) return;
      if (_chats.isEmpty) {
        emit(MessagesLoading());
      } else {
        emit(MessagesPaginationLoading());
      }
    }

    final params = MessagesParams(
      lang: mainAppBloc.globalLang,
      page: _currentPage,
    );

    final result = await MessagesRepository.getChats(params);

    result.fold(
      (error) {
        if (_chats.isEmpty) {
          emit(MessagesError(error));
        } else {
          emit(MessagesPaginationError(error));
          emit(
            MessagesSuccess(chats: List.from(_chats), isLastPage: _isLastPage),
          );
        }
      },
      (response) {
        _isLastPage = response.data?.nextPageUrl == null;

        if (response.data?.chats != null) {
          _chats.addAll(response.data!.chats!);
        }

        if (!_isLastPage) {
          _currentPage++;
        }

        emit(
          MessagesSuccess(chats: List.from(_chats), isLastPage: _isLastPage),
        );
      },
    );
  }
}
