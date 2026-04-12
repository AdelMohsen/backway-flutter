import 'package:equatable/equatable.dart';

class InvoiceModel extends Equatable {
  final bool? success;
  final InvoiceData? data;

  const InvoiceModel({this.success, this.data});

  factory InvoiceModel.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return const InvoiceModel(success: false, data: null);
    }
    return InvoiceModel(
      success: json['success'],
      data: json['data'] != null ? InvoiceData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }

  @override
  List<Object?> get props => [success, data];
}

class InvoiceData extends Equatable {
  final dynamic invoiceNumber;
  final String? orderNumber;
  final String? invoiceDate;
  final CompanyInfo? company;
  final InvoiceLabels? labels;
  final InvoiceAmounts? amounts;
  final String? currency;
  final String? locale;
  final bool? isRtl;
  final String? qrCode;

  const InvoiceData({
    this.invoiceNumber,
    this.orderNumber,
    this.invoiceDate,
    this.company,
    this.labels,
    this.amounts,
    this.currency,
    this.locale,
    this.isRtl,
    this.qrCode,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) {
    return InvoiceData(
      invoiceNumber: json['invoice_number'],
      orderNumber: json['order_number'],
      invoiceDate: json['invoice_date'],
      company: json['company'] != null ? CompanyInfo.fromJson(json['company']) : null,
      labels: json['labels'] != null ? InvoiceLabels.fromJson(json['labels']) : null,
      amounts: json['amounts'] != null ? InvoiceAmounts.fromJson(json['amounts']) : null,
      currency: json['currency'],
      locale: json['locale'],
      isRtl: json['is_rtl'],
      // Fallback for QR code if it's inside labels
      qrCode: json['qr_code'] ?? (json['labels'] != null ? json['labels']['qr_code'] : null),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invoice_number': invoiceNumber,
      'order_number': orderNumber,
      'invoice_date': invoiceDate,
      'company': company?.toJson(),
      'labels': labels?.toJson(),
      'amounts': amounts?.toJson(),
      'currency': currency,
      'locale': locale,
      'is_rtl': isRtl,
      'qr_code': qrCode,
    };
  }

  @override
  List<Object?> get props => [
        invoiceNumber,
        orderNumber,
        invoiceDate,
        company,
        labels,
        amounts,
        currency,
        locale,
        isRtl,
        qrCode,
      ];
}

class CompanyInfo extends Equatable {
  final String? name;
  final String? address;
  final String? taxNumber;

  const CompanyInfo({this.name, this.address, this.taxNumber});

  factory CompanyInfo.fromJson(Map<String, dynamic> json) {
    return CompanyInfo(
      name: json['name'],
      address: json['address'],
      taxNumber: json['tax_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'tax_number': taxNumber,
    };
  }

  @override
  List<Object?> get props => [name, address, taxNumber];
}

class InvoiceLabels extends Equatable {
  final String? invoiceNumber;
  final String? orderNumber;
  final String? invoiceDate;
  final String? deliveryFee;
  final String? vatRate;
  final String? vatAmount;
  final String? totalIncludingVat;
  final String? sendViaEmail;
  final String? downloadPdf;
  final String? qrCode;

  const InvoiceLabels({
    this.invoiceNumber,
    this.orderNumber,
    this.invoiceDate,
    this.deliveryFee,
    this.vatRate,
    this.vatAmount,
    this.totalIncludingVat,
    this.sendViaEmail,
    this.downloadPdf,
    this.qrCode,
  });

  factory InvoiceLabels.fromJson(Map<String, dynamic> json) {
    return InvoiceLabels(
      invoiceNumber: json['invoice_number'],
      orderNumber: json['order_number'],
      invoiceDate: json['invoice_date'],
      deliveryFee: json['delivery_fee'],
      vatRate: json['vat_rate'],
      vatAmount: json['vat_amount'],
      totalIncludingVat: json['total_including_vat'],
      sendViaEmail: json['send_via_email'],
      downloadPdf: json['download_pdf'],
      qrCode: json['qr_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invoice_number': invoiceNumber,
      'order_number': orderNumber,
      'invoice_date': invoiceDate,
      'delivery_fee': deliveryFee,
      'vat_rate': vatRate,
      'vat_amount': vatAmount,
      'total_including_vat': totalIncludingVat,
      'send_via_email': sendViaEmail,
      'download_pdf': downloadPdf,
      'qr_code': qrCode,
    };
  }

  @override
  List<Object?> get props => [
        invoiceNumber,
        orderNumber,
        invoiceDate,
        deliveryFee,
        vatRate,
        vatAmount,
        totalIncludingVat,
        sendViaEmail,
        downloadPdf,
        qrCode,
      ];
}

class InvoiceAmounts extends Equatable {
  final dynamic subtotal;
  final dynamic vatRate;
  final dynamic vatAmount;
  final dynamic totalIncludingVat;

  const InvoiceAmounts({
    this.subtotal,
    this.vatRate,
    this.vatAmount,
    this.totalIncludingVat,
  });

  factory InvoiceAmounts.fromJson(Map<String, dynamic> json) {
    return InvoiceAmounts(
      subtotal: json['subtotal'],
      vatRate: json['vat_rate'],
      vatAmount: json['vat_amount'],
      totalIncludingVat: json['total_including_vat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtotal': subtotal,
      'vat_rate': vatRate,
      'vat_amount': vatAmount,
      'total_including_vat': totalIncludingVat,
    };
  }

  @override
  List<Object?> get props => [subtotal, vatRate, vatAmount, totalIncludingVat];
}
