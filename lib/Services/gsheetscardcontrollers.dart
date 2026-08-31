import '../Controller/key.dart';
import 'gsheetsservices.dart';

Future<List<Map<String, dynamic>>> getDataDashboardStok() async {
  try {
    if (GSheetsServicesEmployees.sheetsDashboard == null) {
      await GSheetsServicesEmployees.init();
    }

    final worksheet = GSheetsServicesEmployees.sheetsDashboard;

    if (worksheet == null) {
      print('Worksheet Dashboard tidak ditemukan');
      return [];
    }

    final rows = await worksheet.values.allRows();

    if (rows.isEmpty) {
      print('Data Dashboard kosong');
      return [];
    }

    final List<Map<String, dynamic>> result = [];

    String currentLemari = '';

    for (final row in rows) {
      if (row.isEmpty) {
        continue;
      }

      final kolomA = row.length > 0 ? row[0].toString().trim() : '';
      final kolomB = row.length > 1 ? row[1].toString().trim() : '';
      final kolomC = row.length > 2 ? row[2].toString().trim() : '';
      final kolomD = row.length > 3 ? row[3].toString().trim() : '';

      if (kolomA.isEmpty) {
        continue;
      }

      final namaKolom = kolomA.toLowerCase();


      if (namaKolom.contains('summary lemari')) {
        currentLemari = kolomA;
        continue;
      }


      if (namaKolom == 'jumlah jenis barang' ||
          namaKolom == 'total stok awal' ||
          namaKolom == 'total barang masuk' ||
          namaKolom == 'total barang keluar' ||
          namaKolom == 'total stok saat ini' ||
          namaKolom == 'jumlah barang kurang') {

        result.add({
          'lemari': currentLemari,
          'nama': kolomA,
          'jumlah': kolomB,
          'status': kolomC,
          'jumlahStatus': kolomD,
        });
      }
    }

    for (final data in result) {
      print(data);
    }

    return result;
  } catch (e) {
    return [];
  }
}

Future<void> loadDashboardStokToController() async {
  try {
    final data = await getDataDashboardStok();

    if (data.isEmpty) {
      return;
    }

    for (final item in data) {

      final lemari = item['lemari']?.toString().toLowerCase() ?? '';
      final nama = item['nama']?.toString().toLowerCase() ?? '';
      final jumlah = item['jumlah']?.toString() ?? '';

      if (lemari.contains('lemari 1')) {
        if (nama == 'jumlah jenis barang') {
          jumlahJenisBarangLemari1Controller.text = jumlah;
        }
        else if (nama == 'total stok awal') {
          totalStokAwalLemari1Controller.text = jumlah;
        }
        else if (nama == 'total barang masuk') {
          totalBarangMasukLemari1Controller.text = jumlah;
        }
        else if (nama == 'total barang keluar') {
          totalBarangKeluarLemari1Controller.text = jumlah;
        }
        else if (nama == 'total stok saat ini') {
          totalStokSaatIniLemari1Controller.text = jumlah;
        }
        else if (nama == 'jumlah barang kurang') {
          jumlahBarangKurangLemari1Controller.text = jumlah;
        }
      }

      else if (lemari.contains('lemari 2')) {

        if (nama == 'jumlah jenis barang') {
          jumlahJenisBarangLemari2Controller.text = jumlah;
        }
        else if (nama == 'total stok awal') {
          totalStokAwalLemari2Controller.text = jumlah;
        }
        else if (nama == 'total barang masuk') {
          totalBarangMasukLemari2Controller.text = jumlah;
        }
        else if (nama == 'total barang keluar') {
          totalBarangKeluarLemari2Controller.text = jumlah;
        }
        else if (nama == 'total stok saat ini') {
          totalStokSaatIniLemari2Controller.text = jumlah;
        }
        else if (nama == 'jumlah barang kurang') {
          jumlahBarangKurangLemari2Controller.text = jumlah;
        }
      }


      else if (lemari.contains('lemari 3')) {
        if (nama == 'jumlah jenis barang') {
          jumlahJenisBarangLemari3Controller.text = jumlah;
        }
        else if (nama == 'total stok awal') {
          totalStokAwalLemari3Controller.text = jumlah;
        }
        else if (nama == 'total barang masuk') {
          totalBarangMasukLemari3Controller.text = jumlah;
        }
        else if (nama == 'total barang keluar') {
          totalBarangKeluarLemari3Controller.text = jumlah;
        }
        else if (nama == 'total stok saat ini') {
          totalStokSaatIniLemari3Controller.text = jumlah;
        }
        else if (nama == 'jumlah barang kurang') {
          jumlahBarangKurangLemari3Controller.text = jumlah;
        }
      }
    }


  } catch (e) {
    print('Error loadDashboardStokToController: $e');
  }
}