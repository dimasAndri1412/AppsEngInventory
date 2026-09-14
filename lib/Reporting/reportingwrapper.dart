import 'package:intl/intl.dart';
import '../Services/gsheetscontrollers.dart';

class ReportingSummary {
  final String periode;
  final int jumlahTransaksi;
  final double jumlahBarang;
  final double totalStock;
  final int jenisBarang;

  ReportingSummary({
    required this.periode,
    required this.jumlahTransaksi,
    required this.jumlahBarang,
    required this.totalStock,
    required this.jenisBarang,
  });
}

class ReportingResult {
  final List<ReportingSummary> summaries;
  final int totalTransaksi;
  final double totalBarang;
  final double totalStock;
  final int totalJenisBarang;

  ReportingResult({
    required this.summaries,
    required this.totalTransaksi,
    required this.totalBarang,
    required this.totalStock,
    required this.totalJenisBarang,
  });
}

class ReportingWrapper {

  static DateTime? parseTanggal(String value) {
    final tanggal = value.trim();

    if (tanggal.isEmpty) {
      return null;
    }

    try {
      return DateFormat('yyyy-MM-dd').parseStrict(tanggal);

    } catch (e) {
      return null;
    }
  }


  static Future<ReportingResult> getReporting({
    required String jenisLaporan, required String periode, required DateTime tanggal,}) async {

    List<Map<String, String>> data;

    if (jenisLaporan == 'Barang Masuk') {
      data = await getListDataBarangMasuk();

    } else if (jenisLaporan == 'Barang Keluar') {
      data = await getListDataBarangKeluar();

    } else {

      throw Exception(
        'Jenis laporan tidak dikenal.',
      );
    }



    final List<Map<String, String>> filteredData = [];
    for (final item in data) {

      final tanggalString = item["Tanggal"]?.trim() ?? "";
      if (tanggalString.isEmpty) {
        continue;
      }

      final tanggalData = parseTanggal(tanggalString);

      if (tanggalData == null) {
        continue;
      }

      bool masukPeriode = false;


      if (periode == 'Bulan Ini') {
        masukPeriode = tanggalData.year == tanggal.year &&
                tanggalData.month == tanggal.month;
      }



      else if (periode == 'Bulan Lalu') {
        final bulanLalu = DateTime(
          tanggal.year,
          tanggal.month - 1,
        );

        masukPeriode = tanggalData.year == bulanLalu.year &&
                tanggalData.month == bulanLalu.month;
      }


      else if (periode == 'Tahun Ini') {
        masukPeriode = tanggalData.year == tanggal.year;
      }


      else if (periode == 'Custom') {
        masukPeriode = tanggalData.year == tanggal.year &&
            tanggalData.month == tanggal.month && tanggalData.day == tanggal.day;
      }

      if (masukPeriode) {
        filteredData.add(item);
      }
    }


    final Map<String, List<Map<String, String>>> groupedData = {};
    for (final item in filteredData) {
      final tanggalString = item["Tanggal"]?.trim() ?? "";
      final tanggalData = parseTanggal(tanggalString);

      if (tanggalData == null) {
        continue;
      }

      String groupKey;

      if (periode == 'Tahun Ini') {
        groupKey = DateFormat('yyyy-MM').format(tanggalData,);
      } else {
        groupKey = DateFormat('yyyy-MM-dd').format(tanggalData);
      }

      groupedData.putIfAbsent(groupKey, () => []);
      groupedData[groupKey]!.add(item);
    }

    final List<ReportingSummary> summaries = [];

    for (final entry in groupedData.entries) {
      final items = entry.value;
      final int jumlahTransaksi = items.length;

      double jumlahBarang = 0;
      double totalStock = 0;

      final Set<String> kodeBarangUnik = {};
      for (final item in items) {
        final jumlahString = item["Jumlah"]?.trim() ?? "0";

        final jumlah = double.tryParse(jumlahString.replaceAll(',', '.'),
            ) ?? 0;

        jumlahBarang += jumlah;
        totalStock += jumlah;

        final kodeBarang = item["Kode Barang"]?.trim() ?? "";

        if (kodeBarang.isNotEmpty) {

          kodeBarangUnik.add(
            kodeBarang,
          );
        }
      }

      summaries.add(
        ReportingSummary(
          periode: entry.key,
          jumlahTransaksi: jumlahTransaksi,
          jumlahBarang: jumlahBarang,
          totalStock: totalStock,
          jenisBarang: kodeBarangUnik.length,
        ),
      );
    }


    summaries.sort(
          (a, b) => a.periode.compareTo(b.periode),
    );

    final int totalTransaksi = filteredData.length;

    double totalBarang = 0;
    double totalStock = 0;

    final Set<String> totalKodeBarang = {};
    for (final item in filteredData) {
      final jumlahString = item["Jumlah"]?.trim() ?? "0";

      final jumlah = double.tryParse(jumlahString.replaceAll(',', '.',)
      ) ?? 0;

      totalBarang += jumlah;
      totalStock += jumlah;

      final kodeBarang = item["Kode Barang"]?.trim() ?? "";

      if (kodeBarang.isNotEmpty) {

        totalKodeBarang.add(
          kodeBarang,
        );
      }
    }

    return ReportingResult(
      summaries: summaries,
      totalTransaksi: totalTransaksi,
      totalBarang: totalBarang,
      totalStock: totalStock,
      totalJenisBarang: totalKodeBarang.length,
    );
  }
}