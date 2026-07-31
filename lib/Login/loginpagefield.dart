import 'package:appsenginventory/Controller/key.dart';
import 'package:flutter/material.dart';

class Loginpagefield extends StatefulWidget {
  const Loginpagefield({super.key});

  @override
  State<Loginpagefield> createState() => _LoginpagefieldState();
}

class _LoginpagefieldState extends State<Loginpagefield> {

  bool passHiding = true;
  bool rememberMe = false ;
  String dropDownValues = "";
  bool passwordObscured = true;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Form(
            key: loginkeys,
            child: Column(
              children: <Widget> [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black87
                          )
                      )
                  ),
                  child: TextFormField(
                    controller: loginUserNameController,
                    decoration: const InputDecoration(
                        labelText: "UsaerName/Email",
                        hintText:  "Silahkan Masukan Username atau Email anda",
                        hintStyle: TextStyle(color: Colors.black26),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                            Icons.people
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field Nama Depan tidak Boleh Kosong!";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        border:
                        Border(
                            bottom: BorderSide(
                                color: Colors.black87
                            )
                        )
                    ),
                    child: TextFormField(
                      obscureText: passHiding,
                      controller: loginPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Silahkan Masukan Password Anda',
                        hintStyle: const TextStyle(color: Colors.black26),
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordObscured =
                                !passwordObscured;
                              });
                              },
                            icon: Icon(
                                passwordObscured ?
                                Icons.visibility_off : Icons
                                    .visibility
                            ),
                        )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password tidak boleh kosong!";
                        }
                        return null;
                      },
                    )
                ),
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      activeColor: const Color(0xff123D8C),
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                    ),
                    const Text(
                      "Ingat saya",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {

                        });
                      },
                      child: const Text(''
                          'Forgot Password ?',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
        )
      ],
    );
  }
}
