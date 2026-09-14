import 'package:appsenginventory/Controller/key.dart';
import 'gsheetsservices.dart';

Future<bool> updatePassword() async {
  try {
    if (GSheetsServicesEmployees.sheet == null) {
      await GSheetsServicesEmployees.init();
    }

    final worksheet = GSheetsServicesEmployees.sheet!;

    final rows = await worksheet.values.map.allRows();

    if (rows == null || rows.isEmpty) {
      return false;
    }

    final email = changesPasswordEmail.text.trim().toLowerCase();
    final username = changesPasswordUserName.text.trim().toLowerCase();
    final newPassword = changesPasswordNewPassword.text.trim();
    const newStatusLogin = '1';

    if (email.isEmpty || username.isEmpty || newPassword.isEmpty) {
      return false;
    }

    for (int i = 0; i < rows.length; i++) {
      final row = rows[i];

      final sheetEmail = row['Email']?.toString().trim().toLowerCase() ?? '';
      final sheetUsername = row['UserName']?.toString().trim().toLowerCase() ?? '';

      if (sheetEmail == email && sheetUsername == username) {

        final sheetRow = i + 2;

        await worksheet.values.insertValue(newPassword, column: 12, row: sheetRow,);
        await worksheet.values.insertValue(newStatusLogin, column: 13, row: sheetRow,);

        return true;
      }
    }

    print('Email atau Username tidak ditemukan');
    return false;

  } catch (e) {
    print('Error update password: $e');
    return false;
  }
}