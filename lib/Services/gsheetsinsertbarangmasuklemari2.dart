import 'package:flutter/material.dart';

import 'gsheetsservices.dart';

class GsheetsBarangMasukLemari2 {
  String? revampNomerUrutBarangMasuk;
  String? revampKodeBarangMasuk;
  String? revampNamaBarangMasuk;
  String? revampSatuanBarangMasuk;
  String? revampJumlahBarangMasuk;
  String? revampTotalBarangMasuk;
  String? revampTotalBarangKeluar;
  String? revampJumlahAkhirBarangMasuk;
  String? revampJumlahMinimunBarangMasuk;
  String? revampStatusBarangMasuk;

  Future<void> revampInsertBarangMasukLemari2() async {

    if (GSheetsServicesEmployees.sheetsLemari2 == null) {
      debugPrint("Sheet NULL, melakukan init...");
      await GSheetsServicesEmployees.init();
    }

    if (GSheetsServicesEmployees.sheetsLemari2 == null) {
      throw Exception(
        "Google Sheets gagal diinisialisasi.",
      );
    }

    final employeeSheet =
    GSheetsServicesEmployees.sheetsLemari2!;

    final List<String> row = [
      revampNomerUrutBarangMasuk?.trim() ?? '',
      revampKodeBarangMasuk?.trim() ?? '',
      revampNamaBarangMasuk?.trim() ?? '',
      revampSatuanBarangMasuk?.trim() ?? '',
      revampJumlahBarangMasuk?.trim() ?? '',
      revampTotalBarangMasuk?.trim() ?? '',
      revampTotalBarangKeluar?.trim() ?? '',
      revampJumlahAkhirBarangMasuk?.trim() ?? '',
      revampJumlahMinimunBarangMasuk?.trim() ?? '',
      revampStatusBarangMasuk?.trim() ?? ''
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