import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/address_model.dart';
import '../data/repo/address_repo.dart';
import 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial()) {
    getAddresses();
  }

  List<AddressModel> addresses = [];

  Future<void> getAddresses() async {
    emit(AddressLoading());

    final result = await AddressRepo.getAddresses();

    result.fold(
      (error) {
        emit(AddressError(error: error));
      },
      (data) {
        addresses = data;
        emit(AddressLoaded(addresses: data));
      },
    );
  }
}
