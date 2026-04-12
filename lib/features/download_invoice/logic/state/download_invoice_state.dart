import 'package:equatable/equatable.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/download_invoice/data/models/invoice_model.dart';

sealed class DownloadInvoiceState extends Equatable {
  const DownloadInvoiceState();

  @override
  List<Object?> get props => [];
}

final class DownloadInvoiceInitial extends DownloadInvoiceState {}

final class DownloadInvoiceLoading extends DownloadInvoiceState {}

final class DownloadInvoiceSuccess extends DownloadInvoiceState {
  final InvoiceData invoice;
  const DownloadInvoiceSuccess({required this.invoice});

  @override
  List<Object?> get props => [invoice];
}

final class DownloadInvoiceError extends DownloadInvoiceState {
  final ErrorEntity error;
  const DownloadInvoiceError({required this.error});

  @override
  List<Object?> get props => [error];
}
