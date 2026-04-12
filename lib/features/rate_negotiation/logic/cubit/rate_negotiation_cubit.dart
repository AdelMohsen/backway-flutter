import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/features/rate_negotiation/data/params/rate_negotiation_params.dart';
import 'package:greenhub/features/rate_negotiation/data/repository/rate_negotiation_repository.dart';
import 'package:greenhub/features/rate_negotiation/logic/state/rate_negotiation_state.dart';

class RateNegotiationCubit extends Cubit<RateNegotiationState> {
  RateNegotiationCubit() : super(RateNegotiationInitial());

  Future<void> submitRating(int orderId, int emojiIndex, String comment) async {
    // Emoji index to rating mapping
    // Index 0 ('😍') -> 5
    // Index 1 ('🙂') -> 4
    // Index 2 ('😐') -> 3
    // Index 3 ('😒') -> 2
    // Index 4 ('😖') -> 1
    int rating = 5 - emojiIndex;

    // Ensure rating is within bounds (1-5) and provide a fallback if no emoji selected
    if (emojiIndex < 0 || emojiIndex > 4) {
      rating = 5; // Default to 5 if no valid emoji is selected
    }

    emit(RateNegotiationLoading());

    final params = RateNegotiationParams(
      rating: rating,
      comment: comment,
    );

    final response = await RateNegotiationRepository.submitRating(
      orderId,
      params,
    );

    response.fold(
      (error) => emit(RateNegotiationError(error)),
      (success) => emit(RateNegotiationSuccess(success)),
    );
  }
}
