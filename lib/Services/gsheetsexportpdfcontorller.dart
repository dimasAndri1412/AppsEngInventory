import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:gsheets/gsheets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'gsheetsservices.dart';

class GSheetsToPdfService {

  static Future<String> exportDaftarStokToPdf() async {
    try {

      final Directory downloadDirectory = Directory('/storage/emulated/0/Download');

      if (!await downloadDirectory.exists()) {
        await downloadDirectory.create(
          recursive: true,
        );
      }

      final DateTime now = DateTime.now();
      final String year = now.year.toString().padLeft(4, '0');
      final String month = now.month.toString().padLeft(2, '0');
      final String day = now.day.toString().padLeft(2, '0');

      final String fileName = 'LAPORAN_DAFTAR_STOCK_${year}${month}${day}.pdf';

      final String filePath = '${downloadDirectory.path}/$fileName';

      final pw.Document pdf = pw.Document();

      final Worksheet? sheet1 = GSheetsServicesEmployees.sheetDaftarStock;
      final Worksheet? sheet2 = GSheetsServicesEmployees.sheetDaftarStock2;
      final Worksheet? sheet3 = GSheetsServicesEmployees.sheetDaftarStock3;


      if (sheet1 == null && sheet2 == null && sheet3 == null) {
        throw Exception(
          'Worksheet Daftar Stock belum diinisialisasi.',
        );
      }

      bool adaData = false;

      // =====================================================
      // DAFTAR STOCK 1 - LEMARI 1
      // =====================================================

      if (sheet1 != null) {
        final List<List<String>> rows = await _getRowsUntilLastData(
          sheet1,
        );

        if (rows.isNotEmpty) {
          adaData = true;
          _addSheetToPdf(
            pdf: pdf,
            sheetTitle: 'DAFTAR STOCK',
            cabinetTitle: 'LEMARI 1',
            rows: rows,
          );
        }
      }


      if (sheet2 != null) {

        final List<List<String>> rows = await _getRowsUntilLastData(
          sheet2,
        );

        if (rows.isNotEmpty) {
          adaData = true;
          _addSheetToPdf(
            pdf: pdf,
            sheetTitle: 'DAFTAR STOCK',
            cabinetTitle: 'LEMARI 2',
            rows: rows,
          );
        }
      }


      if (sheet3 != null) {

        final List<List<String>> rows =
        await _getRowsUntilLastData(
          sheet3,
        );

        if (rows.isNotEmpty) {
          adaData = true;
          _addSheetToPdf(
            pdf: pdf,
            sheetTitle: 'DAFTAR STOCK',
            cabinetTitle: 'LEMARI 3',
            rows: rows,
          );
        }
      }


      if (!adaData) {
        throw Exception(
          'Tidak ada data yang dapat diexport ke PDF.',
        );
      }


      final Uint8List pdfBytes =
      await pdf.save();

      final File pdfFile = File(filePath);
      await pdfFile.writeAsBytes(
        pdfBytes,
        flush: true,
      );


      if (!await pdfFile.exists()) {
        throw Exception(
          'File PDF gagal dibuat.',
        );
      }


      final int fileSize = await pdfFile.length();
      if (fileSize <= 0) {
        throw Exception(
          'File PDF kosong.',
        );
      }
      return pdfFile.path;

    } catch (e, stackTrace) {
      debugPrint('ERROR : $e',);
      debugPrint('STACK : $stackTrace',);
      rethrow;
    }
  }


  static Future<List<List<String>>> _getRowsUntilLastData(
      Worksheet worksheet) async {
    try {

      final List<List<String>> allRows = await worksheet.values.allRows();

      if (allRows.isEmpty) {
        return [];
      }


      int lastDataIndex = -1;

      for (int i = 0; i < allRows.length; i++) {
        final List<String> row = allRows[i];

        final bool hasData = row.any((String value) {
            return value.trim().isNotEmpty;
          },
        );

        if (hasData) {
          lastDataIndex = i;
        }
      }

      if (lastDataIndex == -1) {
        return [];
      }

      final List<List<String>> result = allRows.sublist(0, lastDataIndex + 1).map((List<String> row) {
          return row.map((String value) => value.trim(),
          ).toList();
        },
      ).toList();

      return result;

    } catch (e) {
      debugPrint('Gagal membaca worksheet: $e');
      rethrow;
    }
  }

