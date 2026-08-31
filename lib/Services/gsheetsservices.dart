import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
import 'package:appsenginventory/assets/Files/sheetsconfigs.dart';

class GSheetsServicesEmployees {
  static Worksheet? sheet;
  static Worksheet? sheetPosisi;
  static Worksheet? sheetLemari;
  static Worksheet? sheetLogin;
  static Worksheet? sheetOTP;
  static Worksheet? sheetsLemari1;
  static Worksheet? sheetsLemari2;
  static Worksheet? sheetsLemari3;
  static Worksheet? sheetsBarangMasuk;
  static Worksheet? sheetsBarangKeluar;
  static Worksheet? sheetsDashboard;

  static bool _initialized = false;

  static Future<void> init() async {

    try {

      final credential = await rootBundle.loadString(
        'lib/assets/Files/gsheetsproects-613d6eb9ccc1.json',
      );

      debugPrint("Credential berhasil dibaca.");

      final gsheets = GSheets(credential);

      //AppsInventorty
      final spreadsheet = await gsheets.spreadsheet(GsheetsConfigs.gsheetsID,);
      final employeeSheet = spreadsheet.worksheetByTitle(GsheetsConfigs.workSheetsNames,);
      final posisiSheet = spreadsheet.worksheetByTitle(GsheetsConfigs.workSheetsNamesPosisi,);
      final posisiLemari = spreadsheet.worksheetByTitle(GsheetsConfigs.workSheetsNamesLemari,);
      final loginsLog = spreadsheet.worksheetByTitle(GsheetsConfigs.workSheetsLogin,);
      final otpCodes = spreadsheet.worksheetByTitle(GsheetsConfigs.workSheetsotp,);

      //LemariBasment
      final spreadsheetLemariBarang = await gsheets.spreadsheet(GsheetsConfigs.gsheetsIDDaftarLemari,);
      final sheetBarangLemari1 = spreadsheetLemariBarang.worksheetByTitle(GsheetsConfigs.workSheetsLemari1,);
      final sheetBarangLemari2 = spreadsheetLemariBarang.worksheetByTitle(GsheetsConfigs.workSheetsLemari2,);
      final sheetBarangLemari3 = spreadsheetLemariBarang.worksheetByTitle(GsheetsConfigs.workSheetsLemari3,);
      final sheetBarangMasuk = spreadsheetLemariBarang.worksheetByTitle(GsheetsConfigs.workSheetsBarangMasuk,);
      final sheetBarangKeluar = spreadsheetLemariBarang.worksheetByTitle(GsheetsConfigs.workSheetsBarangKeluar,);
      final sheetDashboard = spreadsheetLemariBarang.worksheetByTitle(GsheetsConfigs.workSheetsDashBoard,);


      sheet = employeeSheet;
      sheetPosisi = posisiSheet;
      sheetLemari = posisiLemari;
      sheetLogin = loginsLog;
      sheetOTP = otpCodes;

      sheetsLemari1 = sheetBarangLemari1;
      sheetsLemari2 = sheetBarangLemari2;
      sheetsLemari3 = sheetBarangLemari3;
      sheetsBarangMasuk = sheetBarangMasuk;
      sheetsBarangKeluar = sheetBarangKeluar;
      sheetsDashboard = sheetDashboard;


      _initialized = true;

      debugPrint("======================================");
      debugPrint("GOOGLE SHEETS BERHASIL TERHUBUNG");
      debugPrint("======================================");
      debugPrint("Initialized        : $_initialized",);

    } catch (e, stackTrace) {
      debugPrint("======================================");
      debugPrint("GOOGLE SHEETS INIT GAGAL");
      debugPrint("ERROR : $e");
      debugPrint("STACK : $stackTrace");
      debugPrint("======================================");
      rethrow;
    }
  }
}