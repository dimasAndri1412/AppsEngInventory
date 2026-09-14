import 'package:appsenginventory/OTPVerfications/EmailOtpForgotPassword/emailotpforgotfield.dart';
import 'package:flutter/material.dart';

class EmailOTPForgotWrappers extends StatefulWidget {
  const EmailOTPForgotWrappers({super.key});

  @override
  State<EmailOTPForgotWrappers> createState() => _EmailOTPForgotWrappersState();
}

class _EmailOTPForgotWrappersState extends State<EmailOTPForgotWrappers> {
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
              child: EmailOTPForgotPasswordField(),
            ),
          ),
        ],
      ),
    );
  }
}
