import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../Registrations/Functions/functionPassword.dart';
import '../Controller/key.dart';
import '../RevampRegistrations/MaterialRevampRegistration/dropdownlistposisi.dart';
import '../Services/gsheetscontrollers.dart';
import '../Services/gsheetsservices.dart';

class RegistrationsFieldapps extends StatefulWidget {
  const RegistrationsFieldapps({super.key});

  @override
  State<RegistrationsFieldapps> createState() =>
      _RegistrationsFieldappsState();
}

class _RegistrationsFieldappsState extends State<RegistrationsFieldapps> {
  bool passHiding = true;
  String dropDownValues = "";
  List<DropDownListPosisi> positionListings = [];
  bool isLoadingPosisi = true;

  final FocusNode phoneFocusNode = FocusNode();

  @override
  void initState() {
  super.initState();

  frontNameController.addListener(updateFullNames);
  backNameController.addListener(updateFullNames);
  dropDownValues = "";

  getListsPosisi();
  generateEmployeeID();
  }

  @override
  void dispose() {
    frontNameController.removeListener(updateFullNames);
    backNameController.removeListener(updateFullNames);
    phoneFocusNode.dispose();
    super.dispose();
  }

  Future<void> generateEmployeeID() async {
    try {
      final employeeID =
      await functionKeys.generatedEmployeeID();
      if (!mounted) return;
      setState(() {
        employeeIdController.text = employeeID;
      });
    } catch (e) {
      debugPrint(
        "Error generate EmployeeID: $e",
      );
    }
  }

  void updateFullNames() {
    final firstName = frontNameController.text.trim();
    final lastName = backNameController.text.trim();

    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      fullnamecontroller.text = "$firstName $lastName";
    } else if (firstName.isNotEmpty) {
      fullnamecontroller.text = firstName;
    } else if (lastName.isNotEmpty) {
      fullnamecontroller.text = lastName;
    } else {
      fullnamecontroller.clear();
    }
  }

  Future<void> getListsPosisi() async {
    try {
      if (mounted) {
        setState(() {
          isLoadingPosisi = true;
        });
      }

      await GSheetsServicesEmployees.init();

      final results = await getDataPosisi();

      if (!mounted) return;

      final List<DropDownListPosisi> newPositions =
      results.map((data) {
        return DropDownListPosisi(
          positionNames:
          data['Posisi']?.toString().trim() ?? '',
        );
      }).where((position) {
        return position.positionNames.isNotEmpty;
      }).toList();

      setState(() {
        positionListings = newPositions;
        isLoadingPosisi = false;
      });
    } catch (e) {
      debugPrint(
        'Error mengambil data posisi: $e',
      );
      if (!mounted) return;

      setState(() {
        positionListings = [];
        isLoadingPosisi = false;
      });
    }
  }

  Future<void> selectBirthDate() async {
    DateTime initialDate = DateTime.now();


    if (birthdatecontroller.text.trim().isNotEmpty) {
      try {
        initialDate = DateFormat('yyyy-MM-dd')
            .parseStrict(
          birthdatecontroller.text.trim(),
        );
      } catch (_) {
        initialDate = DateTime.now();
      }
    }

    if (initialDate.isBefore(DateTime(1950))) {
      initialDate = DateTime(1950);
    }

    if (initialDate.isAfter(DateTime.now())) {
      initialDate = DateTime.now();
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff2457A6),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),

            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff2457A6),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        birthdatecontroller.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Form(
          key: formRegistKeys,
          child: Column(
            children: <Widget>[
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
                  controller: frontNameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "Nama Depan",
                    hintText: "Silahkan Masukan Nama Depan Anda",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),

                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.people,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
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
                      color: Colors.black87,
                    ),
                  ),
                ),
                child: TextFormField(
                  controller: backNameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "Nama Belakang",
                    hintText: "Silahkan Masukan Nama Belakang Anda",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.people,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
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
                      color: Colors.black87,
                    ),
                  ),
                ),
                child: TextFormField(
                  controller: fullnamecontroller,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Nama Lengkap",
                    hintText: "Nama Lengkap Otomatis",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.people,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
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
                      color: Colors.black87,
                    ),
                  ),
                ),
                child: TextFormField(
                  controller: usernamecontroller,
                  decoration: const InputDecoration(
                    labelText: "UserName",
                    hintText: "Silahkan Masukan Username Anda",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.account_circle,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Field UserName tidak Boleh Kosong!";
                    }
                    return null;
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black87,
                    ),
                  ),
                ),
                child: TextFormField(
                  controller: birthdatecontroller,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Tanggal Lahir",
                    hintText: "Silahkan Masukan Tanggal Lahir Anda",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.calendar_today,
                    ),
                  ),
                  onTap: selectBirthDate,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return
                        "Tanggal Lahir tidak boleh kosong!";
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
                  controller: addresscontroller,
                  maxLines: 2,
                  textCapitalization:
                  TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: "Alamat",
                    hintText: "Silahkan Masukan Alamat Anda",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.location_city,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Alamat Tidak Boleh Kosong!";
                    }
                    return null;
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black87,
                    ),
                  ),
                ),
                child: IntlPhoneField(
                  controller: phonenumberscontroller,
                  focusNode: phoneFocusNode,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  dropdownTextStyle: const TextStyle(
                    fontSize: 18,
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Silahkan Masukan Nomer Telpon Anda",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),
                    border: InputBorder.none,
                  ),
                  initialCountryCode: 'ID',
                  validator: (value) {
                    if (value == null || value.completeNumber.trim().isEmpty) {
                      return "Nomer Telpon tidak boleh kosong!";
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
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Silahkan Masukan Alamat Email Anda",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.mail,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Alamat Email tidak boleh kosong!";
                    }
                    final email = value.trim();
                    final isValidEmail = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$',
                    ).hasMatch(email);
                    if (!isValidEmail) {
                      return "Format Email Salah!";
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

                child: isLoadingPosisi ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(
                      color: Color(0xff2457A6),
                    ),
                  ),
                ) : DropdownButtonFormField<String>(
                  isExpanded: true,

                  value: positionListings.any(
                        (posisi) =>
                    posisi.positionNames ==
                        positionscontrollers.text.trim(),
                  )
                      ? positionscontrollers.text.trim()
                      : null,

                  hint: const Text(
                    "-- Select Your Position --",
                    style: TextStyle(
                      color: Colors.black26,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  items: positionListings.map((posisi) {
                    return DropdownMenuItem<String>(
                      value: posisi.positionNames,
                      child: Text(
                        posisi.positionNames,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),

                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.work,
                    ),
                  ),

                  onChanged: (value) {
                    if (value == null || value.trim().isEmpty) {
                      positionscontrollers.clear();
                      rolesController.clear();
                      passcontroller.clear();
                      setState(() {});
                      return;
                    }

                    final selectedPosition = value.trim();
                    final passwordValue = functionKeys.generatedPassword();

                    positionscontrollers.text = selectedPosition;
                    rolesController.text = "ADMIN";
                    passcontroller.text = passwordValue;

                    setState(() {});
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
                  controller: rolesController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Roles",
                    hintText: "Roles Akan Terisi Otomatis",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.people,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Roles Cannot be Empty!";
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
                  controller: employeeIdController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "EmployeeID",
                    hintText: "EmployeeID Akan Terisi Otomatis",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.people,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "EmployeeID Cannot be Empty!";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}