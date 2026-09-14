import 'package:appsenginventory/MenuPages/navigationmenu.dart';
import 'package:appsenginventory/SendingEmail/sendingemailfunctions.dart';
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

class _RevampRegistrationButtonsState
    extends State<RevampRegistrationButtons> {

  bool _isSaving = false;

  void _showLoadingDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 18,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                  SizedBox(width: 18),
                  Text(
                    'Menyimpan data...',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    if (!mounted) return;

    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  Map<String, dynamic>? getDuplicateUsernameInfo() {
    final Map<String, int> usernames = {};

    for (int index = 0; index < revampResgistControllerss.length; index++
    ) {
      final username =
          revampResgistControllerss[index]["usernamecontroller"]?.text.trim().toLowerCase() ?? '';
      if (username.isEmpty) {
        continue;
      }

      if (usernames.containsKey(username)) {
        return {
          'username': username,
          'firstIndex': usernames[username],
          'duplicateIndex': index,
        };
      }
      usernames[username] = index;
    }

    return null;
  }

  Future<void> insertRegist() async {
    try {

      if (GSheetsServicesEmployees.sheet == null) {
        await GSheetsServicesEmployees.init();
      }

      if (GSheetsServicesEmployees.sheet == null) {
        throw Exception(
          "Google Sheets gagal diinisialisasi.",
        );
      }

      if (revampResgistControllerss.isEmpty) {
        throw Exception(
          "Tidak ada data registration.",
        );
      }

      for (int index = 0; index < revampResgistControllerss.length; index++) {

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
        const statusLogin = "0";

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
        insertController.revampStatusLogin = statusLogin;

        await insertController.revampRegistrations();

      }
      if (!mounted) return;

    } catch (e) {
      rethrow;
    }
  }

  void clearRegistrationControllers() {try {
    for (final controllers in revampResgistControllerss) {
        for (final controller in controllers.values
        ) {
          controller.clear();
        }
      }
    } catch (e) {
      debugPrint(
        "ERROR CLEAR CONTROLLER: $e",
      );
    }
  }

  Future<void> _handleSave() async {

    if (_isSaving) {
      return;
    }

    final formState = revampRegistrationsKey.currentState;

    if (formState == null) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Form tidak dapat divalidasi.',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    final bool isValid = formState.validate();

    if (!isValid) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gagal Menyimpan Data!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }


    final duplicateUsername = getDuplicateUsernameInfo();

    if (duplicateUsername != null) {
      if (!mounted) return;

      final String username = duplicateUsername['username'];
      final int firstIndex = duplicateUsername['firstIndex'];
      final int duplicateIndex = duplicateUsername['duplicateIndex'];

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(
            seconds: 5,
          ),
          content: Text(
            'Username "$username" sudah digunakan. '
                'Page ${firstIndex + 1} dan '
                'Page ${duplicateIndex + 1} memiliki username yang sama.',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    bool isEmailAvailable;

    try {
      isEmailAvailable =
      await validationEmail();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal melakukan validasi email: $e',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    if (!isEmailAvailable) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Email Sudah pernah didaftarkan!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    if (!mounted) return;

    setState(() {
      _isSaving = true;
    });

    _showLoadingDialog();

    try {
      await insertRegist();
      await const Sendingemailfunctions().sendingEmailFunc();
      clearRegistrationControllers();
      _hideLoadingDialog();

      if (!mounted) return;

      setState(() {
        _isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Data Berhasil Disimpan',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );

      Get.to(() => const NavigationMenuPages(),);

    } catch (e) {

      _hideLoadingDialog();

      if (!mounted) return;

      setState(() {
        _isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal menyimpan data: $e',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(onTap: _isSaving ? null : _handleSave,
          child: AnimatedOpacity(
            duration: const Duration(
              milliseconds: 200,
            ),
            opacity: _isSaving ? 0.6
                : 1.0,
            child: Container(
              height: 60,
              width: 300,
              margin: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255, 8, 36, 87,),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: _isSaving ? const SizedBox(
                  width: 25,
                  height: 25,
                  child:
                  CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white,
                    ),
                  ),
                ) : const Text(
                  'SIMPAN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}