import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/Services/gsheetscontrollers.dart';
import 'package:flutter/material.dart';

class OtpVerificationsForgotButtons extends StatefulWidget {
  const OtpVerificationsForgotButtons({super.key});

  @override
  State<OtpVerificationsForgotButtons> createState() => _OtpVerificationsForgotButtonsState();
}

class _OtpVerificationsForgotButtonsState extends State<OtpVerificationsForgotButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            if (!otpveryficationsforgotkeys.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Validasi Gagal! Periksa Kembali Kode OTP!.',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }
            final results = await validationOTPForgot();
            if (results.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Kode OTP benar, Validasi Berhasil!',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Validasi Gagal! Periksa Kembali Kode OTP!',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Container(
              height: 50,
              width: 300,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'CONFIRM',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),

                ),
              )
          ),
        )
      ],
    );
  }
}
