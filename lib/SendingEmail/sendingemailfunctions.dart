import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/SendingEmail/sendingemailcontrollers.dart';
import 'package:appsenginventory/Services/gsheetsotpcodecontrollers.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../OTPVerfications/FunctionsOTP/functionsotp.dart';

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

  Future<void> sendingEmailOTPFunc() async {
    try {

      final otpController = GsheetsOTPControllers();
      await otpController.saveOTPCodes();

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

}