import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/utils/utility.dart';
import '../../../../core/services/pusher/pusher_cubit.dart';
import '../../../../core/services/pusher/pusher_state.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../data/models/negotiation_offers_model.dart';
import '../../data/params/negotiation_offers_params.dart';
import '../../data/params/send_message_params.dart';
import '../../data/repository/negotiation_offers_repository.dart';
import '../state/negotiation_offers_state.dart';

class NegotiationOffersCubit extends Cubit<NegotiationOffersState> {
  final PusherCubit pusherCubit;

  NegotiationOffersCubit({required this.pusherCubit})
    : super(NegotiationOffersInitial());

  int _currentPage = 1;
  bool _isLastPage = false;
  final List<NegotiationMessageModel> _messages = [];
  NegotiationChatModel? _chatDetails;

  List<NegotiationMessageModel> get messages => _messages;
  NegotiationChatModel? get chatDetails => _chatDetails;
  bool get isLastPage => _isLastPage;

  /// ──────────────────────────────────────────────────
  /// FETCH MESSAGES
  /// ──────────────────────────────────────────────────
  Future<void> fetchNegotiations({
    required int orderId,
    bool refresh = false,
  }) async {
    if (refresh) {
      _currentPage = 1;
      _isLastPage = false;
      _messages.clear();
      _chatDetails = null;
      emit(NegotiationOffersLoading());
    } else {
      if (_isLastPage || state is NegotiationOffersPaginationLoading) return;
      if (_messages.isEmpty) {
        emit(NegotiationOffersLoading());
      } else {
        emit(NegotiationOffersPaginationLoading());
      }
    }

    final queryParams = NegotiationOffersParams(
      lang: mainAppBloc.globalLang,
      page: _currentPage,
    );

    final result = await NegotiationOffersRepository.getOrderChat(
      orderId: orderId,
      params: queryParams,
    );

    result.fold(
      (error) {
        if (_currentPage == 1) {
          emit(NegotiationOffersError(error));
        } else {
          emit(NegotiationOffersPaginationError(error));
          emit(
            NegotiationOffersSuccess(
              messages: List.from(_messages),
              chatDetails: _chatDetails,
              isLastPage: _isLastPage,
            ),
          );
        }
      },
      (response) {
        final messagesData = response.messagesPagination?.data ?? [];
        _chatDetails = response.chat ?? _chatDetails;

        if (refresh || _currentPage == 1) {
          _messages.clear();
        }

        _messages.addAll(messagesData);

        _isLastPage = response.messagesPagination?.nextPageUrl == null;

        if (!_isLastPage) {
          _currentPage++;
        }

        emit(
          NegotiationOffersSuccess(
            messages: List.from(_messages),
            chatDetails: _chatDetails,
            isLastPage: _isLastPage,
          ),
        );

        // Auto-subscribe if chatDetails.id is found
        if (_chatDetails?.id != null) {
          initPusher(chatId: _chatDetails!.id!);
        }
      },
    );
  }

  /// ──────────────────────────────────────────────────
  /// SEND MESSAGE
  /// ──────────────────────────────────────────────────
  Future<void> sendMessage({
    required int orderId,
    required String message,
    File? attachment,
  }) async {
    emit(NegotiationOffersSendingMessage());

    final params = SendMessageParams(
      message: message,
      type: attachment != null ? 'image' : 'text',
      attachment: attachment,
    );

    final result = await NegotiationOffersRepository.sendMessage(
      orderId: orderId,
      params: params,
    );

    result.fold(
      (error) {
        emit(NegotiationOffersSendMessageError(error));
        emit(
          NegotiationOffersSuccess(
            messages: List.from(_messages),
            chatDetails: _chatDetails,
            isLastPage: _isLastPage,
          ),
        );
      },
      (_) {
        emit(
          NegotiationOffersSuccess(
            messages: List.from(_messages),
            chatDetails: _chatDetails,
            isLastPage: _isLastPage,
          ),
        );
      },
    );
  }

