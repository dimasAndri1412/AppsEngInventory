import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/Services/gsheetsupdatechangespasswordsetting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../HomePages/homepagesmenus.dart';

class ChangessPassSettingButtons extends StatefulWidget {
  const ChangessPassSettingButtons({super.key});

  @override
  State<ChangessPassSettingButtons> createState() => _ChangessPassSettingButtonsState();
}

class _ChangessPassSettingButtonsState extends State<ChangessPassSettingButtons> {
  @override
  Widget build(BuildContext context) {

    bool isLoading = false;

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: isLoading
              ? null
              : () async {

            if (!changesPasswordSettingKey.currentState!.validate()) {
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
              final bool results = await updatePasswordSetting();
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

                changesPasswordSettingEmail.clear();
                changesPasswordSettingUserName.clear();
                changesPasswordSettingNewPassword.clear();
                changesPasswordSettingConfirmPassword.clear();

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
