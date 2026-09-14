import 'package:flutter/material.dart';

import 'gsheetsservices.dart';

class GsheetsDaftarBarangLemari1 {

  String? no;
  String? namaBarang;
  String? jumlahStok;
  String? satuan;
  String? lokasiLemari;

  Future<void> insertDaftarBarangLemari1() async {

    if (GSheetsServicesEmployees.sheetDaftarStock == null) {
      await GSheetsServicesEmployees.init();
    }

    if (GSheetsServicesEmployees.sheetDaftarStock == null) {
      throw Exception(
        "Google Sheets Dashboard gagal diinisialisasi.",
      );
    }

    final worksheet = GSheetsServicesEmployees.sheetDaftarStock!;
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