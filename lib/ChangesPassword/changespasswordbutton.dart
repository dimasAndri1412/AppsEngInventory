import 'package:appsenginventory/HomePages/homepagesmenus.dart';
import 'package:appsenginventory/Services/gsheetsupdatechangespassword.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/key.dart';

class ChangesPaswordButtons extends StatefulWidget {
  const ChangesPaswordButtons({super.key});

  @override
  State<ChangesPaswordButtons> createState() =>
      _ChangesPaswordButtonsState();
}

class _ChangesPaswordButtonsState
    extends State<ChangesPaswordButtons> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: isLoading
              ? null
              : () async {

            if (!changesPasswordKey.currentState!.validate()) {
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
              final bool results = await updatePassword();
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

                changesPasswordEmail.clear();
                changesPasswordUserName.clear();
                changesPasswordNewPassword.clear();
                changesPasswordConfirmPassword.clear();

                Get.to(() => const Homepagesmenus());

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
              color: isLoading
                  ? Colors.grey
                  : Colors.indigo,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
                  : const Text(
                'SIMPAN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}