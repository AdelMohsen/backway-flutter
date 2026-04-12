import '../../../../core/shared/entity/error_entity.dart';
import '../../data/models/social_links_model.dart';

sealed class SocialLinksState {
  const SocialLinksState();
}

final class SocialLinksInitial extends SocialLinksState {}

final class SocialLinksLoading extends SocialLinksState {
  const SocialLinksLoading();
}

final class SocialLinksSuccess extends SocialLinksState {
  final SocialLinksModel data;
  const SocialLinksSuccess(this.data);
}

final class SocialLinksError extends SocialLinksState {
  final ErrorEntity error;
  const SocialLinksError(this.error);
}
