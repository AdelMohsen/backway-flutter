import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/user_repo.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);

  Future<void> getUserProfile() async {
    emit(UserLoading());

    final response = await UserRepo.getUserData();

    response.fold(
      (error) => emit(UserError(error)),
      (user) => emit(UserLoaded(user)),
    );
  }

  void clearUser() {
    emit(UserInitial());
  }
}
