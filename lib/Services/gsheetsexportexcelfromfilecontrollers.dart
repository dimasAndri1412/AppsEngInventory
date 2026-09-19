import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';
import 'package:share_plus/share_plus.dart';

class RevampGoogleSheetsExportService {
  // ============================================================
  // GOOGLE SHEETS SCOPE
  // ============================================================

  static const List<String> scopes = [
    sheets.SheetsApi.spreadsheetsReadonlyScope,
  ];

  // ============================================================
  // EXPORT ALL SHEETS TO EXCEL
  // ============================================================

  static Future<String> revampExportAllSheetsToExcel({
    required String spreadsheetId,
    required String credentialAssetPath,
    bool shareFile = true,
  }) async {
    AutoRefreshingAuthClient? client;

    try {
      // ========================================================
      // VALIDASI SPREADSHEET ID
      // ========================================================

      if (spreadsheetId.trim().isEmpty) {
        throw Exception(
          'Spreadsheet ID kosong.',
        );
      }

      final String credentialJson =
      await rootBundle.loadString(
        credentialAssetPath,
      );

      if (credentialJson.trim().isEmpty) {
        throw Exception(
          'Credential JSON kosong.',
        );
      }

      final Map<String, dynamic> credentialMap =
      jsonDecode(credentialJson);

      final ServiceAccountCredentials credentials =
      ServiceAccountCredentials.fromJson(
        credentialMap,
      );

      // ========================================================
      // CONNECT GOOGLE SHEETS API
      // ========================================================

      client = await clientViaServiceAccount(
        credentials,
        scopes,
      );

      final sheets.SheetsApi sheetsApi =
      sheets.SheetsApi(
        client,
      );

      // ========================================================
      // AMBIL INFORMASI SPREADSHEET
      // ========================================================

      final sheets.Spreadsheet spreadsheet =
      await sheetsApi.spreadsheets.get(
        spreadsheetId,
      );

      final List<sheets.Sheet> allSheets =
          spreadsheet.sheets ?? [];

      if (allSheets.isEmpty) {
        throw Exception(
          'Tidak ditemukan sheet di Google Spreadsheet.',
        );
      }

      // ========================================================
      // BUAT EXCEL BARU
      // ========================================================

      final Excel excel =
      Excel.createExcel();


      final String defaultSheetName =
          excel.getDefaultSheet() ?? '';

      bool defaultSheetUsed = false;

      // ========================================================
      // LOOP SEMUA GOOGLE SHEETS
      // ========================================================

      for (
      final sheets.Sheet googleSheet
      in allSheets
      ) {
        // ======================================================
        // NAMA SHEET
        // ======================================================

        final String sheetTitle =
            googleSheet.properties?.title ?? '';

        if (sheetTitle.trim().isEmpty) {
          continue;
        }

        // ======================================================
        // RANGE
        // ======================================================

        final String range =
            "'$sheetTitle'";

        // ======================================================
        // AMBIL DATA GOOGLE SHEETS
        // ======================================================

        final sheets.ValueRange valueRange =
        await sheetsApi.spreadsheets.values.get(
          spreadsheetId,
          range,
        );

        final List<List<Object?>> rows =
            valueRange.values
                ?.map(
                  (row) => row
                  .map<Object?>(
                    (value) => value,
              )
                  .toList(),
            )
                .toList() ??
                [];

        final bool sheetIsBlank =
            rows.isEmpty ||
                rows.every(
                      (row) => row.every(
                        (value) =>
                    value == null ||
                        value.toString().trim().isEmpty,
                  ),
                );

        if (sheetIsBlank) {
          print(
            'Sheet kosong dilewati: $sheetTitle',
          );

          continue;
        }


        late final Sheet excelSheet;

        if (!defaultSheetUsed &&
            defaultSheetName.isNotEmpty) {
          // ----------------------------------------------------
          // RENAME SHEET1 MENJADI NAMA SHEET GOOGLE
          // ----------------------------------------------------

          excel.rename(
            defaultSheetName,
            sheetTitle,
          );

          excelSheet =
          excel[sheetTitle];

          defaultSheetUsed = true;

        } else {
          // ----------------------------------------------------
          // BUAT SHEET BARU
          // ----------------------------------------------------

          excelSheet =
          excel[sheetTitle];
        }

        // ======================================================
        // CARI JUMLAH KOLOM TERBESAR
        // ======================================================

        int maxColumns = 0;

        for (
        final List<Object?> row
        in rows
        ) {
          if (row.length > maxColumns) {
            maxColumns = row.length;
          }
        }

        if (maxColumns == 0) {
          continue;
        }

        // ======================================================
        // SUPER HEADER
        // ======================================================

        const String superHeaderTitle =
            'DATABASE STOK BARANG ENGINEERING';

        // ======================================================
        // STYLE SUPER HEADER
        // ======================================================

        final CellStyle superHeaderStyle =
        CellStyle(
          bold: true,
          fontSize: 14,
          fontColorHex:
          ExcelColor.fromHexString(
            '#FFFFFF',
          ),
          backgroundColorHex:
          ExcelColor.fromHexString(
            '#1F4E79',
          ),
          horizontalAlign:
          HorizontalAlign.Center,
          verticalAlign:
          VerticalAlign.Center,
        );

        // ======================================================
        // STYLE HEADER GOOGLE SHEETS
        // ======================================================

        final CellStyle columnHeaderStyle =
        CellStyle(
          bold: true,
          fontColorHex:
          ExcelColor.fromHexString(
            '#FFFFFF',
          ),
          backgroundColorHex:
          ExcelColor.fromHexString(
            '#3B71CA',
          ),
          horizontalAlign:
          HorizontalAlign.Center,
          verticalAlign:
          VerticalAlign.Center,
        );

        // ======================================================
        // STYLE KHUSUS WARNA BIRU
        // ======================================================

        final CellStyle specialBlueStyle =
        CellStyle(
          bold: true,
          fontColorHex:
          ExcelColor.fromHexString(
            '#FFFFFF',
          ),
          backgroundColorHex:
          ExcelColor.fromHexString(
            '#3B71CA',
          ),
          horizontalAlign:
          HorizontalAlign.Left,
          verticalAlign:
          VerticalAlign.Center,
        );

        // ======================================================
        // CELL A1
        // ======================================================

        final CellIndex superHeaderCell =
        CellIndex.indexByColumnRow(
          columnIndex: 0,
          rowIndex: 0,
        );

        excelSheet
            .cell(superHeaderCell)
            .value = TextCellValue(
          superHeaderTitle,
        );

        excelSheet
            .cell(superHeaderCell)
            .cellStyle =
            superHeaderStyle;

        // ======================================================
        // MERGE SUPER HEADER
        // ======================================================

        if (maxColumns > 1) {
          final CellIndex firstCell =
          CellIndex.indexByColumnRow(
            columnIndex: 0,
            rowIndex: 0,
          );

          final CellIndex lastCell =
          CellIndex.indexByColumnRow(
            columnIndex: maxColumns - 1,
            rowIndex: 0,
          );

          excelSheet.merge(
            firstCell,
            lastCell,
            customValue: TextCellValue(
              superHeaderTitle,
            ),
          );

          excelSheet
              .cell(firstCell)
              .cellStyle =
              superHeaderStyle;
        }

        // ======================================================
        // MASUKKAN DATA GOOGLE SHEETS
        // ======================================================

        for (
        int rowIndex = 0;
        rowIndex < rows.length;
        rowIndex++
        ) {
          final List<Object?> row =
          rows[rowIndex];

          for (
          int columnIndex = 0;
          columnIndex < maxColumns;
          columnIndex++
          ) {
            final CellIndex cellIndex =
            CellIndex.indexByColumnRow(
              columnIndex: columnIndex,
              rowIndex: rowIndex + 1,
            );

            Object? value;

            if (columnIndex < row.length) {
              value = row[columnIndex];
            } else {
              value = null;
            }

            // ==================================================
            // HEADER GOOGLE SHEETS
            // ==================================================

            if (rowIndex == 0) {
              final String headerValue =
                  value?.toString() ?? '';

              excelSheet
                  .cell(cellIndex)
                  .value = TextCellValue(
                headerValue,
              );

              excelSheet
                  .cell(cellIndex)
                  .cellStyle =
                  columnHeaderStyle;
            }

            // ==================================================
            // DATA
            // ==================================================

            else {
              if (value == null) {
                excelSheet
                    .cell(cellIndex)
                    .value = TextCellValue(
                  '',
                );
              } else if (value is int) {
                excelSheet
                    .cell(cellIndex)
                    .value = IntCellValue(
                  value,
                );
              } else if (value is double) {
                excelSheet
                    .cell(cellIndex)
                    .value = DoubleCellValue(
                  value,
                );
              } else if (value is num) {
                excelSheet
                    .cell(cellIndex)
                    .value = DoubleCellValue(
                  value.toDouble(),
                );
              } else {
                excelSheet
                    .cell(cellIndex)
                    .value = TextCellValue(
                  value.toString(),
                );
              }
            }
          }
        }

        // ======================================================
        // NORMALISASI NAMA SHEET
        // ======================================================

        final String normalizedSheetName =
        sheetTitle
            .toLowerCase()
            .replaceAll(' ', '')
            .replaceAll('_', '');

        // ======================================================
        // CEK SHEET LEMARI
        // ======================================================

        final bool isLemariSheet =
            normalizedSheetName ==
                'lemari1' ||
                normalizedSheetName ==
                    'lemari2' ||
                normalizedSheetName ==
                    'lemari3';

        // ======================================================
        // CEK SHEET BARANG MASUK / KELUAR
        // ======================================================

        final bool isBarangSheet =
            normalizedSheetName ==
                'barangmasuk' ||
                normalizedSheetName ==
                    'barangkeluar';

        if (isLemariSheet) {
          final CellIndex cellA2 =
          CellIndex.indexByColumnRow(
            columnIndex: 0,
            rowIndex: 1,
          );

          excelSheet
              .cell(cellA2)
              .value = TextCellValue(
            '',
          );

          excelSheet
              .cell(cellA2)
              .cellStyle =
              specialBlueStyle;

        }

        if (isLemariSheet) {
          for (
          int columnIndex = 0;
          columnIndex <= 9;
          columnIndex++
          ) {
            final CellIndex cellIndex =
            CellIndex.indexByColumnRow(
              columnIndex: columnIndex,
              rowIndex: 3,
            );

            excelSheet
                .cell(cellIndex)
                .cellStyle =
                specialBlueStyle;
          }

        }

        if (isBarangSheet) {
          for (
          int columnIndex = 0;
          columnIndex <= 7;
          columnIndex++
          ) {
            final CellIndex cellIndex =
            CellIndex.indexByColumnRow(
              columnIndex: columnIndex,
              rowIndex: 3,
            );

            excelSheet
                .cell(cellIndex)
                .cellStyle =
                specialBlueStyle;
          }

        }

        // ======================================================
        // AUTO WIDTH KOLOM
        // ======================================================

        for (
        int columnIndex = 0;
        columnIndex < maxColumns;
        columnIndex++
        ) {
          int maxLength = 0;

          for (
          final List<Object?> row
          in rows
          ) {
            if (columnIndex >= row.length) {
              continue;
            }

            final Object? value =
            row[columnIndex];

            if (value == null) {
              continue;
            }

            final int length =
                value.toString().length;

            if (length > maxLength) {
              maxLength = length;
            }
          }

          int columnWidth =
              maxLength + 2;

          if (columnWidth < 10) {
            columnWidth = 10;
          }

          if (columnWidth > 50) {
            columnWidth = 50;
          }

          excelSheet.setColumnWidth(
            columnIndex,
            columnWidth.toDouble(),
          );
        }
      }


      if (!defaultSheetUsed &&
          defaultSheetName.isNotEmpty) {
        excel.delete(
          defaultSheetName,
        );

        print(
          'Semua Google Sheet kosong. '
              'Default Sheet1 dihapus.',
        );
      }

      // ========================================================
      // ENCODE EXCEL
      // ========================================================

      final List<int>? excelBytes =
      excel.encode();

      if (excelBytes == null ||
          excelBytes.isEmpty) {
        throw Exception(
          'Gagal membuat file Excel.',
        );
      }

      // ========================================================
      // TANGGAL
      // ========================================================

      final DateTime now =
      DateTime.now();

      final String tanggal =
          '${now.year}-'
          '${now.month.toString().padLeft(2, '0')}-'
          '${now.day.toString().padLeft(2, '0')}';

      // ========================================================
      // WAKTU
      // ========================================================

      final String waktu =
          '${now.hour.toString().padLeft(2, '0')}-'
          '${now.minute.toString().padLeft(2, '0')}-'
          '${now.second.toString().padLeft(2, '0')}';

      // ========================================================
      // NAMA FILE
      // ========================================================

      final String fileName =
          'Daftar_Alat_Lemari_Basment2_'
          '${tanggal}_'
          '$waktu.xlsx';

      // ========================================================
      // FOLDER DOWNLOAD
      // ========================================================

      final Directory directory =
      Directory(
        '/storage/emulated/0/Download',
      );

      if (!await directory.exists()) {
        await directory.create(
          recursive: true,
        );
      }

      // ========================================================
      // FILE PATH
      // ========================================================

      final String filePath =
          '${directory.path}/$fileName';

      final File file =
      File(filePath);

      // ========================================================
      // WRITE FILE
      // ========================================================

      await file.writeAsBytes(
        excelBytes,
        flush: true,
      );

      // ========================================================
      // VALIDASI FILE
      // ========================================================

      if (!await file.exists()) {
        throw Exception(
          'File Excel gagal dibuat.',
        );
      }

      final int fileSize =
      await file.length();

      if (fileSize <= 0) {
        throw Exception(
          'File Excel yang dibuat kosong.',
        );
      }

      // ========================================================
      // SHARE FILE
      // ========================================================

      if (shareFile) {
        await Share.shareXFiles(
          [
            XFile(
              file.path,
            ),
          ],
          text:
          'Database Google Sheets',
        );
      }

      // ========================================================
      // RETURN FILE PATH
      // ========================================================

      return file.path;
    } catch (e) {

      rethrow;
    } finally {
      client?.close();
    }
  }
}