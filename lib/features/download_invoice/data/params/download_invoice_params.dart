import 'package:equatable/equatable.dart';

class DownloadInvoiceParams extends Equatable {
  final String lang;

  const DownloadInvoiceParams({
    required this.lang,
  });

  Map<String, dynamic> returnedMap() {
    return {
      'lang': lang,
    };
  }

  @override
  List<Object?> get props => [lang];
}
