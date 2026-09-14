import 'package:appsenginventory/Controller/clearfunc.dart';
import 'package:appsenginventory/Login/loginpagemenu.dart';
import 'package:appsenginventory/OTPVerfications/EmailOTP/emailotpbuttons.dart';
import 'package:appsenginventory/OTPVerfications/EmailOTP/emailotpheaders.dart';
import 'package:appsenginventory/OTPVerfications/EmailOTP/emailotpwrappers.dart';
import 'package:appsenginventory/OTPVerfications/EmailOtpForgotPassword/emailotpforgotbuttons.dart';
import 'package:appsenginventory/OTPVerfications/EmailOtpForgotPassword/emailotpforgotheaders.dart';
import 'package:appsenginventory/OTPVerfications/EmailOtpForgotPassword/emailotpforgotwrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailOTPForgotPages extends StatefulWidget {
  const EmailOTPForgotPages({super.key});

  @override
  State<EmailOTPForgotPages> createState() => _EmailOTPForgotPagesState();
}

class _EmailOTPForgotPagesState extends State<EmailOTPForgotPages> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldNavigateBack =
        await _showConfirmDialog(context);

        return shouldNavigateBack ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "OTP VERIFICATIONS",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () async {
              await _showConfirmDialog(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 8, 36, 87),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 239, 242, 247),
                Color.fromARGB(255, 210, 220, 235),
                Color.fromARGB(255, 8, 36, 87),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                bottom: 25,
              ),
              child: Transform.translate(
                offset: const Offset(0, -15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 30),
                    const EmailOtpForgotHeaders(),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 15,
                              offset: Offset(2, 10),
                            ),
                          ],
                        ),
                        child: const EmailOTPForgotWrappers(),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const EmailOTPForgotButtons(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _showConfirmDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.warning_amber,
            color: Colors.deepOrange,
          ),
          title: const Text(
            "PERHATIAN!",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "APAKAH KAMU YAKIN INGIN KERLUAR?",
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Text(
                "TIDAK",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.offAll(() => const Loginpagemenus());
                ClearControllerFunc.clearControllers();
              },
              child: const Text(
                "YA!",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}