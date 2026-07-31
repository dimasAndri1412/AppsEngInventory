import 'package:appsenginventory/Login/loginpagebuttons.dart';
import 'package:appsenginventory/Login/loginpagefield.dart';
import 'package:flutter/material.dart';

class Loginpagewrappers extends StatefulWidget {
  const Loginpagewrappers({super.key});

  @override
  State<Loginpagewrappers> createState() => _LoginpagewrappersState();
}

class _LoginpagewrappersState extends State<Loginpagewrappers> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 30,),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(60)),
            child: const SingleChildScrollView(
              child: Loginpagefield(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
