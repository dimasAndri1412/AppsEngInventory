import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/MenuPages/navigationmenu.dart';
import 'package:appsenginventory/Services/gsheetsservices.dart';
import 'package:get/get.dart';

Future<List<Map<String, String>>?> getDataEmployees() async {
  if (GSheetsServicesEmployees.sheet == null) {
    throw Exception(
      'Google Sheets belum diinisialisasi. Jalankan GSheetsServicesEmployees.init() terlebih dahulu.',
    );
  }
  return await GSheetsServicesEmployees.sheet!.values.map.allRows();
}


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

