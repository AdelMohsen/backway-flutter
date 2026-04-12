import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/params/open_chat_params.dart';
import '../../data/repository/open_chat_repository.dart';
import '../state/open_chat_state.dart';

class OpenChatCubit extends Cubit<OpenChatState> {
  OpenChatCubit() : super(OpenChatInitial());

  Future<void> openChat({required int orderId}) async {
    emit(OpenChatLoading());

    const params = OpenChatParams();

    final result = await OpenChatRepository.openChat(
      orderId: orderId,
      params: params,
    );

    result.fold(
      (error) {
        if (!isClosed) emit(OpenChatError(error));
      },
      (data) {
        if (!isClosed) emit(OpenChatSuccess(data));
      },
    );
  }
}
