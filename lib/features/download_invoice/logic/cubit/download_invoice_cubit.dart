import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/shared/models/error_model.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/download_invoice/data/params/download_invoice_params.dart';
import 'package:greenhub/features/download_invoice/data/repository/download_invoice_repository.dart';
import 'package:greenhub/features/download_invoice/logic/state/download_invoice_state.dart';

class DownloadInvoiceCubit extends Cubit<DownloadInvoiceState> {
  DownloadInvoiceCubit() : super(DownloadInvoiceInitial());

  void fetchInvoice(int orderId) async {
    emit(DownloadInvoiceLoading());

    final params = DownloadInvoiceParams(lang: mainAppBloc.globalLang);

    final result = await DownloadInvoiceRepository.getInvoice(
      orderId: orderId,
      params: params,
    );

    result.fold(
      (ErrorEntity error) => emit(DownloadInvoiceError(error: error)),
      (model) {
        if (model.data != null) {
          emit(DownloadInvoiceSuccess(invoice: model.data!));
        } else {
          emit(DownloadInvoiceError(
            error: ErrorModel(
              statusCode: 0,
              message: mainAppBloc.isArabic
                  ? "لم يتم العثور على بيانات لهذه الفاتورة"
                  : "No data found for this invoice",
              errors: const [],
            ),
          ));
        }
      },
    );
  }
}
