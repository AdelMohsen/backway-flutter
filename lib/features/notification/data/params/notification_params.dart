import 'package:equatable/equatable.dart';

class NotificationParams extends Equatable {
  final int page;
  final int perPage;
  final String lang;

  const NotificationParams({
    required this.page,
    this.perPage = 20,
    required this.lang,
  });

  Map<String, dynamic> returnedMap() {
    return {
      'page': page,
      'per_page': perPage,
      'lang': lang,
    };
  }

  @override
  List<Object?> get props => [page, perPage, lang];
}
