import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/MenuPages/navigationmenu.dart';
import 'package:appsenginventory/Services/gsheetsservices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Get data process
Future<List<Map<String, String>>?> getDataEmployees() async {
  if (GSheetsServicesEmployees.sheet == null) {
    throw Exception(
      'Google Sheets belum diinisialisasi. Jalankan GSheetsServicesEmployees.init() terlebih dahulu.',
    );
  }
  return await GSheetsServicesEmployees.sheet!.values.map.allRows();
}

// dropdown value posisi
Future<List<Map<String, String>>> getDataPosisi() async {
  final worksheet = GSheetsServicesEmployees.sheetPosisi;

  if (worksheet == null) {
    throw Exception(
      'sheetPosisi belum diinisialisasi.',
    );
  }

  try {
    final rows = await worksheet.values.map.allRows();

    debugPrint('======================================');
    debugPrint('DATA POSISI DARI GOOGLE SHEETS');
    debugPrint('$rows');
    debugPrint('Jumlah data: ${rows!.length}');
    debugPrint('======================================');

    if (rows.isEmpty) {
      return [];
    }

    final result = rows.map((row) {
      final posisi = row['PosisiNames']?.toString().trim() ?? '';

      return {'Posisi': posisi,
      };
    })
        .where((data) => data['Posisi']!.isNotEmpty)
        .toList();

    return result;
  } catch (e) {
    debugPrint('Error mengambil data posisi: $e');
    rethrow;
  }
}

//dropdownlemari
Future<List<Map<String, String>>> getDataLemari() async {
  final worksheet = GSheetsServicesEmployees.sheetLemari;

  if (worksheet == null) {
    throw Exception(
      'sheetLemari belum diinisialisasi.',
    );
  }

  try {
    final rows = await worksheet.values.map.allRows();

    debugPrint('======================================');
    debugPrint('DATA POSISI DARI GOOGLE SHEETS');
    debugPrint('$rows');
    debugPrint('Jumlah data: ${rows!.length}');
    debugPrint('======================================');

    if (rows.isEmpty) {
      return [];
    }

    final result = rows.map((row) {
      final posisi = row['PosisiLemari']?.toString().trim() ?? '';

      return {'PosisiLemari': posisi,
      };
    })
        .where((data) => data['PosisiLemari']!.isNotEmpty)
        .toList();

    return result;
  } catch (e) {
    debugPrint('Error mengambil data PosisiLemari: $e');
    rethrow;
  }
}


