import 'package:flutter/material.dart';

class ForgotPasswordHeaders extends StatefulWidget {
  const ForgotPasswordHeaders({super.key});

  @override
  State<ForgotPasswordHeaders> createState() => _ForgotPasswordHeadersState();
}

class _ForgotPasswordHeadersState extends State<ForgotPasswordHeaders> {
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
