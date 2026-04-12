import 'package:equatable/equatable.dart';

class NegotiationOffersParams extends Equatable {
  final String lang;
  final int page;

  const NegotiationOffersParams({required this.lang, this.page = 1});

  Map<String, dynamic> returnedMap() {
    return {'lang': lang, 'page': page};
  }

  @override
  List<Object?> get props => [lang, page];
}
