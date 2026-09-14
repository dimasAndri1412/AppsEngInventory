import 'package:flutter/material.dart';

import 'gsheetsservices.dart';

class GsheetsNotifikasiBarangMasukKeluar {
  String? revampTanggalNotfikasiBarangKeluar;
  String? revampNamaProsesNotfikasiBarangKeluar;
  String? revampKodeNotifikasBarangKeluar;
  String? revampNamaNotfikiasBarangKeluar;
  String? revampSatuanNotifikasiBarangKeluar;
  String? revampJumlahNotfikasiBarangKeluar;
  String? revampLemariNotifikasiBarangKeluar;
  String? revampPICNotfikAIBarangKeluar;
  String? revampKeteranganNotfikasBarangKeluar;
  String? revampWaktuNotfikasiBarangKeluar;

  Future<void> revampInsertNotifikasiBarangKeluar() async {

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
      revampTanggalNotfikasiBarangKeluar?.trim() ?? '',
      revampNamaProsesNotfikasiBarangKeluar?.trim() ?? '',
      revampKodeNotifikasBarangKeluar?.trim() ?? '',
      revampNamaNotfikiasBarangKeluar?.trim() ?? '',
      revampJumlahNotfikasiBarangKeluar?.trim() ?? '',
      revampSatuanNotifikasiBarangKeluar?.trim() ?? '',
      revampLemariNotifikasiBarangKeluar?.trim() ?? '',
      revampPICNotfikAIBarangKeluar?.trim() ?? '',
      revampKeteranganNotfikasBarangKeluar?.trim() ?? '',
      revampWaktuNotfikasiBarangKeluar?.trim() ?? ''
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