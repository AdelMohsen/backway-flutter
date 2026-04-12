import '../../../../core/shared/entity/error_entity.dart';
import '../../data/models/negotiation_offers_model.dart';

sealed class NegotiationOffersState {
  const NegotiationOffersState();
}

class NegotiationOffersInitial extends NegotiationOffersState {}

class NegotiationOffersLoading extends NegotiationOffersState {}

class NegotiationOffersPaginationLoading extends NegotiationOffersState {}

class NegotiationOffersSuccess extends NegotiationOffersState {
  final List<NegotiationMessageModel> messages;
  final NegotiationChatModel? chatDetails;
  final bool isLastPage;

  const NegotiationOffersSuccess({
    required this.messages,
    this.chatDetails,
    required this.isLastPage,
  });
}

class NegotiationOffersError extends NegotiationOffersState {
  final ErrorEntity error;

  const NegotiationOffersError(this.error);
}

class NegotiationOffersPaginationError extends NegotiationOffersState {
  final ErrorEntity error;

  const NegotiationOffersPaginationError(this.error);
}

/// Emitted while a message is being sent
class NegotiationOffersSendingMessage extends NegotiationOffersState {}

/// Emitted when sending a message fails
class NegotiationOffersSendMessageError extends NegotiationOffersState {
  final ErrorEntity error;

  const NegotiationOffersSendMessageError(this.error);
}

/// Emitted when a new message arrives via Pusher
class NegotiationOffersNewMessage extends NegotiationOffersState {
  final NegotiationMessageModel message;
  final DateTime timestamp;

  NegotiationOffersNewMessage({required this.message})
    : timestamp = DateTime.now();
}
