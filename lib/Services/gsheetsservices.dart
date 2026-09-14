import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
import 'package:appsenginventory/assets/Files/sheetsconfigs.dart';

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

  static bool _initialized = false;

  static Future<void> init() async {

    if (_initialized) {
      debugPrint(
        'Google Sheets sudah diinisialisasi.',
      );
      return;
    }

    try {

      final credential = await rootBundle.loadString(
        'lib/assets/Files/gsheetsproects-613d6eb9ccc1.json',
      );

      final gsheets = GSheets(
        credential,
      );


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

      spreadsheetLemariBarang = spreadsheetBarang;

      final sheetsDaftarStock = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsDaftarStock,
      );
      final sheetsDaftarStock2 = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsDaftarStock2,
      );
      final sheetsDaftarStock3 = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsDaftarStock3,
      );
      final sheetBarangLemari1 = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsLemari1,
      );
      final sheetBarangLemari2 = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsLemari2,
      );
      final sheetBarangLemari3 = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsLemari3,
      );
      final sheetBarangMasuk = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsBarangMasuk,
      );
      final sheetBarangKeluar = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsBarangKeluar,
      );
      final sheetDashboard = spreadsheetBarang.worksheetByTitle(
        GsheetsConfigs.workSheetsDashBoard,
      );


      sheet = employeeSheet;
      sheetPosisi = posisiSheet;
      sheetLemari = posisiLemari;
      sheetLogin = loginsLog;
      sheetLogout = logoutlogs;
      sheetOTP = otpCodes;
      sheetNotif = notif;

      sheetDaftarStock = sheetsDaftarStock;
      sheetDaftarStock2 = sheetsDaftarStock2;
      sheetDaftarStock3 = sheetsDaftarStock3;
      sheetsLemari1 = sheetBarangLemari1;
      sheetsLemari2 = sheetBarangLemari2;
      sheetsLemari3 = sheetBarangLemari3;
      sheetsBarangMasuk = sheetBarangMasuk;
      sheetsBarangKeluar = sheetBarangKeluar;
      sheetsDashboard = sheetDashboard;

      _initialized = true;
      debugPrint('Initialized : $_initialized',);

    } catch (e, stackTrace) {

      debugPrint('GOOGLE SHEETS INIT GAGAL',);
      debugPrint('ERROR : $e',);
      debugPrint('STACK : $stackTrace');

      rethrow;
    }
  }
}