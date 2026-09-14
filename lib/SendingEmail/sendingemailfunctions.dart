import 'dart:io';
import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/SendingEmail/sendingemailcontrollers.dart';
import 'package:appsenginventory/Services/gsheetsexportcontrollers.dart';
import 'package:appsenginventory/Services/gsheetsotpcodecontrollers.dart';
import 'package:appsenginventory/assets/Files/sheetsconfigs.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../OTPVerfications/FunctionsOTP/functionsotp.dart';
import '../Services/gsheetsexportpdfcontorller.dart';

class Sendingemailfunctions {
  const Sendingemailfunctions();

  Future<void> sendingEmailFunc() async {
    try {
      const String userEmail = AdminEmail;
      final smtpServer = gmail(
        userEmail,
        pasacc,
      );

      final List<Map<String, String>> emailData = [];
      for (final controllers in revampResgistControllerss) {
        final String email = controllers["emailcontroller"]?.text.trim() ?? '';
        if (email.isEmpty) {
          continue;
        }

        final String body = revampValueBodyEmails(
          controllers,
        );

        emailData.add({
          "email": email,
          "body": body,
        });
      }

      for (final data in emailData) {
        final String recipient = data["email"]!;
        final String body = data["body"]!;

        final message = Message()
          ..from = const Address(userEmail)
          ..recipients.add(recipient)
          ..subject =
              "ATTENTION YOU DEFAULT PASSWORD AND PLEASE CHANGES DEFAULT PASSWORD NOW!"
          ..text = body;

        try {
          final sendReport = await send(
            message,
            smtpServer,
          );
        } catch (e) {
          print(
            "Gagal mengirim email ke $recipient : $e",
          );
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> sendingEmailOTPFunc() async {
    try {
      final otpController = GsheetsOTPControllers();

      // Tunggu OTP tersimpan di Google Sheets
      await otpController.saveOTPCodes();

      const String userEmail = AdminEmail;
      final String recipient = otpemailcontroller.text.trim();

      if (recipient.isEmpty) {
        print("Email OTP kosong");
        return false;
      }

      final smtpServer = gmail(
        userEmail,
        pasacc,
      );

      // Tunggu body email selesai dibuat
      final String body = await sendOTPtoEmail();

      final message = Message()
        ..from = const Address(userEmail)
        ..recipients.add(recipient)
        ..subject = "YOUR OTP CODE"
        ..text = body;

      // WAJIB ditunggu sampai proses SMTP selesai
      await send(
        message,
        smtpServer,
      );

      print("OTP berhasil dikirim ke $recipient");

      return true;
    } catch (e) {
      print("Error sendingEmailOTPFunc : $e");

      return false;
    }
  }

  Future<bool> sendingEmailOTPForgotFunc() async {
    try {
      final otpController = GsheetsOTPControllers();

      await otpController.saveOTPForgotCodes();

      const String userEmail = AdminEmail;
      final String recipient = otpemailforgotcontroller.text.trim();

      if (recipient.isEmpty) {
        print("Email OTP kosong");
        return false;
      }

      final smtpServer = gmail(
        userEmail,
        pasacc,
      );

      final String body = await sendOTPtoEmailForgot();

      final message = Message()
        ..from = const Address(userEmail)
        ..recipients.add(recipient)
        ..subject = "YOUR OTP CODE"
        ..text = body;
      await send(
        message,
        smtpServer,
      );

      print("OTP berhasil dikirim ke $recipient");

      return true;
    } catch (e) {
      print("Error sendingEmailOTPFunc : $e");

      return false;
    }
  }

  Future<void> reSendingEmailOTPFunc() async {
    try {

      await GsheetsOTPControllers().deleteOTPCodes();
      final otpcodes = FunctionotpKeys.generatedOTP();
      sendOTPControllers.clear();
      sendOTPControllers.text = otpcodes;
      await GsheetsOTPControllers().saveOTPCodes();

      const String userEmail = AdminEmail;
      final String recipient = otpemailcontroller.text.trim();

      if (recipient.isEmpty) {
        print("Email OTP kosong");
        return;
      }

      final smtpServer = gmail(
        userEmail,
        pasacc,
      );

      final String body = await sendOTPtoEmail();

      final message = Message()
        ..from = const Address(userEmail)
        ..recipients.add(recipient)
        ..subject = "YOUR OTP CODE"
        ..text = body;

      await send(
        message,
        smtpServer,
      );

      print("OTP berhasil dikirim ke $recipient");
    } catch (e) {
      print("Error sendingEmailOTPFunc : $e");
      rethrow;
    }
  }

  Future<void> reSendingEmailOTPForgotFunc() async {
    try {

      await GsheetsOTPControllers().deleteOTPCodesForgot();
      final otpcodes = FunctionotpKeys.generatedOTP();
      sendOTPForgotControllers.clear();
      sendOTPForgotControllers.text = otpcodes;
      await GsheetsOTPControllers().saveOTPCodesForgot();

      const String userEmail = AdminEmail;
      final String recipient = otpemailforgotcontroller.text.trim();

      if (recipient.isEmpty) {
        print("Email OTP kosong");
        return;
      }

      final smtpServer = gmail(
        userEmail,
        pasacc,
      );

      final String body = await sendOTPtoEmailForgot();

      final message = Message()
        ..from = const Address(userEmail)
        ..recipients.add(recipient)
        ..subject = "YOUR OTP CODE"
        ..text = body;

      await send(
        message,
        smtpServer,
      );

      print("OTP berhasil dikirim ke $recipient");
    } catch (e) {
      print("Error sendingEmailOTPFunc : $e");
      rethrow;
    }
  }

  Future<void> sendingEmailFirstLogins() async {
    try {

      const String userEmail = AdminEmail;
      final String recipient = emailcontroller.text.trim();

      if (recipient.isEmpty) {
        return;
      }

      final smtpServer = gmail(
        userEmail,
        pasacc,
      );

      final String body = bodyEmailFirstLogins;

      final message = Message()
        ..from = const Address(userEmail)
        ..recipients.add(recipient)
        ..subject = "YOUR OTP CODE"
        ..text = body;

      await send(
        message,
        smtpServer,
      );
      print("Email berhasil dikirim ke $recipient");
    } catch (e) {
      print("Error sendingEmailOTPFunc : $e");
      rethrow;
    }
  }

  Future<bool> sendingEmailExportExcel() async {
    try {

      const String userEmail = AdminEmail;
      final String recipient = sideBarEmailController.text.trim();

      if (recipient.isEmpty) {
        return false;
      }

      const String spid = GsheetsConfigs.gsheetsIDDaftarLemari;

      final String filePath =
      await GoogleSheetsExportService.exportAllSheetsToExcel(
        spreadsheetId: spid,
        credentialAssetPath:
        'lib/assets/Files/gsheetsproects-613d6eb9ccc1.json',
        shareFile: false,
      );


      final File excelFile = File(filePath);
      if (!await excelFile.exists()) {
        throw Exception(
          'File Excel tidak ditemukan: $filePath',
        );
      }

      final smtpServer = gmail(
        userEmail,
        pasacc,
      );

      final String body = bodyEmailExportLaporan;
      final message = Message()
        ..from = const Address(userEmail,)
        ..recipients.add(recipient,)
        ..subject = 'EXPORT LAPORAN BASEMENT'
        ..text = body
        ..attachments = [
          FileAttachment(
            excelFile,
          ),
        ];

      await send(message, smtpServer);
      return true;

    } catch (e) {

      print('======================================');
      print('ERROR SENDING EMAIL EXPORT EXCEL');
      print('ERROR : $e');
      print('======================================');

      return false;
    }
  }

  Future<bool> sendingEmailExportPDF() async {
    try {

      const String userEmail = AdminEmail;

      final String recipient = sideBarEmailController.text.trim();

      if (recipient.isEmpty) {
        return false;
      }

      final String filePath = await GSheetsToPdfService.exportDaftarStokToPdf();

      final File pdfFile = File(filePath);

      if (!await pdfFile.exists()) {
        print('File PDF tidak ditemukan.');
        return false;
      }

      final int fileSize = await pdfFile.length();

      if (fileSize <= 0) {
        print('File PDF kosong.');
        return false;
      }

      final smtpServer = gmail(
        userEmail,
        pasacc,
      );

      final Message message =
      Message()
        ..from = Address(userEmail,)
        ..recipients.add(recipient,)
        ..subject = 'EXPORT LAPORAN BASEMENT'
        ..text = bodyEmailExportLaporanPdf
        ..attachments = [
          FileAttachment(
            pdfFile,
          ),
        ];

      await send(
        message,
        smtpServer,
      );

      return true;

    } catch (e, stackTrace) {
      print('ERROR : $e');
      print('STACK : $stackTrace');
      return false;
    }
  }

}