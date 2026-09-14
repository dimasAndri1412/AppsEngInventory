import 'package:flutter/material.dart';

import 'gsheetsservices.dart';

class GsheetsDaftarBarangLemari2 {

  String? no;
  String? namaBarang;
  String? jumlahStok;
  String? satuan;
  String? lokasiLemari;

  Future<void> insertDaftarBarangLemari2() async {

    if (GSheetsServicesEmployees.sheetDaftarStock2 == null) {
      await GSheetsServicesEmployees.init();
    }

    if (GSheetsServicesEmployees.sheetDaftarStock2 == null) {
      throw Exception(
        "Google Sheets Dashboard gagal diinisialisasi.",
      );
    }

    final worksheet = GSheetsServicesEmployees.sheetDaftarStock2!;
    final List<String> row = [
      no?.trim() ?? '',
      namaBarang?.trim() ?? '',
      jumlahStok?.trim() ?? '',
      satuan?.trim() ?? '',
      lokasiLemari?.trim() ?? '',
    ];

    final existingRows = await worksheet.values.allRows();
    int lastDataRow = 0;

    for (int i = 0; i < existingRows.length; i++) {
      final currentRow = existingRows[i];
      final hasData = currentRow.any((value) => value.trim().isNotEmpty,
      );

      if (hasData) {
        lastDataRow = i + 1;
      }
    }

    if (lastDataRow < 1) {
      lastDataRow = 1;
    }

    final insertRowNumber = lastDataRow + 1;


    final result =
    await worksheet.values.insertRow(insertRowNumber,row);
    debugPrint("HASIL INSERT DAFTAR BARANG: $result",);
  }
}