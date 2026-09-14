import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/Services/gsheetscontrollers.dart';
import 'package:flutter/material.dart';

class Loginpagebuttons extends StatefulWidget {
  const Loginpagebuttons({super.key});

  @override
  State<Loginpagebuttons> createState() => _LoginpagebuttonsState();
}

class _LoginpagebuttonsState extends State<Loginpagebuttons> {
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    sideBarPagesController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: isloading ? null
              : () async {
            if (!loginkeys.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Login Gagal! Periksa Username dan Password.',
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
              isloading = true;
            });

            try {

              final results = await validationLogins();
              if (!mounted) return;

              if (results.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Username dan Password benar, Login Berhasil!',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );

              } else {
                setState(() {
                  isloading = false;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Username atau Password salah, Login Gagal!',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            } catch (e) {
              if (!mounted) return;

              setState(() {
                isloading = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Terjadi kesalahan: $e',
                    style: const TextStyle(
                      color: Colors.white,
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
            margin: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            decoration: BoxDecoration(
              color: isloading
                  ? Colors.indigo.shade300
                  : Colors.indigo,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: isloading ? const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor:
                  AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              ) : const Text(
                'Login',
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