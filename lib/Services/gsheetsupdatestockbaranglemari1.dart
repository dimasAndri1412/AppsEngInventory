import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

import 'gsheetsservices.dart';

class GsheetsUpdateBarangKeluar {
  String? revampKodeBarangKeluar;
  String? revampNamaBarangKeluar;
  String? revampJumlahBarangKeluar;
  String? revampLemariBarangKeluar;

  Future<void> revampUpdateStockBarang() async {
    // ============================================================
    // 1. CEK INISIALISASI GSHEETS
    // ============================================================

    if (GSheetsServicesEmployees.sheetsLemari1 == null ||
        GSheetsServicesEmployees.sheetsLemari2 == null ||
        GSheetsServicesEmployees.sheetsLemari3 == null) {
      debugPrint(
        "Sheet lemari belum diinisialisasi.",
      );

      await GSheetsServicesEmployees.init();
    }

    // ============================================================
    // 2. AMBIL DATA DARI VARIABLE
    // ============================================================

    final kodeBarang = revampKodeBarangKeluar?.trim() ?? '';

    final namaBarang = revampNamaBarangKeluar?.trim() ?? '';

    final jumlahKeluarText = revampJumlahBarangKeluar?.trim() ?? '';

    final namaLemari = revampLemariBarangKeluar?.trim() ?? '';

    debugPrint(
      "==========================================",
    );

    debugPrint(
      "DATA UPDATE BARANG KELUAR",
    );

    debugPrint(
      "Kode Barang     : $kodeBarang",
    );

    debugPrint(
      "Nama Barang     : $namaBarang",
    );

    debugPrint(
      "Jumlah Keluar   : $jumlahKeluarText",
    );

    debugPrint(
      "Lemari          : $namaLemari",
    );

    debugPrint(
      "==========================================",
    );

    // ============================================================
    // 3. VALIDASI DATA
    // ============================================================

    if (kodeBarang.isEmpty) {
      throw Exception(
        "Kode Barang tidak boleh kosong.",
      );
    }

    if (namaBarang.isEmpty) {
      throw Exception(
        "Nama Barang tidak boleh kosong.",
      );
    }

    if (jumlahKeluarText.isEmpty) {
      throw Exception(
        "Jumlah Barang Keluar tidak boleh kosong.",
      );
    }

    if (namaLemari.isEmpty) {
      throw Exception(
        "Lemari Barang tidak boleh kosong.",
      );
    }

    final jumlahKeluar =
    int.tryParse(jumlahKeluarText);

    if (jumlahKeluar == null) {
      throw Exception(
        "Jumlah Barang Keluar harus berupa angka.",
      );
    }

    if (jumlahKeluar <= 0) {
      throw Exception(
        "Jumlah Barang Keluar harus lebih dari 0.",
      );
    }

    // ============================================================
    // 4. TENTUKAN WORKSHEET BERDASARKAN LEMARI
    // ============================================================

    Worksheet? worksheet;

    switch (namaLemari.toLowerCase()) {
      case "lemari 1":
      case "lemari1":
        worksheet =
            GSheetsServicesEmployees.sheetsLemari1;
        break;

      case "lemari 2":
      case "lemari2":
        worksheet =
            GSheetsServicesEmployees.sheetsLemari2;
        break;

      case "lemari 3":
      case "lemari3":
        worksheet =
            GSheetsServicesEmployees.sheetsLemari3;
        break;

      default:
        throw Exception(
          "Lemari '$namaLemari' tidak dikenali.",
        );
    }

    if (worksheet == null) {
      throw Exception(
        "Worksheet untuk '$namaLemari' tidak ditemukan.",
      );
    }

    // ============================================================
    // 5. BACA SELURUH DATA SHEET
    //
    // JANGAN LANGSUNG MENGANGGAP ROW 2 / ROW 3 SEBAGAI HEADER.
    // HEADER AKAN DICARI OTOMATIS.
    // ============================================================

    final values =
    await worksheet.values.allRows();

    if (values.isEmpty) {
      throw Exception(
        "Data pada $namaLemari kosong.",
      );
    }

    debugPrint(
      "==========================================",
    );

    debugPrint(
      "JUMLAH ROW SHEET : ${values.length}",
    );

    debugPrint(
      "==========================================",
    );

    // ============================================================
    // 6. CARI HEADER SECARA OTOMATIS
    // ============================================================

    int headerIndex = -1;

    int kodeBarangColumn = -1;
    int namaBarangColumn = -1;
    int stokAwalColumn = -1;
    int totalKeluarColumn = -1;
    int stokAkhirColumn = -1;

    for (int i = 0; i < values.length; i++) {
      final row = values[i];

      for (int j = 0; j < row.length; j++) {
        final cellValue =
        row[j].trim().toLowerCase();

        if (cellValue == "kode barang") {
          headerIndex = i;
          kodeBarangColumn = j;

          // ==============================================
          // CARI COLUMN HEADER LAIN PADA BARIS YANG SAMA
          // ==============================================

          for (int k = 0; k < row.length; k++) {
            final headerName =
            row[k].trim().toLowerCase();

            if (headerName == "kode barang") {
              kodeBarangColumn = k;
            }

            if (headerName == "nama barang") {
              namaBarangColumn = k;
            }

            if (headerName == "stok awal") {
              stokAwalColumn = k;
            }

            if (headerName == "total keluar") {
              totalKeluarColumn = k;
            }

            if (headerName == "stok akhir") {
              stokAkhirColumn = k;
            }
          }

          break;
        }
      }

      if (headerIndex != -1) {
        break;
      }
    }

    // ============================================================
    // 7. VALIDASI HEADER
    // ============================================================

    if (headerIndex == -1) {
      throw Exception(
        "Header 'Kode Barang' tidak ditemukan.",
      );
    }

    debugPrint(
      "==========================================",
    );

    debugPrint(
      "HEADER DITEMUKAN",
    );

    debugPrint(
      "Index Header : $headerIndex",
    );

    debugPrint(
      "Row Header   : ${headerIndex + 1}",
    );

    debugPrint(
      "Header       : ${values[headerIndex]}",
    );

    debugPrint(
      "==========================================",
    );

    if (kodeBarangColumn == -1) {
      throw Exception(
        "Header 'Kode Barang' tidak ditemukan.",
      );
    }

    if (namaBarangColumn == -1) {
      throw Exception(
        "Header 'Nama Barang' tidak ditemukan.",
      );
    }

    if (stokAwalColumn == -1) {
      throw Exception(
        "Header 'Stok Awal' tidak ditemukan.",
      );
    }

    if (totalKeluarColumn == -1) {
      throw Exception(
        "Header 'Total Keluar' tidak ditemukan.",
      );
    }

    if (stokAkhirColumn == -1) {
      throw Exception(
        "Header 'Stok Akhir' tidak ditemukan.",
      );
    }

    // ============================================================
    // 8. DEBUG POSISI COLUMN
    // ============================================================

    debugPrint(
      "==========================================",
    );

    debugPrint(
      "POSISI COLUMN",
    );

    debugPrint(
      "Kode Barang     : $kodeBarangColumn",
    );

    debugPrint(
      "Nama Barang     : $namaBarangColumn",
    );

    debugPrint(
      "Stok Awal       : $stokAwalColumn",
    );

    debugPrint(
      "Total Keluar    : $totalKeluarColumn",
    );

    debugPrint(
      "Stok Akhir      : $stokAkhirColumn",
    );

    debugPrint(
      "==========================================",
    );

    // ============================================================
    // 9. CARI KODE BARANG
    //
    // PENTING:
    // rowIndex adalah index dari List.
    //
    // rowNumber adalah nomor BARIS ASLI Google Sheets.
    //
    // Jadi:
    //
    // rowNumber = rowIndex + 1
    //
    // Karena List index dimulai dari 0,
    // sedangkan Google Sheets dimulai dari 1.
    // ============================================================

    for (
    int rowIndex = headerIndex + 1;
    rowIndex < values.length;
    rowIndex++
    ) {
      final row = values[rowIndex];

      // ==========================================================
      // PASTIKAN ROW MEMILIKI COLUMN YANG DIBUTUHKAN
      // ==========================================================

      final requiredColumn =
      [
        kodeBarangColumn,
        namaBarangColumn,
        stokAwalColumn,
        totalKeluarColumn,
        stokAkhirColumn,
      ].reduce(
            (a, b) => a > b ? a : b,
      );

      if (row.length <= requiredColumn) {
        debugPrint(
          "ROW ${rowIndex + 1} dilewati karena "
              "jumlah column tidak mencukupi.",
        );

        continue;
      }

      // ==========================================================
      // AMBIL DATA DARI ROW YANG SAMA
      // ==========================================================

      final kodeBarangSheet =
      row[kodeBarangColumn].trim();

      final namaBarangSheet =
      row[namaBarangColumn].trim();

      final stokAwalText =
      row[stokAwalColumn].trim();

      final totalKeluarLamaText =
      row[totalKeluarColumn].trim();

      final stokAkhirLamaText =
      row[stokAkhirColumn].trim();

      // ==========================================================
      // NOMOR ROW GOOGLE SHEETS YANG SEBENARNYA
      // ==========================================================

      final rowNumber =
          rowIndex + 1;

      debugPrint(
        "CHECK ROW $rowNumber "
            "| Kode: $kodeBarangSheet "
            "| Nama: $namaBarangSheet "
            "| Stok Awal: $stokAwalText "
            "| Total Keluar: $totalKeluarLamaText "
            "| Stok Akhir: $stokAkhirLamaText",
      );

      // ==========================================================
      // CARI BERDASARKAN KODE BARANG
      //
      // KODE BARANG DIJADIKAN IDENTITAS UTAMA.
      // ==========================================================

      if (kodeBarangSheet != kodeBarang) {
        continue;
      }

      // ==========================================================
      // KODE BARANG DITEMUKAN
      // ==========================================================

      debugPrint(
        "==========================================",
      );

      debugPrint(
        "KODE BARANG DITEMUKAN",
      );

      debugPrint(
        "Row Google Sheets : $rowNumber",
      );

      debugPrint(
        "Kode Barang       : $kodeBarangSheet",
      );

      debugPrint(
        "Nama Barang       : $namaBarangSheet",
      );

      debugPrint(
        "==========================================",
      );

      // ==========================================================
      // VALIDASI NAMA BARANG
      // ==========================================================

      if (namaBarangSheet != namaBarang) {
        debugPrint(
          "PERINGATAN:",
        );

        debugPrint(
          "Nama barang input : $namaBarang",
        );

        debugPrint(
          "Nama barang sheet : $namaBarangSheet",
        );

        debugPrint(
          "Update tetap dilanjutkan berdasarkan Kode Barang.",
        );
      }

      // ==========================================================
      // PARSE STOK
      // ==========================================================

      final stokAwal =
          int.tryParse(stokAwalText) ?? 0;

      final totalKeluarLama =
          int.tryParse(totalKeluarLamaText) ?? 0;

      final stokAkhirLama =
          int.tryParse(stokAkhirLamaText) ?? stokAwal;

      debugPrint(
        "Stok Awal Lama    : $stokAwal",
      );

      debugPrint(
        "Total Keluar Lama : $totalKeluarLama",
      );

      debugPrint(
        "Stok Akhir Lama   : $stokAkhirLama",
      );

      // ==========================================================
      // HITUNG TOTAL KELUAR BARU
      // ==========================================================

      final totalKeluarBaru =
          totalKeluarLama + jumlahKeluar;

      // ==========================================================
      // HITUNG STOK AKHIR BARU
      // ==========================================================

      final stokAkhirBaru =
          stokAwal - totalKeluarBaru;

      debugPrint(
        "Jumlah Keluar     : $jumlahKeluar",
      );

      debugPrint(
        "Total Keluar Baru : $totalKeluarBaru",
      );

      debugPrint(
        "Stok Akhir Baru   : $stokAkhirBaru",
      );

      // ==========================================================
      // VALIDASI STOK
      // ==========================================================

      if (stokAkhirBaru < 0) {
        throw Exception(
          "Stok tidak mencukupi.\n\n"
              "Kode Barang   : $kodeBarang\n"
              "Nama Barang   : $namaBarangSheet\n"
              "Stok Awal     : $stokAwal\n"
              "Total Keluar  : $totalKeluarLama\n"
              "Jumlah Keluar : $jumlahKeluar\n"
              "Stok Akhir    : $stokAkhirBaru",
        );
      }

      // ==========================================================
      // KONVERSI INDEX COLUMN KE COLUMN GOOGLE SHEETS
      //
      // Dart List:
      // 0 = column A
      // 1 = column B
      // 2 = column C
      //
      // Google Sheets:
      // A = 1
      // B = 2
      // C = 3
      //
      // Jadi +1.
      // ==========================================================

      final totalKeluarGoogleColumn =
          totalKeluarColumn + 1;

      final stokAkhirGoogleColumn =
          stokAkhirColumn + 1;

      debugPrint(
        "==========================================",
      );

      debugPrint(
        "POSISI UPDATE",
      );

      debugPrint(
        "Google Sheets Row : $rowNumber",
      );

      debugPrint(
        "Total Keluar Col  : $totalKeluarGoogleColumn",
      );

      debugPrint(
        "Stok Akhir Col    : $stokAkhirGoogleColumn",
      );

      debugPrint(
        "==========================================",
      );

      // ==========================================================
      // UPDATE TOTAL KELUAR
      //
      // ROW = rowNumber
      //
      // Jadi update dilakukan pada BARIS YANG SAMA dengan
      // Kode Barang yang ditemukan.
      // ==========================================================

      await worksheet.values.insertValue(
        totalKeluarBaru.toString(),
        column: totalKeluarGoogleColumn,
        row: rowNumber,
      );

      debugPrint(
        "Total Keluar berhasil di-update "
            "pada row $rowNumber.",
      );

      // ==========================================================
      // UPDATE STOK AKHIR
      //
      // MASIH MENGGUNAKAN rowNumber YANG SAMA.
      // ==========================================================

      await worksheet.values.insertValue(
        stokAkhirBaru.toString(),
        column: stokAkhirGoogleColumn,
        row: rowNumber,
      );

      debugPrint(
        "Stok Akhir berhasil di-update "
            "pada row $rowNumber.",
      );

      // ==========================================================
      // HASIL AKHIR
      // ==========================================================

      debugPrint(
        "==========================================",
      );

      debugPrint(
        "UPDATE STOCK BERHASIL",
      );

      debugPrint(
        "==========================================",
      );

      debugPrint(
        "Sheet              : $namaLemari",
      );

      debugPrint(
        "Row                : $rowNumber",
      );

      debugPrint(
        "Kode Barang        : $kodeBarangSheet",
      );

      debugPrint(
        "Nama Barang        : $namaBarangSheet",
      );

      debugPrint(
        "Stok Awal          : $stokAwal",
      );

      debugPrint(
        "Total Keluar Lama  : $totalKeluarLama",
      );

      debugPrint(
        "Jumlah Keluar      : $jumlahKeluar",
      );

      debugPrint(
        "Total Keluar Baru  : $totalKeluarBaru",
      );

      debugPrint(
        "Stok Akhir Lama    : $stokAkhirLama",
      );

      debugPrint(
        "Stok Akhir Baru    : $stokAkhirBaru",
      );

      debugPrint(
        "Column Total Keluar: "
            "$totalKeluarGoogleColumn",
      );

      debugPrint(
        "Column Stok Akhir  : "
            "$stokAkhirGoogleColumn",
      );

      debugPrint(
        "==========================================",
      );

      return;
    }

    // ============================================================
    // 10. KODE BARANG TIDAK DITEMUKAN
    // ============================================================

    throw Exception(
      "Barang tidak ditemukan pada $namaLemari.\n\n"
          "Kode Barang : $kodeBarang\n"
          "Nama Barang : $namaBarang",
    );
  }
}