
import 'package:appsenginventory/HomePages/homepagesbutton.dart';
import 'package:flutter/material.dart';

class Homepagesmenus extends StatefulWidget {
  const Homepagesmenus({super.key});

  @override
  State<Homepagesmenus> createState() => _HomepagesmenusState();
}

class _HomepagesmenusState extends State<Homepagesmenus> {


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
           const Align(
            alignment:  Alignment(0, 0.35), // X, Y
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:  [
                SizedBox(height: 80),
                Hompagesbuttons(),
                SizedBox(height: 16),
                Text(
                  "Version 1.0.0",
                  style: TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
