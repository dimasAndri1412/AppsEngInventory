import 'package:flutter/foundation.dart';
import 'gsheetsservices.dart';

class ReportingService {
  static Future<List<Map<String, String>>> getListDataBarangMasuk() async {
    final worksheet = GSheetsServicesEmployees.sheetsBarangMasuk;

    if (worksheet == null) {
      throw Exception(
        'sheetsBarangMasuk belum diinisialisasi.',
      );
    }

    try {
      final rows = await worksheet.values.allRows();

      if (rows.length < 3) {
        return [];
      }

      final header = rows[2];

      final tanggalBarangIndex = header.indexWhere(
            (h) => h.toString().trim() == 'Tanggal',
      );

      final namaBarangIndex = header.indexWhere(
            (h) => h.toString().trim() == 'Nama Barang',
      );

      final kodeBarangIndex = header.indexWhere(
            (h) => h.toString().trim() == 'Kode Barang',
      );

      final jumlahBarangIndex = header.indexWhere(
            (h) => h.toString().trim() == 'Jumlah',
      );

      final satuanIndex = header.indexWhere(
            (h) => h.toString().trim() == 'Satuan',
      );

      final posisiLemariIndex = header.indexWhere(
            (h) => h.toString().trim() == 'Posisi Lemari',
      );

      if (tanggalBarangIndex == -1 ||
          namaBarangIndex == -1 ||
          kodeBarangIndex == -1 ||
          jumlahBarangIndex == -1 ||
          satuanIndex == -1 ||
          posisiLemariIndex == -1) {
        throw Exception(
          "Kolom data barang masuk tidak ditemukan.",
        );
      }

      final result = rows.skip(3).map((row) {
        return {
          "Tanggal": row.length > tanggalBarangIndex
              ? row[tanggalBarangIndex].trim()
              : "",

          "Nama Barang": row.length > namaBarangIndex
              ? row[namaBarangIndex].trim()
              : "",

          "Kode Barang": row.length > kodeBarangIndex
              ? row[kodeBarangIndex].trim()
              : "",

          "Jumlah": row.length > jumlahBarangIndex
              ? row[jumlahBarangIndex].trim()
              : "",

          "Satuan": row.length > satuanIndex
              ? row[satuanIndex].trim()
              : "",

          "Posisi Lemari": row.length > posisiLemariIndex
              ? row[posisiLemariIndex].trim()
              : "",
        };
      }).where(
            (e) => e["Nama Barang"]!.isNotEmpty,
      ).toList();

      return result;
    } catch (e) {
      debugPrint(
        "Error getListDataBarangMasuk: $e",
      );

      rethrow;
    }
  }
}