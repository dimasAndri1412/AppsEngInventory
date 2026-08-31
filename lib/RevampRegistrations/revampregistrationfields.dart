  import 'package:appsenginventory/Registrations/Functions/functionPassword.dart';
  import 'package:appsenginventory/RevampRegistrations/MaterialRevampRegistration/dropdownlistposisi.dart';
  import 'package:appsenginventory/RevampRegistrations/MaterialRevampRegistration/funcntions.dart';
  import 'package:appsenginventory/Services/gsheetscontrollers.dart';
  import 'package:appsenginventory/Services/gsheetsservices.dart';
  import 'package:flutter/material.dart';
  import 'package:intl/intl.dart';
  import 'package:intl_phone_field/intl_phone_field.dart';

  import '../Controller/key.dart';

  class RevampRegistrationFields extends StatefulWidget {
    const RevampRegistrationFields({super.key});

    @override
    State<RevampRegistrationFields> createState() => _RevampRegistrationFieldsState();
  }
  class _RevampRegistrationFieldsState extends State<RevampRegistrationFields> {

    List<DropDownListPosisi> positionListings = [];

    bool isLoadingPosisi = true;

    Map<String, TextEditingController> createRegistrationControllers() {
      final int registrationNumber =
          revampResgistControllerss.length + 1;

      final String employeeId =
      Functions.generatedEmployeeID(registrationNumber);

      return {
        "employeeIdController": TextEditingController(text: employeeId),
        "frontNameController": TextEditingController(),
        "backNameController": TextEditingController(),
        "fullnamecontroller": TextEditingController(),
        "usernamecontroller": TextEditingController(),
        "birthdatecontroller": TextEditingController(),
        "addresscontroller": TextEditingController(),
        "emailcontroller": TextEditingController(),
        "phonenumberscontroller": TextEditingController(),
        "rolesController": TextEditingController(),
        "passcontroller": TextEditingController(),
        "PositionController": TextEditingController(),
      };
    }

    void disposeRegistrationControllers(Map<String, TextEditingController> controllers) {
      for (final controller in controllers.values) {
        controller.dispose();
      }
    }

    Future<void> getListsPosisi() async {
      try {
        await GSheetsServicesEmployees.init();

        final results = await getDataPosisi();

        if (!mounted) return;

        final List<DropDownListPosisi> newPositions =
        results.map((data) {
          return DropDownListPosisi(
            positionNames: data['Posisi'] ?? '',
          );
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

    void addNewsContainers() {
      final controllers = createRegistrationControllers();
      if (!mounted) {
        disposeRegistrationControllers(controllers);
        return;
      }
      setState(() {
        revampResgistControllerss.add(
          controllers,
        );
      });
    }

    void removeRegistContainer() {
      if (revampResgistControllerss.length <= 1) {
        return;
      }
      final controllers = revampResgistControllerss.removeLast();
      disposeRegistrationControllers(
        controllers,
      );

      if (mounted) {
        setState(() {});
      }
    }

    Widget buildsRegistContainers(Map<String, TextEditingController> controllersss, int index) {

      final String currentPosition = controllersss["PositionController"]?.text ?? '';
      final bool positionExists = positionListings.any(
            (posisi) => posisi.positionNames == currentPosition,
      );

      return Container(
        key: ValueKey(
          controllersss["employeeIdController"]?.text ?? index,
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 10,
              color: Colors.black26,
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.center,
          children: [
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
                controller:
                controllersss["employeeIdController"],
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Employee ID",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.badge),
                ),
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
                controller:
                controllersss["frontNameController"],
                decoration: const InputDecoration(
                  labelText: "Nama Depan",
                  hintText: "Silahkan Masukan Nama Depan Anda",
                  hintStyle: TextStyle(
                    color: Colors.black26,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.people),
                ),
                onChanged: (value) {
                  final frontName = value.trim();
                  final backName = controllersss["backNameController"]?.text.trim() ?? '';
                  final fullName = "$frontName $backName".trim();
                  controllersss["fullnamecontroller"]?.text = fullName;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return
                      "Nama Depan tidak Boleh Kosong!";
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
                controller: controllersss["backNameController"],
                decoration: const InputDecoration(
                  labelText: "Nama Belakang",
                  hintText: "Silahkan Masukan Nama Belakang Anda",
                  hintStyle: TextStyle(
                    color: Colors.black26,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.people),
                ),
                onChanged: (value) {
                  final backName = value.trim();
                  final frontName = controllersss["frontNameController"]?.text.trim() ?? '';
                  final fullName = "$frontName $backName".trim();
                  controllersss["fullnamecontroller"]?.text = fullName;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return
                      "Nama Belakang Anda Tidak Boleh Kosong!";
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
                controller: controllersss["usernamecontroller"],
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
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black87,
                  ),
                ),
              ),
              child: TextFormField(
                controller: controllersss["birthdatecontroller"],
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Tanggal Lahir",
                  hintText: "Silahkan Masukan Tanggal Lahir Anda",
                  hintStyle: TextStyle(
                    color: Colors.black26,
                  ),
                  border: InputBorder.none,
                  icon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),

                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Colors.lightBlue,
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                        ),
                        child:
                        child!,
                      );
                    },
                  );
                  if (pickedDate == null) {
                    return;
                  }
                  if (!mounted) {
                    return;
                  }
                  controllersss["birthdatecontroller"]?.text = DateFormat('yyyy-MM-dd',).format(pickedDate,);
                  setState(() {});
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return
                      "BirthDate Can Not Empty!";
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
                controller: controllersss["addresscontroller"],
                decoration: const InputDecoration(
                  labelText: "Alamat",
                  hintText: "Silahkan Masukan Alamat Anda",
                  hintStyle: TextStyle(
                    color: Colors.black26,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.location_city),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return
                      "Alamat Anda Tidak Boleh Kosong!";
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
                controller: controllersss["phonenumberscontroller"],
                keyboardType: TextInputType.phone,
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
                controller:
                controllersss["emailcontroller"],
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
              child: isLoadingPosisi ? const Center(
                child: Padding(padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),),
              )
                  : DropdownButtonFormField<String>(
                value: positionExists
                    ? currentPosition
                    : null,
                hint: const Text(
                  "-- Select Your Position --",
                  style: TextStyle(
                    color: Colors.black26,
                  ),
                ),
                items: positionListings.map((posisi) {
                    return DropdownMenuItem<String>(value: posisi.positionNames,
                      child: Text(
                        posisi.positionNames,
                      ),
                    );
                  },
                ).toList(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.work),
                ),

                onChanged: (value) {
                  if (!mounted) {
                    return;
                  }
                  if (value != null && value.isNotEmpty) {
                    final passwordValue = functionKeys.generatedPassword();
                    controllersss["PositionController"]?.text = value;
                    controllersss["rolesController"]?.text = "MEMBER";
                    controllersss["passcontroller"]?.text = passwordValue;

                  } else {
                    controllersss["PositionController"]?.clear();
                    controllersss["rolesController"]?.clear();
                    controllersss["passcontroller"]?.clear();
                  }
                  setState(() {});
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select a position";
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
                controller: controllersss["rolesController"],
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Roles",
                  hintText: "Silahkan Masukan Roles Anda",
                  hintStyle: TextStyle(color: Colors.black26,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.people),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Roles Tidak Boleh Kosong!";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.end,
              children: [
                const Flexible(
                  child: Text(
                    "Add Other Registrations",
                    style: TextStyle(
                      color:
                      Color.fromARGB(255, 8, 36, 87,
                      ),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 5),
                FloatingActionButton(
                  onPressed: addNewsContainers,
                  heroTag: "add_$index",
                  backgroundColor: const Color.fromARGB(255, 8, 36, 87,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 5),
                FloatingActionButton(
                  onPressed: revampResgistControllerss
                      .length > 1 ? removeRegistContainer
                      : null,
                  heroTag: "delete_$index",
                  backgroundColor: revampResgistControllerss
                      .length > 1
                      ? Colors.red
                      : Colors.grey,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // ============================================================
    // INIT STATE
    // ============================================================

    @override
    void initState() {
      super.initState();
      for (final controllers in revampResgistControllerss) {
        for (final controller in controllers.values) {
          controller.dispose();
        }
      }
      revampResgistControllerss.clear();
      revampResgistControllerss.add(createRegistrationControllers(),
      );

      getListsPosisi();
    }

    @override
    void dispose() {
      for (final controllers in revampResgistControllerss) {
        for (final controller
        in controllers.values) {
          controller.dispose();
        }
      }
      revampResgistControllerss.clear();
      super.dispose();
    }

    // ============================================================
    // BUILD
    // ============================================================

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Form(
          key: revampRegistrationsKey,
          child:
          SingleChildScrollView(
            child: Column(
              children: [
                ...revampResgistControllerss.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final controllers = entry.value;
                    return buildsRegistContainers(
                      controllers,
                      index,
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }