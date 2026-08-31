import 'package:flutter/material.dart';

class EmailOtpHeaders extends StatefulWidget {
  const EmailOtpHeaders({super.key});

  @override
  State<EmailOtpHeaders> createState() => _EmailOtpHeadersState();
}

class _EmailOtpHeadersState extends State<EmailOtpHeaders> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              width: 250,
              child: Image.asset('lib/assets/images/otp_verfication.png',
              )
          )
        ],
      ),
    );
  }
}
