import 'package:equatable/equatable.dart';

class OrdersParams extends Equatable {
  final int page;
  final int perPage;
  final String status;

  const OrdersParams({
    required this.page,
    required this.perPage,
    required this.status,
  });

  Map<String, dynamic> returnedMap() {
    final Map<String, dynamic> map = {
      'page': page.toString(),
      'per_page': perPage.toString(),
      'status': status,
    };
    
    // Remove null values if any (though currently all are required, good practice)
    map.removeWhere((key, value) => value == null || value == 'null' || value == '');
    return map;
  }

  @override
  List<Object?> get props => [page, perPage, status];
}
