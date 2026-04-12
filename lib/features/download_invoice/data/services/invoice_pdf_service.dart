import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import '../../data/models/invoice_model.dart';

class InvoicePdfService {
  static Future<void> generateInvoicePdf(InvoiceData data) async {
    final pdf = pw.Document();

    // 1. Load Font (Cairo) for Professional Arabic Support
    // Using Printing.getFont ensures we get a high-quality font that supports all Arabic glyphs
    final arabicFont = await PdfGoogleFonts.cairoBold();
    final arabicRegular = await PdfGoogleFonts.cairoRegular();

    // 2. Load App Logo
    Uint8List logoBytes;
    try {
      final ByteData logoData = await rootBundle.load(
        'assets/images/iconApp.png',
      );
      logoBytes = logoData.buffer.asUint8List();
    } catch (e) {
      // Fallback if logo fails
      logoBytes = Uint8List(0);
    }
    final pw.MemoryImage logoImage = pw.MemoryImage(logoBytes);

    // 3. Load QR Code - Generate based on API value (Synchronized with UI)
    pw.MemoryImage? qrImage;
    final String qrRawData = data.qrCode ?? "";

    // Logic to determine if we should use the URL directly or generate a new QR
    // Same logic as QrCodeSectionWidget
    final String qrUrl =
        qrRawData.isNotEmpty &&
            qrRawData.startsWith('http') &&
            qrRawData.toLowerCase().contains('qr')
        ? qrRawData
        : "https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=${Uri.encodeComponent(qrRawData.isEmpty ? "No Data" : qrRawData)}";

    try {
      final response = await http.get(Uri.parse(qrUrl));
      if (response.statusCode == 200) {
        qrImage = pw.MemoryImage(response.bodyBytes);
      }
    } catch (e) {
      print("Error generating scannable QR code: $e");
    }

    final isRtl = data.isRtl ?? true;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(base: arabicRegular, bold: arabicFont),
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: isRtl ? pw.TextDirection.rtl : pw.TextDirection.ltr,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(35),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // --- Header Row ---
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      // Header Text (Right side in RTL)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            isRtl ? "فاتورة ضريبية " : " Tax Invoice",
                            style: pw.TextStyle(
                              fontSize: 24,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.green800,
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Text(
                            "${data.labels?.invoiceNumber ?? "رقم الفاتورة"}: ${data.invoiceNumber ?? ""}",
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.grey700,
                            ),
                          ),
                        ],
                      ),
                      // Logo (Left side in RTL)
                      pw.Container(
                        height: 80,
                        width: 80,
                        child: pw.Image(logoImage),
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 25),
                  pw.Divider(thickness: 2, color: PdfColors.green),
                  pw.SizedBox(height: 15),

                  // --- Metadata Info Section ---
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              isRtl ? "بيانات المنشأة:" : "Company Details:",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 13,
                                color: PdfColors.green900,
                              ),
                            ),
                            pw.SizedBox(height: 6),
                            pw.Text(
                              data.company?.name ?? "",
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              data.company?.address ?? "",
                              style: const pw.TextStyle(fontSize: 11),
                            ),
                            pw.Text(
                              "${isRtl ? "الرقم الضريبي" : "Tax ID"}: ${data.company?.taxNumber ?? ""}",
                              style: const pw.TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              isRtl ? "تفاصيل الفاتورة:" : "Invoice Info:",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 13,
                                color: PdfColors.green900,
                              ),
                            ),
                            pw.SizedBox(height: 6),
                            pw.Text(
                              "${data.labels?.orderNumber ?? "رقم الطلب"}: ${data.orderNumber ?? ""}",
                              style: const pw.TextStyle(fontSize: 11),
                            ),
                            pw.Text(
                              "${data.labels?.invoiceDate ?? "التاريخ"}: ${data.invoiceDate ?? ""}",
                              style: const pw.TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 40),

                  // --- Table Section ---
                  pw.Table(
                    border: pw.TableBorder.all(
                      color: PdfColors.grey300,
                      width: 0.5,
                    ),
                    children: [
                      // Header
                      pw.TableRow(
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.green700,
                        ),
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 8,
                            ),
                            child: pw.Text(
                              isRtl ? "البند" : "Description",
                              style: pw.TextStyle(
                                color: PdfColors.white,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 8,
                            ),
                            child: pw.Text(
                              isRtl ? "القيمة" : "Amount",
                              style: pw.TextStyle(
                                color: PdfColors.white,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Rows
                      _buildRow(
                        data.labels?.deliveryFee ?? "رسوم التوصيل",
                        "${data.amounts?.subtotal} ${data.currency}",
                      ),
                      _buildRow(
                        data.labels?.vatRate ?? "نسبة الضريبة",
                        "${((double.tryParse(data.amounts?.vatRate.toString() ?? "0") ?? 0) * 100).toInt()}%",
                      ),
                      _buildRow(
                        data.labels?.vatAmount ?? "قيمة الضريبة",
                        "${data.amounts?.vatAmount} ${data.currency}",
                      ),

                      // Grand Total
                      pw.TableRow(
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.green50,
                        ),
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(12),
                            child: pw.Text(
                              data.labels?.totalIncludingVat ?? "الإجمالي",
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.green900,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(12),
                            child: pw.Text(
                              "${data.amounts?.totalIncludingVat} ${data.currency}",
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.green900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  pw.Spacer(),

                  // --- Footer Section ---
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      if (qrImage != null)
                        pw.Column(
                          children: [
                            pw.Container(
                              height: 90,
                              width: 90,
                              padding: const pw.EdgeInsets.all(4),
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.grey300),
                                borderRadius: pw.BorderRadius.circular(4),
                              ),
                              child: pw.Image(qrImage),
                            ),
                            pw.SizedBox(height: 6),
                            pw.Text(
                              isRtl ? "امسح للتحقق" : "Scan to verify",
                              style: const pw.TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            isRtl
                                ? "شكراً لثقتكم في شيب هب"
                                : "Thank you for using ShipHub",
                            style: pw.TextStyle(
                              fontSize: 11,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.green800,
                            ),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            isRtl
                                ? "هذه فاتورة إلكترونية معتمدة ولا تتطلب توقيع"
                                : "This is a certified electronic invoice.",
                            style: const pw.TextStyle(
                              fontSize: 9,
                              color: PdfColors.grey700,
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            "ID: ${data.invoiceNumber}",
                            style: const pw.TextStyle(
                              fontSize: 8,
                              color: PdfColors.grey500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: "Invoice_${data.orderNumber}.pdf",
    );
  }

  static pw.TableRow _buildRow(String label, String value) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(10),
          child: pw.Text(label, style: pw.TextStyle(fontSize: 11)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(10),
          child: pw.Text(
            value,
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
