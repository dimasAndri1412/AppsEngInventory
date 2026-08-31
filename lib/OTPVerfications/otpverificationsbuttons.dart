import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/Services/gsheetscontrollers.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class OtpVerificationsButtons extends StatefulWidget {
  const OtpVerificationsButtons({super.key});

  @override
  State<OtpVerificationsButtons> createState() => _OtpVerificationsButtonsState();
}

class _OtpVerificationsButtonsState extends State<OtpVerificationsButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            if (!otpveryficationskeys.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Validasi Gagal! Periksa Kembali Kode OTP!.'),
                ),
              );
              return;
            }
            final results = await validationOTP();
            if (results.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Kode OTP benar, Validasi Berhasil!'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Validasi Gagal! Periksa Kembali Kode OTP!'),
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
