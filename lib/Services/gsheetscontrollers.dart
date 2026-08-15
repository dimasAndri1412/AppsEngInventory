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

    if (valueUsrNames.isNotEmpty && valuesPass.isNotEmpty) {
      Get.offAll(() => const NavigationMenuPages());
    }

    return valueUsrNames.contains(usrnm) &&
    valuesPass.contains(usrpass);

  }).toList();
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