//getdata barang 1
Future<List<Map<String, String>>> getDataBarangLemari1() async {
  final worksheet = GSheetsServicesEmployees.sheetsLemari1;

  if (worksheet == null) {
    throw Exception('sheetLemari belum diinisialisasi.');
  }

  try {
    final rows = await worksheet.values.allRows();

    if (rows.length < 3) return [];
    final header = rows[2];
    final namaBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Nama Barang');
    final kodeBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Kode Barang');
    final satuanIndex = header.indexWhere((h) => h.toString().trim() == 'Satuan');
    final stokawalIndex = header.indexWhere((h) => h.toString().trim() == 'Stok Awal');
    final stockAkhirIndex = header.indexWhere((h) => h.toString().trim() == 'Stok Akhir');


    if (namaBarangIndex == -1 || kodeBarangIndex == -1 || satuanIndex == -1
        || stokawalIndex == -1 || stockAkhirIndex == -1 ) {
      throw Exception("Kolom 'Nama Barang' atau 'Kode Barang' tidak ditemukan.");
    }

    final result = rows.skip(3).map((row) {
      return {
        "Nama Barang": row.length > namaBarangIndex
            ? row[namaBarangIndex].trim()
            : "",
        "Kode Barang": row.length > kodeBarangIndex
            ? row[kodeBarangIndex].trim()
            : "",
        "Satuan": row.length > satuanIndex
            ? row[satuanIndex].trim()
            : "",
        "Stok Awal": row.length > stokawalIndex
            ? row[stokawalIndex].trim()
            : "",
        "Stok Akhir": row.length > stockAkhirIndex
            ? row[stockAkhirIndex].trim()
            : "",
      };
    }).where((e) => e["Nama Barang"]!.isNotEmpty).toList();

    return result;
  } catch (e) {
    debugPrint("Error: $e");
    rethrow;
  }
}
//dropdown namaBarang lemari2
Future<List<Map<String, String>>> getDataBarangLemari2() async {
  final worksheet = GSheetsServicesEmployees.sheetsLemari2;

  if (worksheet == null) {
    throw Exception('sheetLemari belum diinisialisasi.');
  }

  try {
    final rows = await worksheet.values.allRows();

    if (rows.length < 3) return [];
    final header = rows[2];
    final namaBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Nama Barang');
    final kodeBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Kode Barang');
    final satuanIndex = header.indexWhere((h) => h.toString().trim() == 'Satuan');
    final stokawalIndex = header.indexWhere((h) => h.toString().trim() == 'Stok Awal');
    final stockAkhirIndex = header.indexWhere((h) => h.toString().trim() == 'Stok Akhir');


    if (namaBarangIndex == -1 || kodeBarangIndex == -1 || satuanIndex == -1
        || stokawalIndex == -1 || stockAkhirIndex == -1 ) {
      throw Exception("Kolom 'Nama Barang' atau 'Kode Barang' tidak ditemukan.");
    }

    final result = rows.skip(3).map((row) {
      return {
        "Nama Barang": row.length > namaBarangIndex
            ? row[namaBarangIndex].trim()
            : "",
        "Kode Barang": row.length > kodeBarangIndex
            ? row[kodeBarangIndex].trim()
            : "",
        "Satuan": row.length > satuanIndex
            ? row[satuanIndex].trim()
            : "",
        "Stok Awal": row.length > stokawalIndex
            ? row[stokawalIndex].trim()
            : "",
        "Stok Akhir": row.length > stockAkhirIndex
            ? row[stockAkhirIndex].trim()
            : "",
      };
    }).where((e) => e["Nama Barang"]!.isNotEmpty).toList();

    return result;
  } catch (e) {
    debugPrint("Error: $e");
    rethrow;
  }
}

//dropdown namaBarang lemari3
Future<List<Map<String, String>>> getDataBarangLemari3() async {
  final worksheet = GSheetsServicesEmployees.sheetsLemari3;

  if (worksheet == null) {
    throw Exception('sheetLemari belum diinisialisasi.');
  }

  try {
    final rows = await worksheet.values.allRows();

    if (rows.length < 3) return [];
    final header = rows[2];
    final namaBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Nama Barang');
    final kodeBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Kode Barang');
    final satuanIndex = header.indexWhere((h) => h.toString().trim() == 'Satuan');
    final stokawalIndex = header.indexWhere((h) => h.toString().trim() == 'Stok Awal');
    final stockAkhirIndex = header.indexWhere((h) => h.toString().trim() == 'Stok Akhir');


    if (namaBarangIndex == -1 || kodeBarangIndex == -1 || satuanIndex == -1
        || stokawalIndex == -1 || stockAkhirIndex == -1 ) {
      throw Exception("Kolom 'Nama Barang' atau 'Kode Barang' tidak ditemukan.");
    }

    final result = rows.skip(3).map((row) {
      return {
        "Nama Barang": row.length > namaBarangIndex
            ? row[namaBarangIndex].trim()
            : "",
        "Kode Barang": row.length > kodeBarangIndex
            ? row[kodeBarangIndex].trim()
            : "",
        "Satuan": row.length > satuanIndex
            ? row[satuanIndex].trim()
            : "",
        "Stok Awal": row.length > stokawalIndex
            ? row[stokawalIndex].trim()
            : "",
        "Stok Akhir": row.length > stockAkhirIndex
            ? row[stockAkhirIndex].trim()
            : "",
      };
    }).where((e) => e["Nama Barang"]!.isNotEmpty).toList();

    return result;
  } catch (e) {
    debugPrint("Error: $e");
    rethrow;
  }
}

