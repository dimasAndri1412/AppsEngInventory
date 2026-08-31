import 'package:appsenginventory/Controller/key.dart';
import 'gsheetsservices.dart';

Future<bool> updatePersonalSetting() async {
  try {
    if (GSheetsServicesEmployees.sheet == null) {
      await GSheetsServicesEmployees.init();
    }

    final worksheet = GSheetsServicesEmployees.sheet!;

    final rows = await worksheet.values.map.allRows();

    if (rows == null || rows.isEmpty) {
      return false;
    }

    final userNames = sideBarUserNamesController.text.trim().toLowerCase();
    final employeeID = sideBarEmployeeIDController.text.trim().toLowerCase();
    final newEmail = changesPersonalSettingEmail.text.trim().toLowerCase();
    final newUserName = changesPersonalSettingUserName.text.trim().toLowerCase();
    final newAlamat = changesPersonalSettingAlamat.text.trim();
    final newNomereTelpon = changesPersonalSettingNomerTelpon.text.trim();

    if (newEmail.isEmpty || newUserName.isEmpty || newAlamat.isEmpty || newNomereTelpon.isEmpty) {
      return false;
    }

    for (int i = 0; i < rows.length; i++) {
      final row = rows[i];

      final sheetEmployeeID = row['EmployeeID']?.toString().trim().toLowerCase() ?? '';
      final sheetUsername = row['UserName']?.toString().trim().toLowerCase() ?? '';

      if (sheetEmployeeID == employeeID && sheetUsername == userNames) {

        final sheetRow = i + 2;

        await worksheet.values.insertValue(newUserName, column: 5, row: sheetRow,);
        await worksheet.values.insertValue(newAlamat, column: 7, row: sheetRow,);
        await worksheet.values.insertValue(newEmail, column: 8, row: sheetRow,);
        await worksheet.values.insertValue(newNomereTelpon, column: 9, row: sheetRow,);

        return true;
      }
    }
    return false;

  } catch (e) {
    return false;
  }
}