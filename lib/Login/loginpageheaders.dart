import 'package:flutter/material.dart';

class Loginpageheaders extends StatefulWidget {
  const Loginpageheaders({super.key});

  @override
  State<Loginpageheaders> createState() => _LoginpageheadersState();
}

class _LoginpageheadersState extends State<Loginpageheaders> {
  @override
  Widget build(BuildContext context) {
    return  Transform.translate(
      offset: const Offset(0, -60), // naik 30 pixel
      child: SizedBox(
        width: 380,
        child: Image.asset(
          'lib/assets/images/logo_Kemenlu.png',
        ),
      ),
    );
  }
}
