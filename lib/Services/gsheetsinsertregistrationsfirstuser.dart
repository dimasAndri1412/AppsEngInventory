import 'package:appsenginventory/SendingEmail/sendingemailfunctions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Controller/key.dart';
import 'gsheetsservices.dart';

Future<bool> insertRegistrationFirstUser() async {
  try {

    if (GSheetsServicesEmployees.sheet == null) {
      await GSheetsServicesEmployees.init();
    }

    final worksheet = GSheetsServicesEmployees.sheet;

    if (worksheet == null) {
      debugPrint(
        "Worksheet DataEmployee tidak ditemukan.",
      );
      return false;
    }

    final employeeID = employeeIdController.text.trim();
    final frontName = frontNameController.text.trim();
    final backName = backNameController.text.trim();
    final fullName = fullnamecontroller.text.trim();
    final username = usernamecontroller.text.trim();
    final tanggalLahir = birthdatecontroller.text.trim();
    final alamat = addresscontroller.text.trim();
    final nomerTelpon = phonenumberscontroller.text.trim();
    final email = emailcontroller.text.trim();
    final posisi = positionscontrollers.text.trim();
    final roles = rolesController.text.trim();
    final password = passcontroller.text.trim();
    const statusLogin = '0';

    if (employeeID.isEmpty) {
      debugPrint("Employee ID kosong.");
      return false;
    }

    if (fullName.isEmpty) {
      debugPrint("Full Name kosong.");
      return false;
    }

    if (username.isEmpty) {
      debugPrint("Username kosong.");
      return false;
    }

    if (tanggalLahir.isEmpty) {
      debugPrint("Tanggal lahir kosong.");
      return false;
    }

    if (alamat.isEmpty) {
      debugPrint("Alamat kosong.");
      return false;
    }

    if (nomerTelpon.isEmpty) {
      debugPrint("Nomor telepon kosong.");
      return false;
    }

    if (email.isEmpty) {
      debugPrint("Email kosong.");
      return false;
    }

    if (posisi.isEmpty) {
      debugPrint("Posisi kosong.");
      return false;
    }

    if (roles.isEmpty) {
      debugPrint("Roles kosong.");
      return false;
    }

    if (password.isEmpty) {
      debugPrint("Password kosong.");
      return false;
    }

    String formattedBirthDate = tanggalLahir;

    try {

      DateTime date;

      if (RegExp(r'^\d{4}-\d{2}-\d{2}$',
      ).hasMatch(tanggalLahir)) {
        date = DateFormat(
          "yyyy-MM-dd",
        ).parseStrict(tanggalLahir);
      }

      else if (RegExp(r'^\d{2}/\d{2}/\d{4}$',
      ).hasMatch(tanggalLahir)) {
        date = DateFormat("dd/MM/yyyy",
        ).parseStrict(tanggalLahir);
      }

      else if (RegExp(r'^\d{2}-\d{2}-\d{4}$',).hasMatch(tanggalLahir)) {
        date = DateFormat(
          "dd-MM-yyyy",
        ).parseStrict(tanggalLahir);
      }

      else {
        debugPrint("Format tanggal tidak dikenali: $tanggalLahir",
        );

        return false;
      }
      formattedBirthDate = DateFormat("yyyy-MM-dd").format(date);

    } catch (e) {
      return false;
    }

    final rows = await worksheet.values.allRows();

    if (rows.isEmpty) {
      debugPrint(
        "Data Google Sheets kosong.",
      );
      return false;
    }

    final headerIndex = rows.indexWhere((row) => row.any((cell) => cell.toString().trim() == "EmployeeID",),);

    if (headerIndex == -1) {
      debugPrint(
        "Header EmployeeID tidak ditemukan.",
      );
      return false;
    }

    final header = rows[headerIndex];
    final employeeIDIndex = header.indexWhere((cell) => cell.toString().trim() == "EmployeeID",);
    final usernameIndex = header.indexWhere((cell) => cell.toString().trim().toLowerCase() == "username",);
    final emailIndex = header.indexWhere((cell) => cell.toString().trim().toLowerCase() == "email",);

    if (employeeIDIndex == -1) {
      debugPrint(
        "Column EmployeeID tidak ditemukan.",
      );
      return false;
    }

    for (final row in rows.skip(headerIndex + 1)) {
      final existingEmployeeID =
      employeeIDIndex >= 0 &&
          row.length >
              employeeIDIndex
          ? row[employeeIDIndex]
          .toString()
          .trim()
          : "";

      final existingUsername =
      usernameIndex >= 0 &&
          row.length >
              usernameIndex
          ? row[usernameIndex]
          .toString()
          .trim()
          : "";

      final existingEmail =
      emailIndex >= 0 &&
          row.length >
              emailIndex
          ? row[emailIndex]
          .toString()
          .trim()
          : "";

      if (existingEmployeeID == employeeID) {
        debugPrint(
          "Employee ID sudah digunakan: "
              "$employeeID",
        );
        return false;
      }

      if (existingUsername.toLowerCase() == username.toLowerCase()) {
        debugPrint(
          "Username sudah digunakan: "
              "$username",
        );
        return false;
      }


      if (existingEmail.toLowerCase() == email.toLowerCase()) {
        debugPrint(
          "Email sudah digunakan: "
              "$email",
        );

        return false;
      }
    }

    final insertData = [
      employeeID,
      frontName,
      backName,
      fullName,
      username,
      formattedBirthDate,
      alamat,
      nomerTelpon,
      email,
      posisi,
      roles,
      password,
      statusLogin,
    ];

    int lastDataRow = headerIndex + 1;

    for (int i = headerIndex + 1; i < rows.length; i++) {

      final row = rows[i];

      if (employeeIDIndex >= 0 && row.length > employeeIDIndex) {

        final value = row[employeeIDIndex].toString().trim();

        if (value.isNotEmpty) {
          lastDataRow = i + 1;
        }
      }
    }

    final newRow = lastDataRow + 1;
    await worksheet.values.insertRow(
      newRow,
      insertData,
    );

    await const Sendingemailfunctions().sendingEmailFirstLogins();
    return true;

  } catch (e, stackTrace) {

    return false;
  }
}