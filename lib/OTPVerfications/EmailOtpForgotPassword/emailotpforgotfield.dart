import 'package:appsenginventory/Controller/key.dart';
import 'package:flutter/material.dart';

class EmailOTPForgotPasswordField extends StatefulWidget {
  const EmailOTPForgotPasswordField({super.key});

  @override
  State<EmailOTPForgotPasswordField> createState() => _EmailOTPForgotPasswordFieldState();
}

class _EmailOTPForgotPasswordFieldState extends State<EmailOTPForgotPasswordField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Form(
          key: otpEmailForgotKeys,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black87)
                )
            ),
            child: TextFormField(
              controller: otpemailforgotcontroller,
              decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Please Insert Your Email",
                  hintStyle: TextStyle(color: Colors.black26),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.mail)),
              validator: (value) {
                bool inValidEmail = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                if (value == null || value.isEmpty) {
                  return 'Email Can not empty!';
                } else if (!inValidEmail) {
                  //emailcontroller.clear();
                  return "Incorrect Email format";
                }
                return null;
              },
            ),
          ),
        )
      ],
    );
  }
}
