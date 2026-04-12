import 'package:equatable/equatable.dart';

class MessagesParams extends Equatable {
  final String lang;
  final int page;

  const MessagesParams({
    required this.lang,
    required this.page,
  });

  Map<String, dynamic> returnedMap() {
    final map = <String, dynamic>{};
    map['lang'] = lang;
    map['page'] = page;
    return map;
  }

  @override
  List<Object?> get props => [lang, page];
}
