import 'package:flutter/material.dart';

class EmailOtpForgotHeaders extends StatefulWidget {
  const EmailOtpForgotHeaders({super.key});

  @override
  State<EmailOtpForgotHeaders> createState() => _EmailOtpForgotHeadersState();
}

class _EmailOtpForgotHeadersState extends State<EmailOtpForgotHeaders> {
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
