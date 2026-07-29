//import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../Registrations/Functions/functionPassword.dart';
import '../Controller/key.dart';


class RegistrationsFieldapps extends StatefulWidget {
  const RegistrationsFieldapps({super.key});

  @override
  State<RegistrationsFieldapps> createState() => _RegistrationsFieldappss();
}

class _RegistrationsFieldappss extends State<RegistrationsFieldapps> {

  bool passHiding = true;
  String dropDownValues = "";

  @override
  void iniState() {
    super.initState();
    frontNameController.addListener(updateFullNames);
    backNameController.addListener(updateFullNames);
    birthdatecontroller.text = "";
    dropDownValues = "";
  }

  @override
  void dispose() {
    frontNameController.removeListener(updateFullNames);
    backNameController.removeListener(updateFullNames);
    super.dispose();
  }

  void updateFullNames() {
    final firstNames = frontNameController.text.trim();
    final lastNames = backNameController.text.trim();

    if (firstNames.isNotEmpty && lastNames.isNotEmpty) {
      fullnamecontroller.text = "$firstNames $lastNames";
    }
    else {
      fullnamecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(
              key: formKeys,
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
                      controller: frontNameController,
                      decoration: const InputDecoration(
                          labelText: "Nama Depan",
                          hintText:  "Silahkan Masukan Nama Depan Anda",
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
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.black87
                            )
                        )
                    ),
                    child: TextFormField(
                      controller: backNameController,
                      decoration: const InputDecoration(
                          labelText: "Nama Belakang",
                          hintText:  "Silahkan Masukan Nama Belakang Anda",
                          hintStyle: TextStyle(color: Colors.black26),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                              Icons.people
                          )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field Nama Belakang tidak Boleh Kosong!";
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
                                color: Colors.black87
                            )
                        )
                    ),
                    child: TextFormField(
                      controller: fullnamecontroller,
                      decoration: const InputDecoration(
                          labelText: "Nama Lengkap",
                          hintText:  "Silahkan Masukan Nama Lengkap Anda",
                          hintStyle: TextStyle(color: Colors.black26),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                              Icons.people
                          )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field Nama Lengkap tidak Boleh Kosong!";
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
                                color: Colors.black87
                            )
                        )
                    ),
                    child: TextFormField(
                      controller: usernamecontroller,
                      decoration: const InputDecoration(
                          labelText: "UserName",
                          hintText:  "Silahkan Masukan Username Anda",
                          hintStyle: TextStyle(color: Colors.black26),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                              Icons.people
                          )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field UserName tidak Boleh Kosong!";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black87))),
                    child: TextFormField(
                      controller: birthdatecontroller,
                      decoration: const InputDecoration(
                          labelText: "Tanggal Lahir",
                          hintText: "Silahkan Masukan Tanggal Lahir anda",
                          hintStyle: TextStyle(color: Colors.black26),
                          border: InputBorder.none,
                          icon: Icon(Icons.calendar_today)),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDates = await showDatePicker(
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                      primary: Colors.lightBlue,
                                      onPrimary: Colors.white,
                                      onSurface: Colors.black),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.blueAccent),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));

                        if (pickedDates != null) {
                          String formatedDates =
                          DateFormat('yyyy-MM-dd').format(pickedDates);
                          setState(() {
                            birthdatecontroller.text = formatedDates;
                          });
                        } else {}
                      },
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return "Tanggal Lahir tidak boleh kosong!";
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
                      controller:  addresscontroller,
                      decoration: const InputDecoration(
                          labelText: "Alamat",
                          hintText: "Silahkan Masukan Alamat Anda",
                          hintStyle: TextStyle(color: Colors.black26),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.location_city)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Alamat Tidak Boleh Kosong!";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                          border:
                          Border(bottom: BorderSide(color: Colors.black87))),
                      child: IntlPhoneField(
                        controller: phonenumberscontroller,
                        keyboardType: TextInputType.phone,
                        focusNode: FocusNode(),
                        dropdownTextStyle: const TextStyle(fontSize: 18),
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          hintText: "Silahkan Masukan Nomer Telpon anda",
                          hintStyle: TextStyle(color: Colors.black26),
                          border: InputBorder.none,
                        ),
                        initialCountryCode: 'ID',
                        validator: (value) {
                          if (value == null || value.completeNumber.isEmpty) {
                            return "Nomer Telpon tidak boleh kosong!";
                          }
                          return null;
                        },
                      )
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black87))),
                    child: TextFormField(
                      controller: emailcontroller,
                      decoration: const InputDecoration(
                          labelText: "Email",
                          hintText: "Silahkan Masukan Alamat Email anda",
                          hintStyle: TextStyle(color: Colors.black26),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.mail)),
                      validator: (value) {
                        //validator format email
                        bool inValidEmail = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);

                        if (value == null || value.isEmpty) {
                          return 'Alamt Email tidak boleh kosong!';
                        } else if (!inValidEmail) {
                          emailcontroller.clear();
                          return "Format Email Salah!";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          border:
                          Border(bottom: BorderSide(color: Colors.black87))),
                      child: DropdownButtonFormField<String>(
                        value: dropDownValues,
                        items: const [
                          DropdownMenuItem(
                              value: "",
                              child: Text(
                                "--Selected Posisi--",
                                style: TextStyle(color: Colors.black26),
                              )),
                          DropdownMenuItem(
                            value: "Engineer",
                            child: Text("Engineer"),
                          ),
                          DropdownMenuItem(
                            value: "Staff",
                            child: Text("Staff"),
                          ),
                          DropdownMenuItem(
                            value: "ADMIN",
                            child: Text("ADMIN"),
                          ),
                        ],
                        decoration: const InputDecoration(
                            border: InputBorder.none, prefixIcon: Icon(Icons.work)),
                        onChanged: (value) {
                          setState(() {
                            String passwordValue = functionKeys.generatedPassword();
                            dropDownValues = value!;
                            if (value.isNotEmpty) {
                              rolesController.text = "MEMBER";
                              passcontroller.text = passwordValue;
                              projectController.text = value;
                            } if (value.isNotEmpty) {
                              passcontroller.clear();
                              rolesController.clear();
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Select Project";
                          }
                          return null;
                        },
                      )
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black87))),
                    child: TextFormField(
                      controller: rolesController,
                      readOnly: true,
                      decoration: const InputDecoration(
                          labelText: "Roles",
                          hintText: "Please Insert Roles",
                          hintStyle: TextStyle(color: Colors.black26),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.people)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Roles Can not Empty!";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          border:
                          Border(bottom: BorderSide(color: Colors.black87))),
                      child: TextFormField(
                        obscureText: passHiding,
                        controller: passcontroller,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Password Akan terisi Otomatis',
                          hintStyle: TextStyle(color: Colors.black26),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password tidak boleh kosong!";
                          }
                          return null;
                        },
                      )
                  ),
                ],
              )
          )
        ]
    );
  }
}
