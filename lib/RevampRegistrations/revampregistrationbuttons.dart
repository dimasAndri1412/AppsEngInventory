import 'package:appsenginventory/HomePages/homepagesmenus.dart';
import 'package:appsenginventory/Services/gsheetscontrollers.dart';
import 'package:appsenginventory/Services/gsheetsinsertcontrollers.dart';
import 'package:appsenginventory/Services/gsheetsservices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/key.dart';

class RevampRegistrationButtons extends StatefulWidget {
  const RevampRegistrationButtons({super.key});

  @override
  State<RevampRegistrationButtons> createState() =>
      _RevampRegistrationButtonsState();
}

class _RevampRegistrationButtonsState extends State<RevampRegistrationButtons> {

  Future<void> insertRegist() async {

    try {
      if (GSheetsServicesEmployees.sheet == null) {
        debugPrint("Google Sheets belum diinisialisasi.",);
        await GSheetsServicesEmployees.init();
      }
      if (GSheetsServicesEmployees.sheet == null) {
        throw Exception("Google Sheets gagal diinisialisasi.",
        );
      }
      if (revampResgistControllerss.isEmpty) {
        throw Exception("Tidak ada data registration.",
        );
      }

      for ( int index = 0; index < revampResgistControllerss.length; index++
      ) {
        final controllers = revampResgistControllerss[index];
        final employeeId = controllers["employeeIdController"]?.text.trim() ?? '';
        final frontName = controllers["frontNameController"]?.text.trim() ?? '';
        final backName = controllers["backNameController"]?.text.trim() ?? '';
        final fullName = controllers["fullnamecontroller"]?.text.trim() ?? '';
        final username = controllers["usernamecontroller"]?.text.trim() ?? '';
        final birthDate = controllers["birthdatecontroller"]?.text.trim() ?? '';
        final address = controllers["addresscontroller"]?.text.trim() ?? '';
        final email = controllers["emailcontroller"]?.text.trim() ?? '';
        final phone = controllers["phonenumberscontroller"]?.text.trim() ?? '';
        final roles = controllers["rolesController"]?.text.trim() ?? '';
        final posisi = controllers["PositionController"]?.text.trim() ?? '';
        final password = controllers["passcontroller"]?.text.trim() ?? '';


        final insertController = GsheetsInsertControllers();

        insertController.revampEmployeeid = employeeId;
        insertController.revampFrontName = frontName;
        insertController.revampBackName = backName;
        insertController.revampFullName = fullName;
        insertController.revampUserName = username;
        insertController.revampBirthDate = birthDate;
        insertController.revampAddress = address;
        insertController.revampEmailAddress = email;
        insertController.revampPhoneNumber = phone;
        insertController.revampRoles = roles;
        insertController.revampPosisi = posisi;
        insertController.revampPass = password;
        await insertController.revampRegistrations();
      }

      if (!mounted) return;

      for (final controllers in revampResgistControllerss
      ) {
        for (final controller in controllers.values
        ) {
          controller.clear();
        }
      }

    } catch (e) {

      debugPrint(
        "ERROR: $e",
      );
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            try {
              bool isAvailable = await validationEmail();
              if (!revampRegistrationsKey.currentState!.validate()) {
                const snackBar = SnackBar(
                  content: Text(
                    'Gagal Menyimpan Data!',
                  ),
                );
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                return;
              }

              if (!isAvailable) {
                const snackBar = SnackBar(
                  content: Text(
                    'Email Sudah pernah didaftarkan!',
                  ),
                );
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                return;
              }
              await insertRegist();
              const snackBar = SnackBar(content: Text(
                  'Data Berhasil Disimpan',
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Get.to(() => const Hompagesmenus(),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Gagal menyimpan data: $e',
                  ),
                ),
              );
            }
          },
          child: Container(
            height: 60,
            width: 300,
            margin: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 8, 36, 87,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'SIMPAN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
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