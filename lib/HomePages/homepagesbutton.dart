import 'package:appsenginventory/Login/loginpagemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Hompagesbuttons extends StatefulWidget {
  const Hompagesbuttons({super.key});

  @override
  State<Hompagesbuttons> createState() => _HompagesbuttonsState();
}

class _HompagesbuttonsState extends State<Hompagesbuttons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            Get.offAll(() => const Loginpagemenus());
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
                  'START',
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
