import 'package:flutter/material.dart';

import 'gsheetsservices.dart';

class GsheetsNotifikasiBarangMasukLemari1 {
  String? revampTanggalNotfikasiBarangMasuk;
  String? revampNamaProsesNotfikasiBarangMasuk;
  String? revampKodeNotifikasBarangMasuk;
  String? revampNamaNotfikiasBarangMasuk;
  String? revampSatuanNotifikasiBarangMasuk;
  String? revampJumlahNotfikAIBarangMasuk;
  String? revampLemariNotifikasiBarangMasuk;
  String? revampPICNotfikAIBarangMasuk;
  String? revampKeteranganNotfikAIBarangMasuk;
  String? revampWaktuNotfikAIBarangMasuk;

  Future<void> revampInsertNotifikasiBarangMasukLemari1() async {

    if (GSheetsServicesEmployees.sheetNotif == null) {
      debugPrint("Sheet NULL, melakukan init...");
      await GSheetsServicesEmployees.init();
    }

    if (GSheetsServicesEmployees.sheetNotif == null) {
      throw Exception(
        "Google Sheets gagal diinisialisasi.",
      );
    }

    final employeeSheet = GSheetsServicesEmployees.sheetNotif!;

    final List<String> row = [
        revampTanggalNotfikasiBarangMasuk?.trim() ?? '',
        revampNamaProsesNotfikasiBarangMasuk?.trim() ?? '',
        revampKodeNotifikasBarangMasuk?.trim() ?? '',
        revampNamaNotfikiasBarangMasuk?.trim() ?? '',
        revampJumlahNotfikAIBarangMasuk?.trim() ?? '',
        revampSatuanNotifikasiBarangMasuk?.trim() ?? '',
        revampLemariNotifikasiBarangMasuk?.trim() ?? '',
        revampPICNotfikAIBarangMasuk?.trim() ?? '',
        revampKeteranganNotfikAIBarangMasuk?.trim() ?? '',
        revampWaktuNotfikAIBarangMasuk?.trim() ?? ''
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