// Validation and Where
Future<List<Map<String, dynamic>>> validationLogins() async {
  if (GSheetsServicesEmployees.sheet == null) {
    await GSheetsServicesEmployees.init();
  }

  final rows = await GSheetsServicesEmployees.sheet!.values.map.allRows();

  if (rows!.isEmpty) {
    return [];
  }

  final usrnm = loginUserNameController.text.trim();
  final usrpass = loginPasswordController.text.trim();

  return rows.where((row) {

    final valueUsrNames = row['UserName']?.toString() ?? '';
    final valuesPass = row['Pass']?.toString() ?? '';

    if (valueUsrNames == usrnm || valuesPass == usrpass) {
      Get.offAll(() => const NavigationMenuPages());
    }

    return valueUsrNames.contains(usrnm) &&
    valuesPass.contains(usrpass);

  }).toList();
}

// list lemari 1
Future<List<Map<String, String>>> getListDataBarangLemari1() async {
  final worksheet = GSheetsServicesEmployees.sheetsLemari1;

  if (worksheet == null) {
    throw Exception('sheetLemari belum diinisialisasi.');
  }

  try {
    final rows = await worksheet.values.allRows();

    if (rows.length < 3) return [];
    final header = rows[2];
    final namaBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Nama Barang');
    final kodeBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Kode Barang');
    final satuanIndex = header.indexWhere((h) => h.toString().trim() == 'Satuan');
    final stockAkhirIndex = header.indexWhere((h) => h.toString().trim() == 'Stok Akhir');
    final statusIndex = header.indexWhere((h) => h.toString().trim() == 'Status');


    if (namaBarangIndex == -1 || kodeBarangIndex == -1 || satuanIndex == -1
        || stockAkhirIndex == -1 || statusIndex == -1 ) {
      throw Exception("Kolom 'Nama Barang' atau 'Kode Barang' tidak ditemukan.");
    }

    final result = rows.skip(3).map((row) {
      return {
        "Nama Barang": row.length > namaBarangIndex
            ? row[namaBarangIndex].trim()
            : "",
        "Kode Barang": row.length > kodeBarangIndex
            ? row[kodeBarangIndex].trim()
            : "",
        "Satuan": row.length > satuanIndex
            ? row[satuanIndex].trim()
            : "",
        "Stok Akhir": row.length > stockAkhirIndex
            ? row[stockAkhirIndex].trim()
            : "",
        "Status": row.length > statusIndex
            ? row[statusIndex].trim()
            : "",
      };
    }).where((e) => e["Nama Barang"]!.isNotEmpty).toList();

    return result;
  } catch (e) {
    debugPrint("Error: $e");
    rethrow;
  }
}

// list lemari 2
Future<List<Map<String, String>>> getListDataBarangLemari2() async {
  final worksheet = GSheetsServicesEmployees.sheetsLemari2;

  if (worksheet == null) {
    throw Exception('sheetLemari belum diinisialisasi.');
  }

  try {
    final rows = await worksheet.values.allRows();

    if (rows.length < 3) return [];
    final header = rows[2];
    final namaBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Nama Barang');
    final kodeBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Kode Barang');
    final satuanIndex = header.indexWhere((h) => h.toString().trim() == 'Satuan');
    final stockAkhirIndex = header.indexWhere((h) => h.toString().trim() == 'Stok Akhir');
    final statusIndex = header.indexWhere((h) => h.toString().trim() == 'Status');


    if (namaBarangIndex == -1 || kodeBarangIndex == -1 || satuanIndex == -1
        || stockAkhirIndex == -1 || statusIndex == -1 ) {
      throw Exception("Kolom 'Nama Barang' atau 'Kode Barang' tidak ditemukan.");
    }

    final result = rows.skip(3).map((row) {
      return {
        "Nama Barang": row.length > namaBarangIndex
            ? row[namaBarangIndex].trim()
            : "",
        "Kode Barang": row.length > kodeBarangIndex
            ? row[kodeBarangIndex].trim()
            : "",
        "Satuan": row.length > satuanIndex
            ? row[satuanIndex].trim()
            : "",
        "Stok Akhir": row.length > stockAkhirIndex
            ? row[stockAkhirIndex].trim()
            : "",
        "Status": row.length > statusIndex
            ? row[statusIndex].trim()
            : "",
      };
    }).where((e) => e["Nama Barang"]!.isNotEmpty).toList();

    return result;
  } catch (e) {
    debugPrint("Error: $e");
    rethrow;
  }
}

