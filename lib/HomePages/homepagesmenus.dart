import 'package:appsenginventory/HomePages/homepagesbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../MenuPages/menupages.dart';

class Hompagesmenus extends StatefulWidget {
  const Hompagesmenus({super.key});

  @override
  State<Hompagesmenus> createState() => _HompagesmenusState();
}

class _HompagesmenusState extends State<Hompagesmenus> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill (
              child: Image.asset(
                'lib/assets/images/homepic.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
          ),
           Align(
            alignment:  Alignment(0, 0.35), // X, Y
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:  [
                Hompagesbuttons(),
                SizedBox(height: 16),
                Text(
                  "Version 1.0.0",
                  style: TextStyle(color: Colors.black87),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Get.offAll(() => const Menupages());
                  },
                  child: const Text(
                    "UjiCoba MenuPages",
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}
