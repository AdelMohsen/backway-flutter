import 'package:equatable/equatable.dart';

class SocialLinksParams extends Equatable {
  final String lang;

  const SocialLinksParams({
    required this.lang,
  });

  Map<String, dynamic> returnedMap() {
    return {
      'lang': lang,
    };
  }

  @override
  List<Object?> get props => [lang];
}
