import 'package:equatable/equatable.dart';

class SharedPrefKeys extends Equatable {
  static const String userToken = 'userToken';
  static const String lang = 'lang';
  static const String userId = 'userId';

  @override
  List<Object?> get props => [userToken, lang, userId];
}
