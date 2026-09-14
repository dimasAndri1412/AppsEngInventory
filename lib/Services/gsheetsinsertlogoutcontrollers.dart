import 'package:appsenginventory/Controller/key.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'gsheetsservices.dart';

class GsheetsInsertLogoutControllers {

  Future<void> revampInsertLogOutControllers() async {

    if (GSheetsServicesEmployees.sheetLogout == null) {
      debugPrint("Sheet NULL, melakukan init...");
      await GSheetsServicesEmployees.init();
    }

    if (GSheetsServicesEmployees.sheetLogout == null) {
      throw Exception(
        "Google Sheets gagal diinisialisasi.",
      );
    }

    final employeeSheet = GSheetsServicesEmployees.sheetLogout!;

    final currentDate = DateFormat('yyyy-MM-dd').format(
      DateTime.now(),
    );
    final waktu = DateFormat('HH:mm:ss').format(
      DateTime.now(),
    );

    final String employeeids = sideBarEmployeeIDController.text.trim();
    final String fullnames = sideBarFullNameController.text.trim();
    final String usernames = sideBarUserNamesController.text.trim();
    final String posisi = sideBarJabatanController.text.trim();
    final String logindate = currentDate;
    final String logintime = waktu;

    final List<String> row = [
      employeeids,
      fullnames,
      usernames,
      posisi,
      logindate,
      logintime
    ];

    final existingRows = await employeeSheet.values.allRows();

    int lastDataRow = 0;

    for (int i = 0; i < existingRows.length; i++) {
      final currentRow = existingRows[i];

      final hasData = currentRow.any(
            (value) => value.trim().isNotEmpty,
      );

      if (hasData) {
        lastDataRow = i + 1;
      }
    }

    if (lastDataRow < 1) {
      lastDataRow = 1;
    }

    final insertRowNumber = lastDataRow + 1;
    final result = await employeeSheet.values.insertRow(
      insertRowNumber,
      row,
    );

    debugPrint(
      "HASIL INSERT: $result",
    );
    debugPrint("======================================");
    debugPrint("INSERT GOOGLE SHEETS BERHASIL");
    debugPrint(
      "ROW: $insertRowNumber",
    );
    debugPrint("======================================");
  }

}