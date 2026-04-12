import 'package:equatable/equatable.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../data/models/complaint_model.dart';

sealed class FileComplaintState extends Equatable {
  const FileComplaintState();

  @override
  List<Object?> get props => [];
}

final class FileComplaintInitial extends FileComplaintState {}

final class FileComplaintLoading extends FileComplaintState {}

final class FileComplaintSuccess extends FileComplaintState {
  final ComplaintModel response;
  const FileComplaintSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

final class FileComplaintError extends FileComplaintState {
  final ErrorEntity error;
  const FileComplaintError(this.error);

  @override
  List<Object?> get props => [error];
}

final class FileComplaintImagePicked extends FileComplaintState {
  final DateTime time;
  const FileComplaintImagePicked(this.time);

  @override
  List<Object?> get props => [time];
}
