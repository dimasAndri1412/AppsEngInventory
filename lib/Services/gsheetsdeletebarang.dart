import 'package:flutter/foundation.dart';
import 'package:gsheets/gsheets.dart';

import 'gsheetsservices.dart';

Future<bool> deleteBarangBerdasarkanKodeDanLemari({
  required String kodeBarang,
  required String lemari,
}) async {
  try {

    Worksheet? worksheetLemari;
    Worksheet? worksheetDaftarStock;

    switch (lemari.trim().toLowerCase()) {

      case "lemari1":
        worksheetLemari = GSheetsServicesEmployees.sheetsLemari1;
        worksheetDaftarStock = GSheetsServicesEmployees.sheetDaftarStock;
        break;

      case "lemari2":
        worksheetLemari = GSheetsServicesEmployees.sheetsLemari2;
        worksheetDaftarStock = GSheetsServicesEmployees.sheetDaftarStock2;
        break;

      case "lemari3":
        worksheetLemari = GSheetsServicesEmployees.sheetsLemari3;
        worksheetDaftarStock = GSheetsServicesEmployees.sheetDaftarStock3;
        break;

      default:
        throw Exception(
          "Lemari tidak dikenali: $lemari",
        );
    }

    if (worksheetLemari == null) {
      throw Exception(
        "$lemari belum diinisialisasi.",
      );
    }

    if (worksheetDaftarStock == null) {
      throw Exception(
        "Worksheet Daftar Stock untuk $lemari "
            "belum diinisialisasi.",
      );
    }

    final String kodeBarangDicari = kodeBarang.trim().toLowerCase();

    if (kodeBarangDicari.isEmpty) {
      throw Exception(
        "Kode Barang tidak boleh kosong.",
      );
    }

    final List<List<String>> rowsLemari = await worksheetLemari.values.allRows();


    if (rowsLemari.isEmpty) {
      debugPrint(
        "Sheet $lemari kosong.",
      );
      return false;
    }

    if (rowsLemari.length < 3) {
      debugPrint(
        "Sheet $lemari tidak memiliki "
            "header pada row 3.",
      );

      return false;
    }

    final List<String> headerLemari = rowsLemari[2];

    final int kodeBarangColumnIndexLemari =
    headerLemari.indexWhere(
          (String value) {
        return value
            .trim()
            .toLowerCase() ==
            'kode barang';
      },
    );



    if (kodeBarangColumnIndexLemari == -1) {
      return false;
    }

    int targetRowIndexLemari = -1;

    for (int i = 3; i < rowsLemari.length; i++) {
      final List<String> row = rowsLemari[i];


      if (kodeBarangColumnIndexLemari >= row.length) {
        continue;
      }

      final String kodeDiSheet = row[kodeBarangColumnIndexLemari].trim().toLowerCase();

      if (kodeDiSheet == kodeBarangDicari) {
        targetRowIndexLemari = i;
        break;
      }
    }

    if (targetRowIndexLemari == -1) {
      return false;
    }


    final int targetGoogleSheetRowLemari = targetRowIndexLemari + 1;

    final List<List<String>> rowsDaftarStock =
    await worksheetDaftarStock.values.allRows();

    int targetRowIndexDaftarStock = -1;
    int kodeBarangColumnIndexDaftarStock = -1;


    if (rowsDaftarStock.isEmpty) {

      await worksheetLemari.deleteRow(
        targetGoogleSheetRowLemari,
      );

      return true;
    }


    for (int rowIndex = 0; rowIndex < rowsDaftarStock.length;
    rowIndex++) {
      final List<String> row = rowsDaftarStock[rowIndex];

      for (int columnIndex = 0; columnIndex < row.length; columnIndex++) {
        final String value = row[columnIndex].trim().toLowerCase();

        if (value == 'kode barang') {
          kodeBarangColumnIndexDaftarStock = columnIndex;
          break;
        }
      }
      if (kodeBarangColumnIndexDaftarStock != -1) {
        break;
      }
    }


    if (kodeBarangColumnIndexDaftarStock == -1) {
      await worksheetLemari.deleteRow(targetGoogleSheetRowLemari);
      debugPrint("DELETE 1 BARIS dari $lemari BERHASIL.");
      return true;
    }


    for (int i = 0; i < rowsDaftarStock.length; i++) {
      final List<String> row = rowsDaftarStock[i];

      if (kodeBarangColumnIndexDaftarStock >= row.length) {
        continue;
      }

      final String kodeDiSheet = row[kodeBarangColumnIndexDaftarStock].trim().toLowerCase();


      if (kodeDiSheet == kodeBarangDicari) {
        targetRowIndexDaftarStock = i;
        break;
      }
    }


    int targetGoogleSheetRowDaftarStock = -1;

    if (targetRowIndexDaftarStock != -1) {
      targetGoogleSheetRowDaftarStock = targetRowIndexDaftarStock + 1;

    } else {
      debugPrint(
        "Kode '$kodeBarang' tidak ditemukan "
            "di Daftar Stock.",
      );
    }

    await worksheetLemari.deleteRow(
      targetGoogleSheetRowLemari,
    );


    if (targetGoogleSheetRowDaftarStock != -1) {

      await worksheetDaftarStock.deleteRow(
        targetGoogleSheetRowDaftarStock,
      );
    } else {
      debugPrint(
        "Tidak ada row Daftar Stock yang dihapus "
            "karena kode tidak ditemukan.",
      );
    }

    if (targetGoogleSheetRowDaftarStock != -1) {
      debugPrint(
        "Daftar Stock     : 1 ROW DIHAPUS",
      );
    } else {
      debugPrint(
        "Daftar Stock     : KODE TIDAK DITEMUKAN",
      );
    }
    return true;
  } catch (e, stackTrace) {

    debugPrint(
      "ERROR : $e",
    );
    debugPrint(
      "STACK : $stackTrace",
    );

    return false;
  }
}