import 'package:appsenginventory/assets/Files/sheetsconfigs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';

class GSheetsServicesEmployees {
  static Spreadsheet? spreadsheetLemariBarang;

  static Worksheet? sheet;
  static Worksheet? sheetPosisi;
  static Worksheet? sheetLemari;
  static Worksheet? sheetLogin;
  static Worksheet? sheetLogout;
  static Worksheet? sheetOTP;
  static Worksheet? sheetNotif;

  static Worksheet? sheetDaftarStock;
  static Worksheet? sheetDaftarStock2;
  static Worksheet? sheetDaftarStock3;

  static Worksheet? sheetsLemari1;
  static Worksheet? sheetsLemari2;
  static Worksheet? sheetsLemari3;

  static Worksheet? sheetsBarangMasuk;
  static Worksheet? sheetsBarangKeluar;
  static Worksheet? sheetsDashboard;
  static Worksheet? sheetsPicture;

  static bool _initialized = false;
  static Future<void>? _initializing;

  static const String credentialPath =
      'lib/assets/Files/gsheetsproects-86cf2c85d624.json';

  static Future<void> init() async {
    if (_initialized) return;

    final pending = _initializing;

    if (pending != null) {
      await pending;
      return;
    }

    final future = _initInternal();
    _initializing = future;

    try {
      await future;
    } finally {
      if (identical(_initializing, future)) {
        _initializing = null;
      }
    }
  }

  static Future<void> _initInternal() async {
    try {
      final credential =
      await rootBundle.loadString(credentialPath);

      final gsheets = GSheets(credential);

      final spreadsheet = await gsheets.spreadsheet(
        GsheetsConfigs.gsheetsID,
      );

      final employeeSheet = spreadsheet.worksheetByTitle(
        GsheetsConfigs.workSheetsNames,
      );

      final posisiSheet = spreadsheet.worksheetByTitle(
        GsheetsConfigs.workSheetsNamesPosisi,
      );

      final posisiLemari = spreadsheet.worksheetByTitle(
        GsheetsConfigs.workSheetsNamesLemari,
      );

      final loginsLog = spreadsheet.worksheetByTitle(
        GsheetsConfigs.workSheetsLogin,
      );

      final logoutlogs = spreadsheet.worksheetByTitle(
        GsheetsConfigs.workSheetsLogout,
      );

      final otpCodes = spreadsheet.worksheetByTitle(
        GsheetsConfigs.workSheetsotp,
      );

      final notif = spreadsheet.worksheetByTitle(
        GsheetsConfigs.workSheetnotif,
      );

      final spreadsheetBarang = await gsheets.spreadsheet(
        GsheetsConfigs.gsheetsIDDaftarLemari,
      );

      final stock1 = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsDaftarStock,
      );

      final stock2 = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsDaftarStock2,
      );

      final stock3 = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsDaftarStock3,
      );

      final lemari1 = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsLemari1,
      );

      final lemari2 = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsLemari2,
      );

      final lemari3 = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsLemari3,
      );

      final barangMasuk = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsBarangMasuk,
      );

      final barangKeluar = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsBarangKeluar,
      );

      final dashboard = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsDashBoard,
      );

      final picture = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsPicture,
      );

      if (barangMasuk == null) {
        throw Exception(
          'Worksheet Barang Masuk tidak ditemukan: '
              '${GsheetsConfigs.workSheetsBarangMasuk}',
        );
      }

      if (picture == null) {
        throw Exception(
          'Worksheet foto tidak ditemukan: '
              '${GsheetsConfigs.workSheetsPicture}',
        );
      }

      // Tetapkan seluruh referensi setelah pencarian selesai.
      spreadsheetLemariBarang = spreadsheetBarang;

      sheet = employeeSheet;
      sheetPosisi = posisiSheet;
      sheetLemari = posisiLemari;
      sheetLogin = loginsLog;
      sheetLogout = logoutlogs;
      sheetOTP = otpCodes;
      sheetNotif = notif;

      sheetDaftarStock = stock1;
      sheetDaftarStock2 = stock2;
      sheetDaftarStock3 = stock3;

      sheetsLemari1 = lemari1;
      sheetsLemari2 = lemari2;
      sheetsLemari3 = lemari3;

      sheetsBarangMasuk = barangMasuk;
      sheetsBarangKeluar = barangKeluar;
      sheetsDashboard = dashboard;
      sheetsPicture = picture;

      _initialized = true;

      debugPrint('Google Sheets berhasil diinisialisasi.');
    } catch (e, stackTrace) {
      _initialized = false;

      debugPrint('GAGAL INISIALISASI GOOGLE SHEETS: $e');
      debugPrint('$stackTrace');

      rethrow;
    }
  }
}