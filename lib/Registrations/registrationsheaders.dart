import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';

class Registrationsheaders extends StatefulWidget {
  const Registrationsheaders({super.key});

  @override
  State<Registrationsheaders> createState() => _RegistrationsheadersState();
}

class _RegistrationsheadersState extends State<Registrationsheaders> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 250,
            child: Image.asset('lib/assets/images/Untitled-1.png',
            )
          )
        ],
      ),
    );
  }
}
