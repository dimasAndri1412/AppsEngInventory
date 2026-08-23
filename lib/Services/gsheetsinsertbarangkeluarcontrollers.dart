import 'package:flutter/material.dart';
import 'gsheetsservices.dart';

class GsheetsInsertBarangKeluar {
  String? revampNomerUrutBarangKeluar;
  String? revampKodeBarangKeluar;
  String? revampTanggalBarangKeluar;
  String? revampNamaBarangKeluar;
  String? revampJumlahBarangKeluar;
  String? revampSatuanBarangKeluar;
  String? revampPICBarangKeluar;
  String? revampLemariBarangKeluar;
  String? revampKeteranganBarangKeluar;

  Future<void> revampInsertBarangMasuk() async {
    if (GSheetsServicesEmployees.sheetsBarangKeluar == null) {
      await GSheetsServicesEmployees.init();
    }

    final sheet = GSheetsServicesEmployees.sheetsBarangKeluar!;

    final row = [
      revampNomerUrutBarangKeluar ?? "",
      revampKodeBarangKeluar ?? "",
      revampTanggalBarangKeluar ?? "",
      revampNamaBarangKeluar ?? "",
      revampJumlahBarangKeluar ?? "",
      revampSatuanBarangKeluar ?? "",
      revampPICBarangKeluar ?? "",
      revampLemariBarangKeluar ?? "",
      revampKeteranganBarangKeluar ?? "",
    ];

    final existing = await sheet.values.allRows();

    final rowNumber = existing.length + 1;

    final result = await sheet.values.insertRow(
      rowNumber,
      row,
    );

    debugPrint("INSERT BERHASIL -> $result");
  }
}