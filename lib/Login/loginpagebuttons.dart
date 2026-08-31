import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/MenuPages/navigationmenu.dart';
import 'package:appsenginventory/Services/gsheetscontrollers.dart';
import 'package:appsenginventory/Services/gsheetsservices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loginpagebuttons extends StatefulWidget {
  const Loginpagebuttons({super.key});

  @override
  State<Loginpagebuttons> createState() => _LoginpagebuttonsState();
}

class _LoginpagebuttonsState extends State<Loginpagebuttons> {

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector (
          onTap: () async {
            if (!loginkeys.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login Gagal! Periksa Username dan Password.',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }
            final results = await validationLogins();
            if (results.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Username dan Password benar, Login Berhasil!',
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
                  content: Text('Username atau Password salah, Login Gagal!',
                    style: TextStyle(
                        color: Colors.white
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
              margin: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Login',
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