  /// ──────────────────────────────────────────────────
  /// PUSHER — subscribe & handle events
  /// ──────────────────────────────────────────────────
  Future<void> initPusher({int? orderId, int? chatId}) async {
    final id = chatId ?? _chatDetails?.id;
    if (id == null) {
      debugPrint('[Pusher] initPusher postponed: no chatId available yet');
      return;
    }

    final channelName = 'private-chat.$id';

    if (pusherCubit.isConnected &&
        (pusherCubit.state is PusherSubscribed &&
            (pusherCubit.state as PusherSubscribed).channelName ==
                channelName)) {
      debugPrint('[Pusher] Already subscribed to "$channelName"');
      return;
    }

    debugPrint('[Pusher] initPusher for chatId: $id');
    await pusherCubit.connect();

    debugPrint('[Pusher] Calculated channelName: "$channelName"');

    // 1. ADD LISTENERS FIRST (to avoid race conditions)
    pusherCubit.addEventListener(channelName, (eventName, data) {
      cprint('[Chat] Event received: "$eventName"');
      cprint('[Chat] Event data: $data');

      if (eventName == 'message.sent') {
        _handleNewMessage(data);
      } else if (eventName == 'messages.read') {
        _handleMessagesRead(data);
      } else {
        cprint('[Chat] Unhandled event: "$eventName"');
      }
    });

    // 2. NOW SUBSCRIBE
    await pusherCubit.subscribeToChannel(channelName);
  }

  void _handleNewMessage(dynamic data) {
    try {
      cprint('[Chat] _handleNewMessage: data type = ${data.runtimeType}');

      dynamic finalData = data;
      if (data is String) {
        try {
          finalData = jsonDecode(data);
        } catch (_) {
          cprint('[Chat] ❌ failed to decode top-level data');
        }
      }

      if (finalData is! Map) {
        cprint('[Chat] ❌ data is not a Map');
        return;
      }

      // Check where the message object lives.
      // In the provided JSON, it's under 'data', while 'message' is a status string.
      dynamic messageData;
      if (finalData['data'] is Map) {
        messageData = finalData['data'];
      } else if (finalData['message'] is Map) {
        messageData = finalData['message'];
      } else if (finalData.containsKey('chat_id')) {
        // Fallback: the top level itself might be the message object
        messageData = finalData;
      }

      if (messageData is String) {
        try {
          messageData = jsonDecode(messageData);
        } catch (_) {
          cprint('[Chat] ❌ failed to decode nested message string');
        }
      }

      if (messageData is! Map) {
        cprint(
          '[Chat] ❌ message object not found or invalid type. data: $finalData',
        );
        return;
      }

      final messageJson = Map<String, dynamic>.from(messageData);
      cprint('[Chat] message keys: ${messageJson.keys.toList()}');

      final newMessage = NegotiationMessageModel.fromJson(messageJson);
      cprint('[Chat] Parsed: id=${newMessage.id}, type=${newMessage.type}');

      final exists = _messages.any((m) => m.id == newMessage.id);
      cprint('[Chat] Already exists: $exists, count: ${_messages.length}');

      if (!exists) {
        _messages.insert(0, newMessage);
        cprint('[Chat] ✅ Inserted! New count: ${_messages.length}');
        HapticFeedback.lightImpact();
        emit(NegotiationOffersNewMessage(message: newMessage));
        emit(
          NegotiationOffersSuccess(
            messages: List.from(_messages),
            chatDetails: _chatDetails,
            isLastPage: _isLastPage,
          ),
        );
      }
    } catch (e, stack) {
      cprint('[Chat] ❌ _handleNewMessage error: $e');
      cprint('[Chat] Stack: $stack');
    }
  }

  void _handleMessagesRead(dynamic data) {
    emit(
      NegotiationOffersSuccess(
        messages: List.from(_messages),
        chatDetails: _chatDetails,
        isLastPage: _isLastPage,
      ),
    );
  }

  /// Clean up Pusher subscription
  Future<void> disposePusher({int? orderId, int? chatId}) async {
    final id = chatId ?? _chatDetails?.id;
    if (id == null) return;

    final channelName = 'private-chat.$id';
    pusherCubit.removeEventListeners(channelName);
    await pusherCubit.unsubscribeFromChannel(channelName);
  }
}
