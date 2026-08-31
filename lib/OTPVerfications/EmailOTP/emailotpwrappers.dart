import 'package:appsenginventory/OTPVerfications/EmailOTP/emailotpfields.dart';
import 'package:flutter/material.dart';

class EmailOTPWrappers extends StatefulWidget {
  const EmailOTPWrappers({super.key});

  @override
  State<EmailOTPWrappers> createState() => _EmailOTPWrappersState();
}

class _EmailOTPWrappersState extends State<EmailOTPWrappers> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60)),
            child: const SingleChildScrollView(
              child: EmailOTPFields(),
            ),
          ),
        ],
      ),
    );
  }
}
