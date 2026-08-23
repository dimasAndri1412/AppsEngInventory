import 'package:flutter/material.dart';

import 'gsheetsservices.dart';

class GsheetsInsertBarangMasuk {

  String? revampNomerUrutBarangMasuk;
  String? revampKodeBarangMasuk;
  String? revampTanggalBarangMasuk;
  String? revampNamaBarangMasuk;
  String? revampJumlahBarangMasuk;
  String? revampSatuanBarangMasuk;
  String? revampPICBarangMasuk;
  String? revampLemariBarangMasuk;
  String? revampKeteranganBarangMasuk;


  Future<void> revampInsertBarangMasuk() async {

    if (GSheetsServicesEmployees.sheetsBarangMasuk == null) {
      debugPrint("Sheet NULL, melakukan init...");
      await GSheetsServicesEmployees.init();
    }

    if (GSheetsServicesEmployees.sheetsBarangMasuk == null) {
      throw Exception(
        "Google Sheets gagal diinisialisasi.",
      );
    }

    final employeeSheet =
    GSheetsServicesEmployees.sheetsBarangMasuk!;

    final List<String> row = [
      revampNomerUrutBarangMasuk?.trim() ?? '',
      revampTanggalBarangMasuk?.trim() ?? '',
      revampKodeBarangMasuk?.trim() ?? '',
      revampNamaBarangMasuk?.trim() ?? '',
      revampJumlahBarangMasuk?.trim() ?? '',
      revampSatuanBarangMasuk?.trim() ?? '',
      revampPICBarangMasuk?.trim() ?? '',
      revampLemariBarangMasuk?.trim() ?? '',
      revampKeteranganBarangMasuk?.trim() ?? ''
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