  static void _addSheetToPdf({
    required pw.Document pdf,
    required String sheetTitle,
    required String cabinetTitle,
    required List<List<String>> rows,
  }) {
    if (rows.isEmpty) {
      return;
    }

    int maxColumns = 0;

    for (final List<String> row in rows) {
      if (row.length > maxColumns) {
        maxColumns = row.length;
      }
    }

    if (maxColumns == 0) {
      return;
    }

    final List<List<String>> normalizedRows = rows.map((List<String> row) {
        final List<String> newRow = List<String>.from(row);

        while (newRow.length < maxColumns) {
          newRow.add('');
        }

        if (newRow.length > maxColumns) {
          return newRow.sublist(
            0, maxColumns,
          );
        }
        return newRow;
      },
    ).toList();


    final List<String> header = normalizedRows.first;


    final List<List<String>> dataRows = normalizedRows.length > 1
        ? normalizedRows.sublist(1) : [];


    final Map<int, pw.TableColumnWidth>columnWidths = {};
    for (int i = 0; i < maxColumns; i++) {if (i == 0) {
        columnWidths[i] = const pw.FixedColumnWidth(45);
      } else if (i == 1) {
        columnWidths[i] = const pw.FlexColumnWidth(2.5);
      } else {
        columnWidths[i] = const pw.FlexColumnWidth(1);
      }
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(20),

        header: (pw.Context context) {
          return pw.Container(
            width: double.infinity,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                width: 0.8,
              ),
            ),

            child: pw.Column(
              children: [

                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.only(
                    top: 10,
                    bottom: 3,
                  ),

                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    sheetTitle,
                    textAlign: pw.TextAlign.center,

                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),

                pw.Container(
                  width: double.infinity,

                  padding: const pw.EdgeInsets.only(
                    top: 0,
                    bottom: 10,
                  ),
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    cabinetTitle,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 13,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),

                pw.Container(
                  width: double.infinity,
                  height: 0.8,
                  color: PdfColors.black,
                ),

                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.symmetric(
                    vertical: 9,
                  ),

                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'UPDATE STOCK BARANG',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 11,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },

        footer: (pw.Context context) {
          return pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
              'Halaman ${context.pageNumber}',
              style: const pw.TextStyle(
                fontSize: 8,
              ),
            ),
          );
        },

        build: (pw.Context context) {
          return [
            // =============================================
            // TABLE
            // =============================================
            pw.Table(
              border: pw.TableBorder.all(
                width: 0.5,
              ),

              columnWidths: columnWidths,

              children: [

                // =========================================
                // HEADER TABLE
                // =========================================

                pw.TableRow(
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.grey300,
                  ),

                  children: header.map((String value) {
                      return pw.Container(
                        padding: const pw.EdgeInsets.all(4),
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          value,
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),

                // =========================================
                // DATA TABLE
                // =========================================

                ...dataRows.map((List<String> row) {
                    return pw.TableRow(
                      children: row.asMap().entries.map((entry) {
                          final int columnIndex = entry.key;
                          final String value = entry.value;
                          return pw.Container(
                            padding: const pw.EdgeInsets.all(4),
                            alignment: columnIndex == 0
                                ? pw.Alignment.center
                                : pw.Alignment.centerLeft,
                            child: pw.Text(
                              value,
                              textAlign: columnIndex == 0
                                  ? pw.TextAlign.center
                                  : pw.TextAlign.left,
                              style: const pw.TextStyle(
                                fontSize: 7,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    );
                  },
                ),
              ],
            ),
          ];
        },
      ),
    );
  }
}