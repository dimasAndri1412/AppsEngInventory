import 'package:flutter/material.dart';

import '../Controller/key.dart';

class ForgotPasswordFields extends StatefulWidget {
  const ForgotPasswordFields({super.key});

  @override
  State<ForgotPasswordFields> createState() => _ForgotPasswordFieldsState();
}

class _ForgotPasswordFieldsState extends State<ForgotPasswordFields> {

  bool passHide = true;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Form(
            key: forgotpasswordkey,
            child: Column(
              children: <Widget> [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: forgotPasswordUserName,
                    decoration: const InputDecoration(
                      labelText: "User Name",
                      hintText: "Silahkan Masukan User Name Anda",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.people),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return
                          "User Name Anda Tidak Boleh Kosong!";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: forgotPasswordEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Silahkan Masukan Email Anda",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.mail),
                    ),

                    validator: (value) {
                      final email = value?.trim() ?? '';
                      if (email.isEmpty) {
                        return
                          "Email Tidak Boleh Kosong!";
                      }
                      final validEmail = RegExp(
                        r'^[a-zA-Z0-9.!#$%&'
                        r"'*+-/=?^_`{|}~]+@"
                        r'[a-zA-Z0-9]+\.[a-zA-Z]+$',
                      ).hasMatch(email);
                      if (!validEmail) {
                        return
                          "Format Email Salah!";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black87))),
                  child: TextFormField(
                    controller: forgotPasswordNewPassword,
                    obscureText: passHide,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "New Password",
                        hintText: "Please Insert your New password",
                        hintStyle: const TextStyle(
                          color: Colors.black12,
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(passHide
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              passHide = !passHide;
                            });
                          },
                        )),
                    validator: (value) {
                      bool inValidPass = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d@$!%*?&]{10,}$').hasMatch(value!);
                      if (value == null || value.isEmpty) {
                        return "Password Can not Empty!";
                      } else if (value.length < 10) {
                        return "Password must 10 character or more";
                      } else if (!inValidPass) {
                        return "Password must include an uppercase letter, a lowercase letter, a number";
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      border:
                      Border(bottom: BorderSide(color: Colors.black87))),
                  child: TextFormField(
                    controller: forgotPasswordConfirmPassword,
                    obscureText: passHide,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "New Confirm Password",
                        hintText: "Please Insert your New Confirm password",
                        hintStyle: const TextStyle(
                          color: Colors.black12,
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(passHide
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              passHide = !passHide;
                            });
                          },
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password Can not Empty!";
                      } else if (value != forgotPasswordNewPassword.text) {
                        return "Password it's not match!";
                      }
                    },
                  ),
                ),
              ],
            )
        )
      ],
    );
  }
}