Future<bool> validationEmail() async {
  try {
    if (GSheetsServicesEmployees.sheet == null) {
      await GSheetsServicesEmployees.init();
    }

    final rows =
    await GSheetsServicesEmployees.sheet!.values.map.allRows();

    if (rows == null || rows.isEmpty) {
      return true;
    }

    for (var verifyEmails in revampResgistControllerss) {
      final emailInput =
          verifyEmails["emailcontroller"]?.text.trim().toLowerCase() ?? '';

      if (emailInput.isEmpty) {
        return false;
      }

      final emailSudahAda = rows.any((row) {
        final emailSheet =
            row['Email']?.toString().trim().toLowerCase() ?? '';

        return emailSheet == emailInput;
      });

      if (emailSudahAda) {
        return false;
      }
    }

    return true;
  } catch (e) {
    debugPrint('Error validation email: $e');
    return false;
  }
}

// list lemari 3
Future<List<Map<String, String>>> getListDataBarangLemari3() async {
  final worksheet = GSheetsServicesEmployees.sheetsLemari3;

  if (worksheet == null) {
    throw Exception('sheetLemari belum diinisialisasi.');
  }

  try {
    final rows = await worksheet.values.allRows();

    if (rows.length < 3) return [];
    final header = rows[2];
    final namaBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Nama Barang');
    final kodeBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Kode Barang');
    final satuanIndex = header.indexWhere((h) => h.toString().trim() == 'Satuan');
    final stockAkhirIndex = header.indexWhere((h) => h.toString().trim() == 'Stok Akhir');
    final statusIndex = header.indexWhere((h) => h.toString().trim() == 'Status');


    if (namaBarangIndex == -1 || kodeBarangIndex == -1 || satuanIndex == -1
        || stockAkhirIndex == -1 || statusIndex == -1 ) {
      throw Exception("Kolom 'Nama Barang' atau 'Kode Barang' tidak ditemukan.");
    }

    final result = rows.skip(3).map((row) {
      return {
        "Nama Barang": row.length > namaBarangIndex
            ? row[namaBarangIndex].trim()
            : "",
        "Kode Barang": row.length > kodeBarangIndex
            ? row[kodeBarangIndex].trim()
            : "",
        "Satuan": row.length > satuanIndex
            ? row[satuanIndex].trim()
            : "",
        "Stok Akhir": row.length > stockAkhirIndex
            ? row[stockAkhirIndex].trim()
            : "",
        "Status": row.length > statusIndex
            ? row[statusIndex].trim()
            : "",
      };
    }).where((e) => e["Nama Barang"]!.isNotEmpty).toList();

    return result;
  } catch (e) {
    debugPrint("Error: $e");
    rethrow;
  }
}

Future<List<Map<String, dynamic>>> headerPagesController() async {
  if (GSheetsServicesEmployees.sheet == null) {
    await GSheetsServicesEmployees.init();
  }

  final rows =
  await GSheetsServicesEmployees.sheet!.values.map.allRows();

  if (rows!.isEmpty) {
    return [];
  }

  final usrnm = loginUserNameController.text.trim();
  final usrpass = loginPasswordController.text.trim();

  final result = rows!.where((row) {

    final valueUsrNames =
        row['UserName']?.toString() ?? '';

    final valuesPass =
        row['Pass']?.toString() ?? '';

    return valueUsrNames.contains(usrnm) &&
        valuesPass.contains(usrpass);

  }).toList();

  if (result.isNotEmpty) {

    final user = result.first;
    HomePagesUserNames.text = user['FullName']?.toString() ?? '';
    HomePagesPositions.text = user['Posisi']?.toString() ?? '';
  }

  return result;
}





