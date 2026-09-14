import 'package:appsenginventory/Controller/clearfunc.dart';
import 'package:appsenginventory/OTPVerfications/EmailOtpForgotPassword/emailforgotpages.dart';
import 'package:appsenginventory/OTPVerfications/otpverficationsfields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationsPages extends StatefulWidget {
  const OtpVerificationsPages({super.key});

  @override
  State<OtpVerificationsPages> createState() => _OtpVerificationsPagesState();
}

class _OtpVerificationsPagesState extends State<OtpVerificationsPages> {
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        bool shouldNavigateBack = (await _showConfirmDialog(context)) as bool;
        return shouldNavigateBack;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _showConfirmDialog(context);
            },
            icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
          ),
          backgroundColor: const Color.fromARGB(255, 8, 36, 87),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "VERIFICATION OTP",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: OtpVerificationsField(),
        ),
      ),
    );
  }
  Future<Future<bool?>> _showConfirmDialog(BuildContext context) async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: const Icon(Icons.warning_amber,
                color: Colors.deepOrange),
            title: const Text(
              "PERHATIAN!",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text("APAKAH KAMU YAKIN INGIN KELUAR"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("TIDAK", style:
                TextStyle(color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(onPressed: () {
                Get.offAll(() => const EmailOTPForgotPages());
                ClearControllerFunc.clearControllers();
              },
                child: const Text("YA!", style:
                TextStyle(color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }
    );
  }
}
