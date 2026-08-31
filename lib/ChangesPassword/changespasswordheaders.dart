import 'package:flutter/material.dart';

class ChangesPasswordHeaders extends StatefulWidget {
  const ChangesPasswordHeaders({super.key});

  @override
  State<ChangesPasswordHeaders> createState() => _ChangesPasswordHeadersState();
}

class _ChangesPasswordHeadersState extends State<ChangesPasswordHeaders> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
