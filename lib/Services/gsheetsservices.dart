import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
import 'package:appsenginventory/assets/Files/sheetsConfigs.dart';

class GSheetsServicesEmployees {
  static Worksheet? sheet;

  static Future<void> init() async {
    try {
      final credential = await rootBundle.loadString(
        'lib/assets/Files/gsheetsproects-face98242795.json',
      );

      final gsheets = GSheets(credential);

      final spreadsheet = await gsheets.spreadsheet(
        gsheetsConfigs.gsheetsID,
      );

      sheet = spreadsheet.worksheetByTitle(
        gsheetsConfigs.workSheetsNames,
      );

      if (sheet == null) {
        throw Exception(
          'Worksheet "${gsheetsConfigs.workSheetsNames}" tidak ditemukan.',
        );
      }

      print('Google Sheets berhasil terhubung.');
    } catch (e) {
      print('Gagal menghubungkan Google Sheets: $e');
    }
  }
}