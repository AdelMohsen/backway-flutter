import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../data/params/about_params.dart';
import '../../data/repository/about_repository.dart';
import '../state/about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit() : super(AboutInitial());

  Future<void> getAbout() async {
    emit(const AboutLoading());
    final response = await AboutRepository.getAbout(
      AboutParams(lang: mainAppBloc.globalLang),
    );
    response.fold(
      (failure) => emit(AboutError(failure)),
      (success) => emit(AboutSuccess(success)),
    );
  }
}
