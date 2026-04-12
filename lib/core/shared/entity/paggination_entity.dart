import 'package:equatable/equatable.dart';

class PagginationEntity extends Equatable {
  const PagginationEntity({
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  final int currentPage;
  final int lastPage;
  final int total;

  PagginationEntity copyWith({
    int? currentPage,
    int? lastPage,
    int? total,
  }) {
    return PagginationEntity(
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [currentPage, lastPage, total];
}
