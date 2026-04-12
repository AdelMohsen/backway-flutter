import 'package:equatable/equatable.dart';

class AboutServicesParams extends Equatable {
  final String lang;

  const AboutServicesParams({required this.lang});

  Map<String, dynamic> returnedMap() {
    final Map<String, dynamic> map = {'lang': lang};
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [lang];
}
