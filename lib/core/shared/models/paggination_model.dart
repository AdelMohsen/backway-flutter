import '../entity/paggination_entity.dart';

class PagginationModel extends PagginationEntity {
  const PagginationModel({
    required super.currentPage,
    required super.lastPage,
    required super.total,
  });

  factory PagginationModel.fromJson(Map<String, dynamic> json) {
    return PagginationModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      total: json['total'],
    );
  }
}
