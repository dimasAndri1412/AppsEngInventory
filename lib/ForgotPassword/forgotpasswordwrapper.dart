import 'package:appsenginventory/ForgotPassword/forgotpasswordfield.dart';
import 'package:flutter/material.dart';

class ForgotPasswordWrapper extends StatefulWidget {
  const ForgotPasswordWrapper({super.key});

  @override
  State<ForgotPasswordWrapper> createState() => _ForgotPasswordWrapperState();
}

class _ForgotPasswordWrapperState extends State<ForgotPasswordWrapper> {
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
              child: ForgotPasswordFields(),
            ),
          ),
        ],
      ),
    );
  }
}
