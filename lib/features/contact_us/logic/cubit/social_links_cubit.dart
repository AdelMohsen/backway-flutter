import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../data/params/social_links_params.dart';
import '../../data/repository/social_links_repository.dart';
import '../state/social_links_state.dart';

class SocialLinksCubit extends Cubit<SocialLinksState> {
  SocialLinksCubit() : super(SocialLinksInitial());

  Future<void> getSocialLinks() async {
    emit(const SocialLinksLoading());
    final response = await SocialLinksRepository.getSocialLinks(
      SocialLinksParams(lang: mainAppBloc.globalLang),
    );
    response.fold(
      (failure) => emit(SocialLinksError(failure)),
      (success) => emit(SocialLinksSuccess(success)),
    );
  }
}
