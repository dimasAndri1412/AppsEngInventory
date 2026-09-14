import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/Services/gsheetscontrollers.dart';
import 'package:appsenginventory/Services/gsheetsservices.dart';
import 'package:flutter/material.dart';

const String pasacc = "durb qtzh yooz trmn";
const String AdminEmail = "appsinventoryadmin2026@gmail.com";

String revampValueBodyEmails(Map<String, TextEditingController> bodyEmailController,) {
  return "HI, ${bodyEmailController["fullnamecontroller"]?.text}\n"
      "\n"
      "YOUR GOT DEFAULT USER :\n"
      "==============================\n"
      "USERNAME : ${bodyEmailController["usernamecontroller"]?.text}\n"
      "PASSWORD : ${bodyEmailController["passcontroller"]?.text}\n"
      "==============================\n"
      "\n"
      "PLEASE CHANGE THE DEFAULT PASSWORD WITH THE PASSWORD!\n"
      "THAT YOU WANT, AND IT'S EASY TO REMEMBER.\n"
      "AND TRY TO LOGIN WITH THE PASSWORD THAT HAS BEEN CHANGED.\n"
      "\n"
      "Thank you\n"
      "\n"
      "Best Regard\n"
      "ADMIN\n\n";
}

Future<String> sendOTPtoEmail() async {
  await findOTPCodes();

  final String bodiesEmailsOTP =
      "HI,${otpFullNamesController.text}\n"
      "\n"
      "YOUR OTP CODE :"
      "\n"
      "================================\n"
      "OTPCODE : ${sendOTPControllers.text}\n"
      "================================\n"
      "\n"
      "PLEASE INSERT OTP CODE TO NEXT STEP\n"
      "\n"
      "\n"
      "Thanks you\n"
      "\n"
      "Best Regard\n"
      "ADMIN";

  return bodiesEmailsOTP;
}

Future<String> sendOTPtoEmailForgot() async {
  await findOTPCodes();

  final String bodiesEmailsForgotOTP =
      "HI,${otpFullNamesController.text}\n"
      "\n"
      "YOUR OTP CODE :"
      "\n"
      "================================\n"
      "OTPCODE : ${sendOTPForgotControllers.text}\n"
      "================================\n"
      "\n"
      "PLEASE INSERT OTP CODE TO NEXT STEP\n"
      "\n"
      "\n"
      "Thanks you\n"
      "\n"
      "Best Regard\n"
      "ADMIN";

  return bodiesEmailsForgotOTP;
}

final String bodyEmailFirstLogins = "HI, ${fullnamecontroller.text}\n"
    "\n"
    "YOUR GOT DEFAULT USER :\n"
    "==============================\n"
    "USERNAME : ${usernamecontroller.text}\n"
    "PASSWORD : ${passcontroller.text}\n"
    "==============================\n"
    "\n"
    "PLEASE CHANGE THE DEFAULT PASSWORD WITH THE PASSWORD!\n"
    "THAT YOU WANT, AND IT'S EASY TO REMEMBER.\n"
    "AND TRY TO LOGIN WITH THE PASSWORD THAT HAS BEEN CHANGED.\n"
    "\n"
    "Thank you\n"
    "\n"
    "Best Regard\n"
    "ADMIN\n\n";


final String bodyEmailExportLaporan = "HI, ${fullnamecontroller.text}\n"
    "\n"
    "BERIKUT TERLAMPIR DOCUMENT LAPORAN\n"
    "DAFTAR ALAT LEMARI BASMENT 2\n"
    "SILAHKAN DI PERIKSA KEMBALI UNTUK LAPORANYA\n"
    "TERIMAKASIH\n\n"
    "BEST REGARD\n"
    "ADMIN\n";

final String bodyEmailExportLaporanPdf = "HI, ${fullnamecontroller.text}\n"
    "\n"
    "BERIKUT TERLAMPIR DOCUMENT LAPORAN UNTUK\n"
    "DAFTAR ALAT LEMARI BASMENT 2 YANG SUDAH SIAP DI CETAK\n"
    "SILAHKAN DI PERIKSA KEMBALI UNTUK LAPORANYA\n"
    "TERIMAKASIH\n\n"
    "BEST REGARD\n"
    "ADMIN\n";