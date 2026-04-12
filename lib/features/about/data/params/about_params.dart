import 'package:equatable/equatable.dart';

class AboutParams extends Equatable {
  final String lang;

  const AboutParams({
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
