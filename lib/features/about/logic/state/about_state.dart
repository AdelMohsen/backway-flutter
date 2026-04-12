import '../../../../core/shared/entity/error_entity.dart';
import '../../data/models/about_model.dart';

sealed class AboutState {
  const AboutState();
}

final class AboutInitial extends AboutState {}

final class AboutLoading extends AboutState {
  const AboutLoading();
}

final class AboutSuccess extends AboutState {
  final AboutModel data;
  const AboutSuccess(this.data);
}

final class AboutError extends AboutState {
  final ErrorEntity error;
  const AboutError(this.error);
}
