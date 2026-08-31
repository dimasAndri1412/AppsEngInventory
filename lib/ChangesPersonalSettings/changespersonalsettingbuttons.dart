import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/Services/gsheetsupdatechangespasswordsetting.dart';
import 'package:appsenginventory/Services/gsheetsupdatechangespersonalsetting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../HomePages/homepagesmenus.dart';

class ChangesPersonalSettingButtons extends StatefulWidget {
  const ChangesPersonalSettingButtons({super.key});

  @override
  State<ChangesPersonalSettingButtons> createState() => _ChangesPersonalSettingButtonsState();
}

class _ChangesPersonalSettingButtonsState extends State<ChangesPersonalSettingButtons> {

  @override
  Widget build(BuildContext context) {

    bool isLoading = false;

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: isLoading
              ? null
              : () async {

            if (!changesPersonalSettingKey.currentState!.validate()) {
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
              final bool results = await updatePersonalSetting();
              if (!mounted) return;

              if (results) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Data berhasil diperbarui!',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );

                changesPersonalSettingUserName.clear();
                changesPersonalSettingEmail.clear();
                changesPersonalSettingAlamat.clear();
                changesPersonalSettingNomerTelpon.clear();

                Get.to(() => const Homepagesmenus());

              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Data gagal diperbarui. ''EmployeeID atau Username tidak ditemukan.',
                      style: TextStyle(
                        color: Colors.white
                      ),
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
