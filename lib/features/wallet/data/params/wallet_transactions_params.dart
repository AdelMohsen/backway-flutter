import 'package:equatable/equatable.dart';

class WalletTransactionsParams extends Equatable {
  final String? type;
  final int page;
  final int perPage;

  const WalletTransactionsParams({
    this.type,
    this.page = 1,
    this.perPage = 20,
  });

  Map<String, dynamic> returnedMap() {
    final map = <String, dynamic>{
      'type': type,
      'page': page,
      'per_page': perPage,
    };
    map.removeWhere((key, value) => value == null || value == '');
    return map;
  }

  @override
  List<Object?> get props => [type, page, perPage];
}
