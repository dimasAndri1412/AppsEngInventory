import 'package:appsenginventory/Services/gsheetsservices.dart';
import 'package:flutter/material.dart';

class GsheetsInsertControllers {
  String? revampEmployeeid;
  String? revampFrontName;
  String? revampBackName;
  String? revampFullName;
  String? revampUserName;
  String? revampBirthDate;
  String? revampAddress;
  String? revampEmailAddress;
  String? revampPhoneNumber;
  String? revampRoles;
  String? revampPass;
  String? revampPosisi;

  Future<void> revampRegistrations() async {

    if (GSheetsServicesEmployees.sheet == null) {
      debugPrint("Sheet NULL, melakukan init...");
      await GSheetsServicesEmployees.init();
    }

    if (GSheetsServicesEmployees.sheet == null) {
      throw Exception(
        "Google Sheets gagal diinisialisasi.",
      );
    }

    final employeeSheet =
    GSheetsServicesEmployees.sheet!;

    final List<String> row = [
      revampEmployeeid?.trim() ?? '',
      revampFrontName?.trim() ?? '',
      revampBackName?.trim() ?? '',
      revampFullName?.trim() ?? '',
      revampUserName?.trim() ?? '',
      revampBirthDate?.trim() ?? '',
      revampAddress?.trim() ?? '',
      revampEmailAddress?.trim() ?? '',
      revampPhoneNumber?.trim() ?? '',
      revampRoles?.trim() ?? '',
      revampPosisi?.trim() ?? '',
      revampPass?.trim() ?? '',
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