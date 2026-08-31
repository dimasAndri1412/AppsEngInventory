import 'package:appsenginventory/Controller/key.dart';
import 'package:flutter/material.dart';

import 'gsheetsservices.dart';

class GsheetsOTPControllers {

  Future<void> saveOTPCodes() async {
    try {

      final emailsOTP = otpemailcontroller.text;
      final otpCode = sendOTPControllers.text;
      final createTimes = otpCreateTimes.text;

      print("Email : $emailsOTP");
      print("OTP   : $otpCode");

      if (GSheetsServicesEmployees.sheetOTP == null) {
        await GSheetsServicesEmployees.init();
      }

      final worksheet = GSheetsServicesEmployees.sheetOTP;

      if (worksheet == null) {
        print("Worksheet OTP tidak ditemukan");
        return;
      }

      await worksheet.values.appendRow([
        emailsOTP,
        otpCode,
        createTimes,
      ]);

      print("OTP berhasil disimpan ke Google Sheets");
      return;

    } catch (e) {
      print("Error saveOTP : $e");
      return;
    }
  }

  Future<bool> deleteOTPCodes() async {
    try {
      final String emailOTP = otpemailcontroller.text.trim();

      print("Email yang akan dihapus: $emailOTP");

      if (emailOTP.isEmpty) {
        print("Email OTP kosong");
        return false;
      }

      if (GSheetsServicesEmployees.sheetOTP == null) {
        await GSheetsServicesEmployees.init();
      }

      final worksheet = GSheetsServicesEmployees.sheetOTP;

      if (worksheet == null) {
        print("Worksheet OTP tidak ditemukan");
        return false;
      }

      final rows = await worksheet.values.allRows();

      if (rows.isEmpty) {
        print("Data OTP kosong");
        return false;
      }

      for (int i = 0; i < rows.length; i++) {
        final row = rows[i];

        if (row.isEmpty) {
          continue;
        }

        final String emailSheet = row[0].toString().trim();

        print(
          "Cek baris ${i + 1}: "
              "Email = $emailSheet",
        );

        if (emailSheet.toLowerCase() == emailOTP.toLowerCase()) {

          final int sheetRow = i + 1;
          print("Email ditemukan di baris $sheetRow");

          await worksheet.deleteRow(sheetRow);
          print(
            "OTP dengan email $emailOTP berhasil dihapus",
          );

          return true;
        }
      }

      print(
        "Email $emailOTP tidak ditemukan di Google Sheets",
      );

      return false;
    } catch (e) {
      print("Error deleteOTPCodes: $e");
      return false;
    }
  }

}
