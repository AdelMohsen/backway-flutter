import 'package:equatable/equatable.dart';

class RateNegotiationParams extends Equatable {
  const RateNegotiationParams({
    required this.rating,
    required this.comment,
  });

  final int rating;
  final String comment;

  Map<String, dynamic> returnedMap() {
    return {
      'rating': rating,
      'comment': comment,
    }..removeWhere((key, value) => value == null || value == '');
  }

  @override
  List<Object?> get props => [
        rating,
        comment,
      ];
}
