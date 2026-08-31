import 'package:appsenginventory/ChangesPassword/changespasswordpages.dart';
import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/MenuPages/navigationmenu.dart';
import 'package:appsenginventory/OTPVerfications/EmailOTP/emailotppages.dart';
import 'package:appsenginventory/OTPVerfications/otpverificationspages.dart';
import 'package:appsenginventory/Services/gsheetsinsertregistrationsfirstuser.dart';
import 'package:appsenginventory/Services/gsheetsotpcodecontrollers.dart';
import 'package:appsenginventory/Services/gsheetsservices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      Get.offAll(() => const NavigationMenuPages());
    }

    return resultsLogin;

  } catch (e) {
    return [];
  }
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
      debugPrint("Email kosong.");
      return false;
    }

    if (userNames.isEmpty) {
      debugPrint("Username kosong.");
      return false;
    }

    final emailandUserNameSudahAda = rows.any((row) {

      final emailSheet = row['Email']?.toString().trim().toLowerCase() ?? '';
      final usrNameSheet = row['UserName']?.toString().trim().toLowerCase() ?? '';

      return emailSheet == emailInput && usrNameSheet == userNames;
    });

    if (emailandUserNameSudahAda) {

      debugPrint(
        "Email dan Username sudah terdaftar.",
      );

      debugPrint(
        "Email   : $emailInput",
      );

      debugPrint(
        "Username: $userNames",
      );

      return false;
    }

    await insertRegistrationFirstUser();

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

String convertGoogleSheetsDate(dynamic value) {
  try {
    if (value == null) {
      return '';
    }

    final text = value.toString().trim();

    if (text.isEmpty) {
      return '';
    }

    // Jika sudah dalam format yyyy-MM-dd
    if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(text)) {
      return text;
    }

    // Jika bisa langsung dibaca sebagai DateTime
    final parsedDate = DateTime.tryParse(text);

    if (parsedDate != null) {
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    }

    // Jika Google Sheets memberikan serial number
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

    debugPrint("Jumlah user ditemukan: ${result.length}");
    debugPrint("Data user: $result");

    return result;
  } catch (e) {
    debugPrint("Error getListUsers: $e");
    rethrow;
  }
}

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
    final rows = await worksheet.values.map.allRows();

    if (rows == null || rows.isEmpty) {
      print('Data Dashboard kosong');
      return [];
    }

    final List<Map<String, dynamic>> result = [];

    String currentLemari = '';

    for (final row in rows) {
      final nama = row['A']?.toString().trim() ?? '';


      if (nama.isEmpty) {
        continue;
      }


      if (nama.toLowerCase().contains('summary lemari')) {
        currentLemari = nama;
        continue;
      }

      if (currentLemari.isEmpty) {
        continue;
      }

      // Abaikan header
      if (nama.toLowerCase() == 'jumlah jenis barang' ||
          nama.toLowerCase() == 'total stok awal' ||
          nama.toLowerCase() == 'total barang masuk' ||
          nama.toLowerCase() == 'total barang keluar' ||
          nama.toLowerCase() == 'total stok saat ini' ||
          nama.toLowerCase() == 'jumlah barang kurang') {

        result.add({
          'lemari': currentLemari,
          'nama': nama,
          'jumlah': row['B']?.toString() ?? '0',
          'status': row['C']?.toString() ?? '',
          'jumlahStatus': row['D']?.toString() ?? '0',
        });
      }
    }

    print('Data Dashboard: $result');

    return result;
  } catch (e) {
    print('Error getDataDashboardStok: $e');
    return [];
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

    final allRows =
    await GSheetsServicesEmployees.sheet!.values.allRows();

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