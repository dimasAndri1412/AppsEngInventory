import 'package:flutter/foundation.dart';

import 'gsheetsservices.dart';

class GsheetsInsertBarangMasuk {
  String? revampKodeBarangMasuk;
  String? revampTanggalBarangMasuk;
  String? revampNamaBarangMasuk;
  String? revampJumlahBarangMasuk;
  String? revampSatuanBarangMasuk;
  String? revampPICBarangMasuk;
  String? revampLemariBarangMasuk;
  String? revampKeteranganBarangMasuk;

  Future<void> revampInsertBarangMasuk() async {
    try {
      await GSheetsServicesEmployees.init();

      final worksheet =
          GSheetsServicesEmployees.sheetsBarangMasuk;

      if (worksheet == null) {
        throw Exception(
          'Worksheet Barang Masuk tidak ditemukan.',
        );
      }

      final kode = revampKodeBarangMasuk?.trim() ?? '';
      final tanggal = revampTanggalBarangMasuk?.trim() ?? '';
      final nama = revampNamaBarangMasuk?.trim() ?? '';
      final jumlah = revampJumlahBarangMasuk?.trim() ?? '';
      final satuan = revampSatuanBarangMasuk?.trim() ?? '';
      final pic = revampPICBarangMasuk?.trim() ?? '';
      final lemari = revampLemariBarangMasuk?.trim() ?? '';
      final keterangan =
          revampKeteranganBarangMasuk?.trim() ?? '';

      if (kode.isEmpty ||
          tanggal.isEmpty ||
          nama.isEmpty ||
          jumlah.isEmpty ||
          satuan.isEmpty ||
          pic.isEmpty ||
          lemari.isEmpty ||
          keterangan.isEmpty) {
        throw Exception(
          'Data barang masuk belum lengkap untuk kode $kode.',
        );
      }

      final row = <String>[
        kode,
        tanggal,
        nama,
        jumlah,
        satuan,
        pic,
        lemari,
        keterangan,
      ];

      await worksheet.values.appendRow(row);

      debugPrint('INSERT BARANG MASUK BERHASIL: $kode');
    } catch (e, stackTrace) {
      debugPrint('ERROR INSERT BARANG MASUK: $e');
      debugPrint('$stackTrace');
      rethrow;
    }
  }
}