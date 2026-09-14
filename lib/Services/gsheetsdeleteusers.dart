import 'package:flutter/foundation.dart';
import 'gsheetsservices.dart';

Future<bool> deleteUserByEmployeeID({
  required String employeeID,
}) async {
  try {
    final worksheet = GSheetsServicesEmployees.sheet;

    if (worksheet == null) {
      throw Exception(
        'Sheet Employee belum diinisialisasi.',
      );
    }

    final targetEmployeeID =
    employeeID.trim();

    if (targetEmployeeID.isEmpty) {
      throw Exception(
        'EmployeeID kosong.',
      );
    }

    final rows = await worksheet.values.allRows();

    if (rows.length < 2) {
      return false;
    }

    final header = rows[0];

    final employeeIDIndex = header.indexWhere((h) => h.toString().trim() == 'EmployeeID');

    if (employeeIDIndex == -1) {
      throw Exception(
        'Kolom EmployeeID tidak ditemukan.',
      );
    }


    for (int i = 1; i < rows.length; i++) {

      final row = rows[i];

      if (employeeIDIndex >= row.length) {
        continue;
      }

      final currentEmployeeID = row[employeeIDIndex].toString().trim();


      if (currentEmployeeID == targetEmployeeID) {

        final googleSheetRow = i + 1;

        final result = await worksheet.deleteRow(googleSheetRow);

        if (result) {
          debugPrint(
            "User berhasil dihapus.",
          );

          return true;
        }

        return false;
      }
    }

    return false;

  } catch (e, stackTrace) {

    debugPrint(
      "Error deleteUserByEmployeeID: $e",
    );

    debugPrint(
      "$stackTrace",
    );

    return false;
  }
}