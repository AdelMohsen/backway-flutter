import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../data/models/about_services_model.dart';
import '../../data/params/about_services_params.dart';
import '../../data/repository/about_services_repository.dart';
import '../state/about_services_state.dart';

class AboutServicesCubit extends Cubit<AboutServicesState> {
  AboutServicesCubit() : super(AboutServicesInitial());

  AboutServicesModel? _cachedData;

  Future<void> getServices({bool isRefresh = false}) async {
    if (isRefresh && _cachedData != null) {
      emit(AboutServicesRefreshing(_cachedData!));
    } else {
      emit(const AboutServicesLoading());
    }
    final response = await AboutServicesRepository.getServices(
      AboutServicesParams(lang: mainAppBloc.globalLang),
    );
    response.fold(
      (failure) => emit(AboutServicesError(failure)),
      (success) {
        _cachedData = success;
        return emit(AboutServicesSuccess(success));
      },
    );
  }
}
