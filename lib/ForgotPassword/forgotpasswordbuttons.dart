import 'package:appsenginventory/Controller/clearfunc.dart';
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

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector (
          onTap: isLoading
              ? null
              : () async {

            if (!forgotpasswordkey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Data belum lengkap. Silakan periksa kembali.',
                  ),
                ),
              );
              return;
            }

            setState(() {
              isLoading = true;
            });

            try {
              final bool results = await updateForgotPassword();
              if (!mounted) return;

              if (results) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Password berhasil diperbarui!',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );

                Get.offAll(() => const Homepagesmenus());
                ClearControllerFunc.clearControllers();

              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Password gagal diperbarui. '
                          'Email atau Username tidak ditemukan.',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }

            } catch (e) {
              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Terjadi kesalahan: $e',
                  ),
                  backgroundColor: Colors.red,
                ),
              );

            } finally {
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }
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
