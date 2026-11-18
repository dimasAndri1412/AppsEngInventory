import 'package:appsenginventory/ChangesPassword/changespasswordpages.dart';
import 'package:appsenginventory/Controller/clearfunc.dart';
import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/ForgotPassword/forgotpasswordpages.dart';
import 'package:appsenginventory/MenuPages/navigationmenu.dart';
import 'package:appsenginventory/OTPFeryvicationForgots/otpverficationsforgotpages.dart';
import 'package:appsenginventory/OTPVerfications/EmailOTP/emailotppages.dart';
import 'package:appsenginventory/OTPVerfications/otpverificationspages.dart';
import 'package:appsenginventory/Registrations/registrationsmenu.dart';
import 'package:appsenginventory/Services/gsheetsinsertlogincontrollers.dart';
import 'package:appsenginventory/Services/gsheetsinsertregistrationsfirstuser.dart';
import 'package:appsenginventory/Services/gsheetsotpcodecontrollers.dart';
import 'package:appsenginventory/Services/gsheetsservices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../HomePages/homepagesmenus.dart';

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

    if (rows!.isEmpty) {
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

    if (rows!.isEmpty) {
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
  try {
    if (GSheetsServicesEmployees.sheet == null) {
      await GSheetsServicesEmployees.init();
    }

    final rows =
    await GSheetsServicesEmployees.sheet!.values.map.allRows();

    if (rows == null || rows.isEmpty) {
      return [];
    }

    final usrnm = loginUserNameController.text.trim();
    final usrpass = loginPasswordController.text.trim();

    final resultsLogin = rows.where((row) {
      final valueUsrNames = row['UserName']?.toString().trim() ?? '';
      final valuesPass = row['Pass']?.toString().trim() ?? '';

      return valueUsrNames == usrnm && valuesPass == usrpass;
    }).toList();

    if (resultsLogin.isEmpty) {
      return [];
    }

    final user = resultsLogin.first;
    final valuesNamaLengkap = user['FullName']?.toString().trim() ?? '';
    final valuesStatus = user['StatusLogin']?.toString().trim() ?? '';
    final valueRoles = user['Roles']?.toString().trim() ?? '';

    otpFullNamesController.text = valuesNamaLengkap;

    if (valuesStatus == '0') {
      Get.to(() => const EmailOTPPages());

    } else if (valuesStatus == '1') {
      Get.to(() => const NavigationMenuPages());
      await GsheetsInsertloginControllers().revampInsertLoginLogControllers();
    }

    return resultsLogin;

  } catch (e) {
    return [];
  }
}

// list lemari 1
Future<List<Map<String, String>>> getListDataBarangLemari1() async {
  final worksheet = GSheetsServicesEmployees.sheetsLemari1;
  final pictBarang = GSheetsServicesEmployees.sheetsPicture;

  if (worksheet == null) {
    throw Exception('sheetLemari belum diinisialisasi.');
  }

  try {

    final Map<String, String> pictureMap = {};

    if (pictBarang != null) {
      final pictRows = await pictBarang.values.allRows();
      if (pictRows.length > 1) {

        for (var row in pictRows.skip(1)) {
          if (row.length >= 6) {
            final kode = row[3].trim();
            final kodes = row[2].trim();
            final url = row[5].trim();

            if (kode.isNotEmpty && kodes == 'Lemari1' && url.isNotEmpty) {
              pictureMap[kode] = _getGoogleDriveDirectUrl(url);
            }
          }
        }
      }
    }


    final rows = await worksheet.values.allRows();

    if (rows.length < 3) return [];
    final header = rows[2];
    final namaBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Nama Barang');
    final kodeBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Kode Barang');
    final satuanIndex = header.indexWhere((h) => h.toString().trim() == 'Satuan');
    final stockAkhirIndex = header.indexWhere((h) => h.toString().trim() == 'Stok Akhir');
    final statusIndex = header.indexWhere((h) => h.toString().trim() == 'Status');

    if (namaBarangIndex == -1 || kodeBarangIndex == -1 || satuanIndex == -1
        || stockAkhirIndex == -1 || statusIndex == -1) {
      throw Exception("Kolom 'Nama Barang' atau 'Kode Barang' tidak ditemukan.");
    }

    final result = rows.skip(3).map((row) {
      final kodeBarang = row.length > kodeBarangIndex ? row[kodeBarangIndex].trim() : "";

      final urlFoto = pictureMap[kodeBarang] ?? "";

      return {
        "Nama Barang": row.length > namaBarangIndex
            ? row[namaBarangIndex].trim()
            : "",
        "Kode Barang": kodeBarang,
        "Satuan": row.length > satuanIndex
            ? row[satuanIndex].trim()
            : "",
        "Stok Akhir": row.length > stockAkhirIndex
            ? row[stockAkhirIndex].trim()
            : "",
        "Status": row.length > statusIndex
            ? row[statusIndex].trim()
            : "",
        "Url Foto": urlFoto,
        "Lokasi": "Lemari1",
      };
    }).where((e) => e["Nama Barang"]!.isNotEmpty).toList();

    return result;
  } catch (e) {
    debugPrint("Error: $e");
    rethrow;
  }
}

String _getGoogleDriveDirectUrl(String originalUrl) {
  if (originalUrl.isEmpty) return '';

  final RegExp regExp = RegExp(r'/d/([a-zA-Z0-9_-]+)');
  final match = regExp.firstMatch(originalUrl);

  if (match != null && match.groupCount >= 1) {
    final fileId = match.group(1);
    return 'https://lh3.googleusercontent.com/d/$fileId';
  }

  final RegExp idRegExp = RegExp(r'id=([a-zA-Z0-9_-]+)');
  final idMatch = idRegExp.firstMatch(originalUrl);
  if (idMatch != null && idMatch.groupCount >= 1) {
    final fileId = idMatch.group(1);
    return 'https://lh3.googleusercontent.com/d/$fileId';
  }

  return originalUrl;
}

Future<List<Map<String, String>>> getListMinusDataBarang(
    String lemari,
    ) async {
  dynamic worksheet;

  switch (lemari.toLowerCase()) {
    case 'lemari1':
      worksheet = GSheetsServicesEmployees.sheetsLemari1;
      break;

    case 'lemari2':
      worksheet = GSheetsServicesEmployees.sheetsLemari2;
      break;

    case 'lemari3':
      worksheet = GSheetsServicesEmployees.sheetsLemari3;
      break;

    default:
      throw Exception('Lemari tidak dikenal: $lemari');
  }

  if (worksheet == null) {
    throw Exception('$lemari belum diinisialisasi.');
  }

  try {
    final rows = await worksheet.values.allRows();

    if (rows.length < 3) {
      return <Map<String, String>>[];
    }

    final header = rows[2];

    final namaBarangIndex = header.indexWhere(
          (h) => h.toString().trim() == 'Nama Barang',
    );

    final kodeBarangIndex = header.indexWhere(
          (h) => h.toString().trim() == 'Kode Barang',
    );

    final satuanIndex = header.indexWhere(
          (h) => h.toString().trim() == 'Satuan',
    );

    final stockAkhirIndex = header.indexWhere(
          (h) => h.toString().trim() == 'Stok Akhir',
    );

    final statusIndex = header.indexWhere(
          (h) => h.toString().trim() == 'Status',
    );

    if (namaBarangIndex == -1 ||
        kodeBarangIndex == -1 ||
        satuanIndex == -1 ||
        stockAkhirIndex == -1 ||
        statusIndex == -1) {
      throw Exception(
        "Kolom 'Nama Barang', 'Kode Barang', 'Satuan', "
            "'Stok Akhir' atau 'Status' tidak ditemukan.",
      );
    }

    final List<Map<String, String>> result = [];

    for (final row in rows.skip(3)) {
      final namaBarang = row.length > namaBarangIndex
          ? row[namaBarangIndex].toString().trim()
          : '';

      final kodeBarang = row.length > kodeBarangIndex
          ? row[kodeBarangIndex].toString().trim()
          : '';

      final satuan = row.length > satuanIndex
          ? row[satuanIndex].toString().trim()
          : '';

      final stokAkhir = row.length > stockAkhirIndex
          ? row[stockAkhirIndex].toString().trim()
          : '';

      final status = row.length > statusIndex
          ? row[statusIndex].toString().trim()
          : '';

      final statusUpper = status.toUpperCase();

      if (statusUpper == '⚠ KURANG' ||
          statusUpper == 'KURANG') {
        result.add({
          'Nama Barang': namaBarang,
          'Kode Barang': kodeBarang,
          'Satuan': satuan,
          'Stok Akhir': stokAkhir,
          'Status': status,
        });
      }
    }

    return result;
  } catch (e) {
    debugPrint(
      'Error getListMinusDataBarang: $e',
    );

    rethrow;
  }
}

// list lemari 2
Future<List<Map<String, String>>> getListDataBarangLemari2() async {
  final worksheet = GSheetsServicesEmployees.sheetsLemari2;
  final pictBarang = GSheetsServicesEmployees.sheetsPicture;

  if (worksheet == null) {
    throw Exception('sheetLemari belum diinisialisasi.');
  }

  try {
    // ---------------------------------------------------------------------
    // 1. Ambil & Petakan URL Foto dari sheet Picture (berdasarkan Kode Barang)
    // ---------------------------------------------------------------------
    final Map<String, String> pictureMap = {};

    if (pictBarang != null) {
      final pictRows = await pictBarang.values.allRows();
      if (pictRows.length > 1) {

        for (var row in pictRows.skip(1)) {
          if (row.length >= 6) {
            final kode = row[3].trim();
            final kodes = row[2].trim();
            final url = row[5].trim();
            if (kode.isNotEmpty && kodes == 'Lemari2' && url.isNotEmpty) {
              pictureMap[kode] = _getGoogleDriveDirectUrl(url);
            }
          }
        }
      }
    }

    final rows = await worksheet.values.allRows();

    if (rows.length < 3) return [];
    final header = rows[2];
    final namaBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Nama Barang');
    final kodeBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Kode Barang');
    final satuanIndex = header.indexWhere((h) => h.toString().trim() == 'Satuan');
    final stockAkhirIndex = header.indexWhere((h) => h.toString().trim() == 'Stok Akhir');
    final statusIndex = header.indexWhere((h) => h.toString().trim() == 'Status');

    if (namaBarangIndex == -1 || kodeBarangIndex == -1 || satuanIndex == -1
        || stockAkhirIndex == -1 || statusIndex == -1) {
      throw Exception("Kolom 'Nama Barang' atau 'Kode Barang' tidak ditemukan.");
    }

    final result = rows.skip(3).map((row) {
      final kodeBarang = row.length > kodeBarangIndex ? row[kodeBarangIndex].trim() : "";

      final urlFoto = pictureMap[kodeBarang] ?? "";

      return {
        "Nama Barang": row.length > namaBarangIndex
            ? row[namaBarangIndex].trim()
            : "",
        "Kode Barang": kodeBarang,
        "Satuan": row.length > satuanIndex
            ? row[satuanIndex].trim()
            : "",
        "Stok Akhir": row.length > stockAkhirIndex
            ? row[stockAkhirIndex].trim()
            : "",
        "Status": row.length > statusIndex
            ? row[statusIndex].trim()
            : "",
        "Url Foto": urlFoto,
        "Lokasi": "Lemari2",
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
        final emailSheet = row['Email']?.toString().trim().toLowerCase() ?? '';
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

Future<bool> validationEmailAndUserNameFirstLogin() async {
  try {
    if (GSheetsServicesEmployees.sheet == null) {
      await GSheetsServicesEmployees.init();
    }
    final rows = await GSheetsServicesEmployees.sheet!.values.map.allRows();

    if (rows!.isEmpty) {
      return true;
    }

    final emailInput = emailcontroller.text.trim().toLowerCase();
    final userNames = usernamecontroller.text.trim().toLowerCase();

    if (emailInput.isEmpty) {
      return false;
    }
    if (userNames.isEmpty) {
      return false;
    }

    final emailandUserNameSudahAda = rows.any((row) {

      final emailSheet = row['Email']?.toString().trim().toLowerCase() ?? '';
      final usrNameSheet = row['UserName']?.toString().trim().toLowerCase() ?? '';
      return emailSheet == emailInput && usrNameSheet == userNames;
    });

    if (emailandUserNameSudahAda) {
      return false;
    }
    await insertRegistrationFirstUser();
    await Get.off(() => const Homepagesmenus());
    ClearControllerFunc.clearControllers();

    return true;

  } catch (e) {

    debugPrint(
      'Error validation email: $e',
    );

    return false;
  }
}

// list lemari 3
Future<List<Map<String, String>>> getListDataBarangLemari3() async {
  final worksheet = GSheetsServicesEmployees.sheetsLemari3;
  final pictBarang = GSheetsServicesEmployees.sheetsPicture;

  if (worksheet == null) {
    throw Exception('sheetLemari belum diinisialisasi.');
  }

  try {

    final Map<String, String> pictureMap = {};

    if (pictBarang != null) {
      final pictRows = await pictBarang.values.allRows();
      if (pictRows.length > 1) {

        for (var row in pictRows.skip(1)) {
          if (row.length >= 6) {
            final kode = row[3].trim();
            final kodes = row[2].trim();
            final url = row[5].trim();
            if (kode.isNotEmpty && kodes == 'Lemari3' && url.isNotEmpty) {
              pictureMap[kode] = _getGoogleDriveDirectUrl(url);
            }
          }
        }
      }
    }


    final rows = await worksheet.values.allRows();

    if (rows.length < 3) return [];
    final header = rows[2];
    final namaBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Nama Barang');
    final kodeBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Kode Barang');
    final satuanIndex = header.indexWhere((h) => h.toString().trim() == 'Satuan');
    final stockAkhirIndex = header.indexWhere((h) => h.toString().trim() == 'Stok Akhir');
    final statusIndex = header.indexWhere((h) => h.toString().trim() == 'Status');

    if (namaBarangIndex == -1 || kodeBarangIndex == -1 || satuanIndex == -1
        || stockAkhirIndex == -1 || statusIndex == -1) {
      throw Exception("Kolom 'Nama Barang' atau 'Kode Barang' tidak ditemukan.");
    }

    final result = rows.skip(3).map((row) {
      final kodeBarang = row.length > kodeBarangIndex ? row[kodeBarangIndex].trim() : "";

      final urlFoto = pictureMap[kodeBarang] ?? "";

      return {
        "Nama Barang": row.length > namaBarangIndex
            ? row[namaBarangIndex].trim()
            : "",
        "Kode Barang": kodeBarang,
        "Satuan": row.length > satuanIndex
            ? row[satuanIndex].trim()
            : "",
        "Stok Akhir": row.length > stockAkhirIndex
            ? row[stockAkhirIndex].trim()
            : "",
        "Status": row.length > statusIndex
            ? row[statusIndex].trim()
            : "",
        "Url Foto": urlFoto,
        "Lokasi": "Lemari3",
      };
    }).where((e) => e["Nama Barang"]!.isNotEmpty).toList();

    return result;
  } catch (e) {
    debugPrint("Error: $e");
    rethrow;
  }
}

Future<List<Map<String, String>>> getListDataBarangMasuk() async {
  final worksheet = GSheetsServicesEmployees.sheetsBarangMasuk;

  if (worksheet == null) {
    throw Exception('sheetBarangMasuk belum diinisialisasi.');
  }

  try {
    final rows = await worksheet.values.allRows();

    if (rows.length < 3) {
      return [];
    }

    final header = rows[2];
    final tanggalBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Tanggal');
    final namaBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Nama Barang');
    final kodeBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Kode Barang');
    final jumlahBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Jumlah');
    final satuanIndex = header.indexWhere((h) => h.toString().trim() == 'Satuan');
    final posisiLemariIndex = header.indexWhere((h) => h.toString().trim() == 'Posisi Lemari');

    if (tanggalBarangIndex == -1 || namaBarangIndex == -1 || kodeBarangIndex == -1 ||
        jumlahBarangIndex == -1 || satuanIndex == -1 || posisiLemariIndex == -1) {
      throw Exception(
        "Kolom yang diperlukan tidak ditemukan.",
      );
    }

    final result = rows.skip(3).map((row) {

      final tanggal = row.length > tanggalBarangIndex
          ? convertGoogleSheetsDate(row[tanggalBarangIndex])
          : '';
      final namaBarang = row.length > namaBarangIndex
          ? row[namaBarangIndex].trim()
          : '';
      final kodeBarang = row.length > kodeBarangIndex
          ? row[kodeBarangIndex].trim()
          : '';
      final jumlahBarang = row.length > jumlahBarangIndex
          ? row[jumlahBarangIndex].trim()
          : '';
      final satuan = row.length > satuanIndex
          ? row[satuanIndex].trim()
          : '';
      final posisiLemari = row.length > posisiLemariIndex
          ? row[posisiLemariIndex].trim()
          : '';

      return {
        "Tanggal": tanggal,
        "Nama Barang": namaBarang,
        "Kode Barang": kodeBarang,
        "Jumlah": jumlahBarang,
        "Satuan": satuan,
        "Posisi Lemari": posisiLemari,
      };
    }).where((e) => e["Nama Barang"]!.isNotEmpty).toList();
    return result;

  } catch (e) {
    debugPrint("Error getListDataBarangMasuk: $e");
    rethrow;
  }
}

Future<List<Map<String, String>>> getListDataBarangKeluar() async {

  final worksheet = GSheetsServicesEmployees.sheetsBarangKeluar;
  if (worksheet == null) {
    throw Exception('sheetBarangMasuk belum diinisialisasi.');
  }

  try {
    final rows = await worksheet.values.allRows();

    if (rows.length < 3) {
      return [];
    }

    final header = rows[2];
    final tanggalBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Tanggal');
    final namaBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Nama Barang');
    final kodeBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Kode Barang');
    final jumlahBarangIndex = header.indexWhere((h) => h.toString().trim() == 'Jumlah');
    final satuanIndex = header.indexWhere((h) => h.toString().trim() == 'Satuan');
    final posisiLemariIndex = header.indexWhere((h) => h.toString().trim() == 'Posisi Lemari');

    if (tanggalBarangIndex == -1 || namaBarangIndex == -1 || kodeBarangIndex == -1 ||
        jumlahBarangIndex == -1 || satuanIndex == -1 || posisiLemariIndex == -1) {
      throw Exception(
        "Kolom yang diperlukan tidak ditemukan.",
      );
    }

    final result = rows.skip(3).map((row) {

      final tanggal = row.length > tanggalBarangIndex
          ? convertGoogleSheetsDate(row[tanggalBarangIndex])
          : '';
      final namaBarang = row.length > namaBarangIndex
          ? row[namaBarangIndex].trim()
          : '';
      final kodeBarang = row.length > kodeBarangIndex
          ? row[kodeBarangIndex].trim()
          : '';
      final jumlahBarang = row.length > jumlahBarangIndex
          ? row[jumlahBarangIndex].trim()
          : '';
      final satuan = row.length > satuanIndex
          ? row[satuanIndex].trim()
          : '';
      final posisiLemari = row.length > posisiLemariIndex
          ? row[posisiLemariIndex].trim()
          : '';

      return {
        "Tanggal": tanggal,
        "Nama Barang": namaBarang,
        "Kode Barang": kodeBarang,
        "Jumlah": jumlahBarang,
        "Satuan": satuan,
        "Posisi Lemari": posisiLemari,
      };
    }).where((e) => e["Nama Barang"]!.isNotEmpty).toList();
    return result;

  } catch (e) {
    debugPrint("Error getListDataBarangMasuk: $e");
    rethrow;
  }
}

String convertGoogleSheetsDate(dynamic value) {
  try {
    if (value == null) {
      return '';
    }
    final text = value.toString().trim();
    if (text.isEmpty) {
      return '';
    }

    if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(text)) {
      return text;
    }

    final parsedDate = DateTime.tryParse(text);
    if (parsedDate != null) {
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    }

    final serial = double.tryParse(text);
    if (serial == null) {
      return text;
    }

    final date = DateTime(1899, 12, 30).add(
      Duration(
        days: serial.floor(),
      ),
    );

    return DateFormat('yyyy-MM-dd').format(date);
  } catch (e) {
    print('Error convertGoogleSheetsDate: $e');
    return '';
  }
}

String convertGoogleSheetsTime(dynamic value) {
  try {
    if (value == null) {
      return '';
    }

    final text = value.toString().trim();
    if (text.isEmpty) {
      return '';
    }

    if (RegExp(r'^\d{2}:\d{2}:\d{2}$').hasMatch(text)) {
      return text;
    }

    if (RegExp(r'^\d{2}:\d{2}$').hasMatch(text)) {
      return '$text:00';
    }

    final parsedDate = DateTime.tryParse(text);

    if (parsedDate != null) {
      return DateFormat('HH:mm:ss').format(parsedDate);
    }

    final serial = double.tryParse(text);

    if (serial == null) {
      return text;
    }

    final totalSeconds = (serial * 24 * 60 * 60).round();
    final hours = (totalSeconds ~/ 3600) % 24;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  } catch (e) {
    print('Error convertGoogleSheetsTime: $e');
    return '';
  }
}


Future<List<Map<String, String>>> getListUsers() async {
  final worksheet = GSheetsServicesEmployees.sheet;

  if (worksheet == null) {
    throw Exception('Sheet Employee belum diinisialisasi.');
  }

  try {
    final rows = await worksheet.values.allRows();
    if (rows.length < 2) {
      return [];
    }

    final header = rows[0];

    final employeeIDIndex = header.indexWhere((h) => h.toString().trim() == 'EmployeeID',);
    final fullnameIndex = header.indexWhere((h) => h.toString().trim() == 'FullName',);
    final userNameIndex = header.indexWhere((h) => h.toString().trim() == 'UserName',);
    final tanggalLahirIndex = header.indexWhere((h) => h.toString().trim() == 'TanggalLahir',);
    final alamatIndex = header.indexWhere((h) => h.toString().trim() == 'Alamat',);
    final alamatEmailIndex = header.indexWhere((h) => h.toString().trim() == 'Email',);
    final nomerTlpIndex = header.indexWhere((h) => h.toString().trim() == 'NomerTelpon',);
    final posisiIndex = header.indexWhere((h) => h.toString().trim() == 'Posisi',);

    if (employeeIDIndex == -1 || fullnameIndex == -1 || userNameIndex == -1 || tanggalLahirIndex == -1 ||
        alamatIndex == -1 || alamatEmailIndex == -1 || nomerTlpIndex == -1 || posisiIndex == -1) {

      throw Exception(
        'Kolom EmployeeID, FullName, UserName, TanggalLahir, '
            'Alamat, Email, NomerTelpon, atau Posisi tidak ditemukan.',
      );
    }

    String getValue(List<dynamic> row, int index) {
      if (index >= 0 && index < row.length) {
        return row[index].toString().trim();
      }
      return "";
    }

    final result = rows.skip(1).map((row) {
      final tanggalLahir = convertGoogleSheetsDate(
        getValue(row, tanggalLahirIndex),
      );

      return {
        "EmployeeID": getValue(row, employeeIDIndex),
        "FullName": getValue(row, fullnameIndex),
        "UserName": getValue(row, userNameIndex),
        "TanggalLahir": tanggalLahir,
        "Alamat": getValue(row, alamatIndex),
        "Email": getValue(row, alamatEmailIndex),
        "NomerTelpon": getValue(row, nomerTlpIndex),
        "Posisi": getValue(row, posisiIndex),
      };
    }).where((user) {
      return user["FullName"]!.isNotEmpty;
    }).toList();

    return result;
  } catch (e) {
    debugPrint("Error getListUsers: $e");
    rethrow;
  }
}

Future<List<Map<String, String>>> getListNotifikasi() async {
  final worksheet = GSheetsServicesEmployees.sheetNotif;

  if (worksheet == null) {
    throw Exception(
      'Sheet Notifikasi belum diinisialisasi.',
    );
  }

  try {
    final rows = await worksheet.values.allRows();
    if (rows.length < 2) {
      return [];
    }

    final header = rows[0];
    final tanggalindex = header.indexWhere((h) => h.toString().trim() == 'Tanggal');
    final namaprosesindex = header.indexWhere((h) => h.toString().trim() == 'NamaProses');
    final kodebarangindex = header.indexWhere((h) => h.toString().trim() == 'KodeBarang');
    final namabarangindex = header.indexWhere((h) => h.toString().trim() == 'NamaBarang');
    final jumlahbarangindex = header.indexWhere((h) => h.toString().trim() == 'JumlahBarang');
    final satuanindex = header.indexWhere((h) => h.toString().trim() == 'Satuan');
    final lemariindex = header.indexWhere((h) => h.toString().trim() == 'Lemari',);
    final picindex = header.indexWhere((h) => h.toString().trim() == 'PIC');
    final keteranganindex = header.indexWhere((h) => h.toString().trim() == 'Keterangan');
    final waktuindex = header.indexWhere((h) => h.toString().trim() == 'Waktu');

    if (tanggalindex == -1 || namaprosesindex == -1 || kodebarangindex == -1 ||
        namabarangindex == -1 || jumlahbarangindex == -1 || satuanindex == -1 ||
        lemariindex == -1 || picindex == -1 || keteranganindex == -1 || waktuindex == -1) {
      throw Exception(
        'Kolom Tanggal, NamaProses, KodeBarang, NamaBarang, '
            'JumlahBarang, Satuan, Lemari, PIC, Keterangan, '
            'atau Waktu tidak ditemukan.',
      );
    }

    String getValue(List<dynamic> row, int index) {
      if (index >= 0 && index < row.length) {
        return row[index].toString().trim();
      }
      return "";
    }

    final result = rows.skip(1).map((row) {
      final tanggalNotif = convertGoogleSheetsDate(getValue(row, tanggalindex));
      final waktuNotif = convertGoogleSheetsTime(getValue(row, waktuindex));
      return {
        "Tanggal": tanggalNotif,
        "NamaProses": getValue(row, namaprosesindex),
        "KodeBarang": getValue(row, kodebarangindex),
        "NamaBarang": getValue(row, namabarangindex),
        "JumlahBarang": getValue(row, jumlahbarangindex),
        "Satuan": getValue(row, satuanindex),
        "Lemari": getValue(row, lemariindex),
        "PIC": getValue(row, picindex),
        "Keterangan": getValue(row, keteranganindex),
        "Waktu": waktuNotif,
      };
    }).where((notif) {
      return notif["KodeBarang"]?.isNotEmpty ?? false;
    }).toList();
    return result;
  } catch (e) {
    debugPrint("Error getListNotifikasi: $e",);
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

  final result = rows.where((row) {

    final valueUsrNames =
        row['UserName']?.toString() ?? '';

    final valuesPass =
        row['Pass']?.toString() ?? '';

    return valueUsrNames.contains(usrnm) &&
        valuesPass.contains(usrpass);

  }).toList();

  if (result.isNotEmpty) {
    final user = result.first;
    HomePagesUserNames.text = user['NamaDepan']?.toString() ?? '';
    HomePagesPositions.text = user['Posisi']?.toString() ?? '';
  }
  return result;
}

Future<List<Map<String, dynamic>>> sideBarPagesController() async {
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

  final result = rows.where((row) {

    final valueUsrNames =
        row['UserName']?.toString() ?? '';

    final valuesPass =
        row['Pass']?.toString() ?? '';

    return valueUsrNames.contains(usrnm) &&
        valuesPass.contains(usrpass);

  }).toList();

  if (result.isNotEmpty) {
    final user = result.first;
    sideBarFullNameController.text = user['FullName']?.toString() ?? '';
    sideBarJabatanController.text = user['Posisi']?.toString() ?? '';
    sideBarPosisiController.text = user['Roles']?.toString() ?? '';
    sideBarEmployeeIDController.text = user['EmployeeID']?.toString() ?? '';
    sideBarUserNamesController.text = user['UserName']?.toString() ?? '';
    sideBarEmailController.text = user['Email']?.toString() ?? '';
  }
  return result;
}

Future<List<Map<String, dynamic>>> findOTPCodes() async {
  try {
    if (GSheetsServicesEmployees.sheetOTP == null) {
      await GSheetsServicesEmployees.init();
    }

    final rows = await GSheetsServicesEmployees.sheetOTP!.values.map.allRows();

    if (rows == null || rows.isEmpty) {
      return [];
    }

    final emailsOTP = otpemailcontroller.text.trim();

    if (emailsOTP.isEmpty) {
      return [];
    }

    final result = rows.where((row) {
      final valueEmailsOTP = row['EmailOTP']?.toString().trim() ?? '';
      return valueEmailsOTP == emailsOTP;
    }).toList();

    if (result.isNotEmpty) {
      final otp = result.first;

      sendOTPControllers.text = otp['OTPCode']?.toString() ?? '';

    } else {
      sendOTPControllers.clear();
    }

    return result;
  } catch (e) {
    return [];
  }
}

Future<List<Map<String, dynamic>>> findOTPCodesForgot() async {
  try {
    if (GSheetsServicesEmployees.sheetOTP == null) {
      await GSheetsServicesEmployees.init();
    }

    final rows = await GSheetsServicesEmployees.sheetOTP!.values.map.allRows();

    if (rows == null || rows.isEmpty) {
      return [];
    }

    final emailsOTP = otpemailforgotcontroller.text.trim();

    if (emailsOTP.isEmpty) {
      return [];
    }

    final result = rows.where((row) {
      final valueEmailsOTP = row['EmailOTP']?.toString().trim() ?? '';
      return valueEmailsOTP == emailsOTP;
    }).toList();

    if (result.isNotEmpty) {
      final otp = result.first;

      sendOTPForgotControllers.text = otp['OTPCode']?.toString() ?? '';

    } else {
      sendOTPForgotControllers.clear();
    }

    return result;
  } catch (e) {
    return [];
  }
}

Future<List<Map<String, dynamic>>> validationOTP() async {
  try {
    if (GSheetsServicesEmployees.sheetOTP  == null) {
      await GSheetsServicesEmployees.init();
    }

    final rows =
    await GSheetsServicesEmployees.sheetOTP!.values.map.allRows();

    if (rows == null || rows.isEmpty) {
      return [];
    }

    final emailOTP = otpemailcontroller.text.trim();
    final otpCodes = otpcontrollers.text.trim();

    final results = rows.where((row) {

      final valueEmailOTP = row['EmailOTP']?.toString().trim() ?? '';
      final valuesOTPCodes = row['OTPCode']?.toString().trim() ?? '';

      return valueEmailOTP == emailOTP && valuesOTPCodes == otpCodes;

    }).toList();

    if (results.isNotEmpty) {
      Get.to(() => const ChangesPasswordPages());
      await GsheetsOTPControllers().deleteOTPCodes();
      otpcontrollers.clear();
      ClearControllerFunc.clearControllers();
    }

    return results;
  } catch (e) {
    return [];
  }
}

Future<List<Map<String, dynamic>>> validationOTPForgot() async {
  try {
    if (GSheetsServicesEmployees.sheetOTP  == null) {
      await GSheetsServicesEmployees.init();
    }

    final rows =
    await GSheetsServicesEmployees.sheetOTP!.values.map.allRows();

    if (rows == null || rows.isEmpty) {
      return [];
    }

    final emailOTP = otpemailforgotcontroller.text.trim();
    final otpCodes = otpforgotcontrollers.text.trim();

    final results = rows.where((row) {

      final valueEmailOTP = row['EmailOTP']?.toString().trim() ?? '';
      final valuesOTPCodes = row['OTPCode']?.toString().trim() ?? '';

      return valueEmailOTP == emailOTP && valuesOTPCodes == otpCodes;

    }).toList();

    if (results.isNotEmpty) {
      Get.to(() => const ForgotPasswordPages());
      await GsheetsOTPControllers().deleteOTPCodesForgot();
      otpforgotcontrollers.clear();
      ClearControllerFunc.clearControllers();
    }

    return results;
  } catch (e) {
    return [];
  }
}

Future<List<Map<String, dynamic>>> validationEmailOTP() async {
  if (GSheetsServicesEmployees.sheet == null) {
    await GSheetsServicesEmployees.init();
  }

  final rows = await GSheetsServicesEmployees.sheet!.values.map.allRows();

  if (rows!.isEmpty) {
    return [];
  }

  final emailOTPs = otpemailcontroller.text.trim();

  return rows.where((row) {

    final valueEmails = row['Email']?.toString() ?? '';

    if (valueEmails == emailOTPs) {
      Get.to(() => const OtpVerificationsPages());
    }
    return valueEmails.contains(emailOTPs) ;

  }).toList();
}

Future<List<Map<String, dynamic>>> validationEmailOTPForgot() async {
  if (GSheetsServicesEmployees.sheet == null) {
    await GSheetsServicesEmployees.init();
  }

  final rows = await GSheetsServicesEmployees.sheet!.values.map.allRows();

  if (rows!.isEmpty) {
    return [];
  }

  final emailOTPs = otpemailforgotcontroller.text.trim();

  return rows.where((row) {

    final valueEmails = row['Email']?.toString() ?? '';

    if (valueEmails == emailOTPs) {
      Get.to(() => const OtpVerificationsForgotPages());
    }
    return valueEmails.contains(emailOTPs) ;

  }).toList();
}

Future<List<Map<String, dynamic>>> validationCountAdmin() async {
  if (GSheetsServicesEmployees.sheet == null) {
    await GSheetsServicesEmployees.init();
  }

  final rows = await GSheetsServicesEmployees.sheet!.values.map.allRows();

  if (rows == null || rows.isEmpty) {
    Get.snackbar('Gagal', 'Data admin tidak ditemukan',
      snackPosition: SnackPosition.BOTTOM,
    );

    return [];
  }

  final adminRows = rows.where((row) {
    final role = row['Roles']?.toString().trim().toUpperCase();
    return role == 'ADMIN';
  }).toList();

  final jumlahAdmin = adminRows.length;

  print('Jumlah ADMIN: $jumlahAdmin');

  // Jika ADMIN lebih dari 2
  if (jumlahAdmin == 6) {
    Get.snackbar(
      'Akses Ditolak', 'Jumlah ADMIN sudah lebih dari 2.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
        colorText: Colors.white
    );
    return adminRows;
  }
  Get.to(() => const RegistrationsMenu());
  return adminRows;
}

Future<bool> deleteUser() async {
  try {
    if (GSheetsServicesEmployees.sheet == null) {
      await GSheetsServicesEmployees.init();
    }

    final rows = await GSheetsServicesEmployees.sheet!.values.map.allRows();

    if (rows == null || rows.isEmpty) {
      return false;
    }

    final employeeId = sideBarEmployeeIDController.text.trim();
    final username = sideBarUserNamesController.text.trim();

    if (employeeId.isEmpty || username.isEmpty) {
      return false;
    }

    final result = rows.where((row) {

      final valueEmployeeId = row['EmployeeID']?.toString().trim() ?? '';
      final valueUsername = row['Username']?.toString().trim() ?? '';
      return valueEmployeeId == employeeId && valueUsername == username;

    }).toList();

    if (result.isEmpty) {
      return false;
    }

    final user = result.first;
    final employeeIdValue = user['EmployeeID']?.toString().trim() ?? '';
    final usernameValue = user['UserName']?.toString().trim() ?? '';

    final allRows = await GSheetsServicesEmployees.sheet!.values.allRows();

    if (allRows.isEmpty) {
      return false;
    }

    int targetRow = -1;

    for (int i = 0; i < allRows.length; i++) {
      final row = allRows[i];
      if (row.isEmpty) {
        continue;
      }

      if (row.contains(employeeIdValue) &&
          row.contains(usernameValue)) {
        targetRow = i + 1;
        break;
      }
    }

    if (targetRow == -1) {
      return false;
    }

    await GSheetsServicesEmployees.sheet!.deleteRow(targetRow);

    return true;
  } catch (e) {
    print('Error deleteUser: $e');
    return false;
  }
}