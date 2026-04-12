import '../../../../core/shared/entity/error_entity.dart';
import '../../data/models/about_services_model.dart';

sealed class AboutServicesState {
  const AboutServicesState();
}

final class AboutServicesInitial extends AboutServicesState {}

final class AboutServicesLoading extends AboutServicesState {
  const AboutServicesLoading();
}

final class AboutServicesRefreshing extends AboutServicesState {
  const AboutServicesRefreshing(this.data);
  final AboutServicesModel data;
}

final class AboutServicesSuccess extends AboutServicesState {
  const AboutServicesSuccess(this.data);
  final AboutServicesModel data;
}

final class AboutServicesError extends AboutServicesState {
  const AboutServicesError(this.error);
  final ErrorEntity error;
}
