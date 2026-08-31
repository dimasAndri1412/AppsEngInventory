import 'package:appsenginventory/Controller/key.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ChangesPersonalSettingFields extends StatefulWidget {
  const ChangesPersonalSettingFields({super.key});

  @override
  State<ChangesPersonalSettingFields> createState() => _ChangesPersonalSettingFieldsState();
}

class _ChangesPersonalSettingFieldsState extends State<ChangesPersonalSettingFields> {

  bool passHide = true;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Form(
            key: changesPersonalSettingKey,
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
                    controller: changesPersonalSettingUserName,
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
                    controller: changesPersonalSettingEmail,
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
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: changesPersonalSettingAlamat,
                    decoration: const InputDecoration(
                      labelText: "Alamat",
                      hintText: "Silahkan Masukan Alamat Anda",
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
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                        border:
                        Border(bottom: BorderSide(color: Colors.black87))),
                    child: IntlPhoneField(
                      controller: changesPersonalSettingNomerTelpon,
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
              ],
            )
        )
      ],
    );
  }
}
