import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/features/home/logic/home_state.dart';

// Empty cubit class - kept for compatibility
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
}
