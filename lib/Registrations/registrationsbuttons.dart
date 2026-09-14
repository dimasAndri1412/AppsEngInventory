import 'package:appsenginventory/Controller/key.dart';
import 'package:flutter/material.dart';
import '../Services/gsheetscontrollers.dart';

class Registrationsbuttons extends StatefulWidget {
  const Registrationsbuttons({super.key});

  @override
  State<Registrationsbuttons> createState() => _Registrationsbuttons();
}

class _Registrationsbuttons extends State<Registrationsbuttons> {
  bool isLoading = false;

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: Material(
            color: Colors.transparent,
            child: SizedBox(
              width: 150,
              height: 150,
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Menyimpan...',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void hideLoadingDialog() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading
          ? null
          : () async {
        // Cegah double click
        if (isLoading) {
          return;
        }

        if (!(formRegistKeys.currentState?.validate() ?? false)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Data belum lengkap. Silakan periksa kembali.',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
            ),
          );

          return;
        }

        setState(() {
          isLoading = true;
        });

        showLoadingDialog();

        try {

          final bool results =
          await validationEmailAndUserNameFirstLogin();

          if (!mounted) {
            return;
          }

          // Tutup loading
          hideLoadingDialog();

          if (results) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Data berhasil Tersimpan!',
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
                  'Data Tidak Berhasil Tersimpan!',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        } catch (e) {
          if (!mounted) {
            return;
          }

          hideLoadingDialog();

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
        width: 250,
        margin: const EdgeInsets.symmetric(
          horizontal: 50,
        ),
        decoration: BoxDecoration(
          color: isLoading
              ? Colors.grey
              : Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            isLoading
                ? 'MENYIMPAN...'
                : 'SIMPAN',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}