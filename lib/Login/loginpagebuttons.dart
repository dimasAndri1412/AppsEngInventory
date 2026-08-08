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
            if (loginkeys.currentState!.validate()) {
              await validationLogins();
              const snackBar = SnackBar(
                content: Text('Login Sucessfully!'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              const snackBar = SnackBar(
                content: Text('Login Gagal!, Lakukan Kembali'),
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
