import 'package:appsenginventory/Services/gsheetsupdateforgotpassword.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/key.dart';
import '../HomePages/homepagesmenus.dart';

class ForgotPasswordButtons extends StatefulWidget {
  const ForgotPasswordButtons({super.key});

  @override
  State<ForgotPasswordButtons> createState() => _ForgotPasswordButtonsState();
}

class _ForgotPasswordButtonsState extends State<ForgotPasswordButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector (
          onTap: () async {
            if (forgotpasswordkey.currentState!.validate()) {
              const snackBar = SnackBar(
                content: Text('Perubahan Berhasil!'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              await updateForgotPassword();
              Get.to(() => const Homepagesmenus());
            } else {
              const snackBar = SnackBar(
                content: Text('Perubahan Gagal!, Lakukan Kembali'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Container(
              height: 50,
              width: 300,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'SIMPAN',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              )
          ),
        )
      ],
    );
  }
}
