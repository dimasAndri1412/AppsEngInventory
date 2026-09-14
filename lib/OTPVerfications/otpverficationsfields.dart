import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/OTPVerfications/otpverificationsbuttons.dart';
import 'package:appsenginventory/OTPVerfications/otpverificationsresendbuttons.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationsField extends StatefulWidget {
  const OtpVerificationsField({super.key});

  @override
  State<OtpVerificationsField> createState() =>
      _OtpVerificationsFieldState();
}

class _OtpVerificationsFieldState extends State<OtpVerificationsField> {
  @override
  Widget build(BuildContext context) {
    String emails = otpemailcontroller.text;
    var nameUsers = emails.split("@");
    var emailChars = emails.replaceRange(2, nameUsers[0].length,
      "*" * (nameUsers[0].length - 2),
    );

    String emailsValues = emailChars;

    final basicPinPutThemes = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.transparent,
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Form(
          key: otpveryficationskeys,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'VERIFICATION',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 40,
                ),
                child: Text(
                  'Tolong Masukan Kembali Kode OTP Yang Sudah Dikirim Kembali ke Email : $emailsValues',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Pinput(
                length: 6,
                controller: otpcontrollers,
                defaultPinTheme: basicPinPutThemes,
                focusedPinTheme: basicPinPutThemes.copyWith(
                  decoration: basicPinPutThemes.decoration!.copyWith(
                    border: Border.all(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                validator: (values) {
                  if (values == null || values.isEmpty) {
                    return 'Please Insert you OTP Code!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              const OtpVerificationsButtons(),
              const SizedBox(height: 30),
              const OtpVerificationsResndButtons(),
            ],
          ),
        ),
      ],
    );
  }
}