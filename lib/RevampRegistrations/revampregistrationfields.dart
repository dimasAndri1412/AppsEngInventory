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
  String? dropDownListPosisi;
  List<Widget> addtionalRegistContainers = [];
  List<DropDownListPosisi> positionListings = [];
  bool isLoadingPosisi = true;

  Map<String, TextEditingController> createRegistrationControllers() {

    final int registrationNumber = revampResgistControllerss.length + 1;
    final String employeeId =
    Functions.generatedEmployeeID(
      registrationNumber,
    );

    return {"employeeIdController": TextEditingController(text: employeeId,),

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

  Future<void> getListsPosisi() async {
    try {
      await GSheetsServicesEmployees.init();

      final results = await getDataPosisi();

      if (!mounted) return;

      setState(() {
        positionListings = results.map((data) {
          return DropDownListPosisi(
            positionNames: data['Posisi'] ?? '',
          );
        }).toList();

        isLoadingPosisi = false;
      });

    } catch (e) {
      debugPrint(
        'Error mengambil data posisi: $e',
      );

      if (!mounted) return;

      setState(() {
        isLoadingPosisi = false;
        positionListings = [];
      });
    }
  }

  void removeRegistContainer() {
    if (revampResgistControllerss.length <= 1) {
      return;
    }
    setState(() {
      final controllers =
          revampResgistControllerss.last;
      for (var controller in controllers.values) {
        controller.dispose();
      }
      revampResgistControllerss.removeLast();
      if (addtionalRegistContainers.isNotEmpty) {
        addtionalRegistContainers.removeLast();
      }
    });
  }

  @override
  void dispose() {
    for (var controllers in revampResgistControllerss
    ) {
      for (var controller in controllers.values) {
        controller.dispose();
      }
    }
    phoneFocusNode.dispose();
    super.dispose();
  }


  void addNewsContainers() {
    setState(() {
      final controllersss =
      createRegistrationControllers();

      revampResgistControllerss.add(
        controllersss,
      );
      addtionalRegistContainers.add(
        buildsRegistContainers(
          controllersss,
        ),
      );
    });
  }

  Widget startBuildRegistContainers(Map<String, TextEditingController> controlersss) {
    return Container(
      key: UniqueKey(),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Add Registration",
                style: TextStyle(
                    color: Color.fromARGB(255, 8, 36, 87),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                onPressed: addNewsContainers,
                heroTag: null,
                backgroundColor: const Color.fromARGB(255, 8, 36, 87),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildsRegistContainers(Map<String, TextEditingController> controllersss) {
    return Container(
      key: UniqueKey(),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black87)
                )
            ),
            child: TextFormField(
              controller: controllersss["frontNameController"],

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
                  if (backName.isNotEmpty) {
                    controllersss["fullnamecontroller"]?.text = "$frontName $backName";
                  }
                },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Nama Depan tidak Boleh Kosong!";
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
                        color: Colors.black87)
                )
            ),
            child: TextFormField(
              controller:
              controllersss["backNameController"],

              decoration: const InputDecoration(
                labelText: "Nama Belakang",
                hintText:
                "Silahkan Masukan Nama Belakang Anda",
                hintStyle: TextStyle(
                  color: Colors.black26,
                ),
                border: InputBorder.none,
                prefixIcon:
                Icon(Icons.people),
              ),
              onChanged: (value) {
                final String backName = value.trim();
                final String frontName = controllersss["frontNameController"]?.text.trim() ?? '';

                if (backName.isNotEmpty) {
                  controllersss["fullnamecontroller"]?.text = "$frontName $backName";
                  debugPrint(
                    "FULL NAME: $frontName $backName",
                  );
                }

                else {
                  controllersss["fullnamecontroller"]?.clear();
                  debugPrint(
                    "BackName kosong -> FullName dikosongkan",
                  );
                }
              },
              validator: (value) {
                if (value == null ||
                    value.isEmpty) {
                  return "Nama Belakang Anda Tidak Boleh Kosong!";
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

            child: TextFormField(controller: controllersss["fullnamecontroller"],
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Full Name",
                hintText: "Nama lengkap",
                hintStyle: TextStyle(
                  color: Colors.black26,
                ),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.person),
              ),

              validator: (value) {
                if (value == null ||
                    value.isEmpty) {
                  return "Full Name tidak boleh kosong!";
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
                        color: Colors.black87)
                )
            ),
            child: TextFormField(
              controller: controllersss["usernamecontroller"],
              decoration: const InputDecoration(
                  labelText: "User Name",
                  hintText: "Silahkan Masukan User Name Anda",
                  hintStyle: TextStyle(color: Colors.black26),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.people)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "User Name Anda Tidak Boleh Kosong!";
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
                        color: Colors.black87)
                )
            ),
            child: TextFormField(
              controller: controllersss["birthdatecontroller"],
              decoration: const InputDecoration(
                  labelText: "Tanggal Lahir",
                  hintText: "Silahkan Masukan Tanggal Lahir andae",
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
                    controllersss["birthdatecontroller"]?.text = formatedDates;
                  });
                } else {}
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "BirtDate Can Not Empty!";
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
              controller: controllersss["addresscontroller"],
              decoration: const InputDecoration(
                  labelText: "Alamat",
                  hintText: "Silahkan Masukan Alamat Anda",
                  hintStyle: TextStyle(color: Colors.black26),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.location_city)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Alamat Anda Tidak Boleh Kosong!";
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
                controller: controllersss["phonenumberscontroller"],
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
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black87)
                )
            ),
            child: TextFormField(
              controller: controllersss["emailcontroller"],
              decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Silahkan Masukan Email Anda",
                  hintStyle: TextStyle(color: Colors.black26),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.mail)),
              validator: (value) {
                //validator format email
                bool inValidEmail = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value!);

                if (value.isEmpty) {
                  return 'Email Tidak Boleh Kosong!';
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
              border: Border(
                bottom: BorderSide(
                  color: Colors.black87,
                ),
              ),
            ),
            child: isLoadingPosisi ? const Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ),
            ) : DropdownButtonFormField<String>(
              value: positionListings
                  .map(
                    (posisi) => posisi.positionNames,
              )
                  .contains(controllersss["PositionController"]?.text,
              )
                  ? controllersss["PositionController"]?.text
                  : null,

              hint: const Text(
                "-- Select Your Position --",
                style: TextStyle(
                  color: Colors.black26,
                ),
              ),

              items: positionListings.map((posisi) {
                return DropdownMenuItem<String>(
                  value: posisi.positionNames,
                  child: Text(
                    posisi.positionNames,
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
                setState(() {
                  dropDownListPosisi = value;

                  if (value != null && value.isNotEmpty) {
                    final passwordValue =
                    functionKeys.generatedPassword();
                    controllersss["PositionController"]?.text = value;
                    controllersss["rolesController"]?.text = "MEMBER";
                    controllersss["passcontroller"]?.text = passwordValue;
                  } else {
                    controllersss["PositionController"]?.clear();
                    controllersss["rolesController"]?.clear();
                    controllersss["passcontroller"]?.clear();
                  }
                });
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
                        color: Colors.black87)
                )
            ),
            child: TextFormField(
              controller: controllersss["rolesController"],
              readOnly: true,
              decoration: const InputDecoration(
                  labelText: "Roles",
                  hintText: "Silahkan Masukan Roles Anda",
                  hintStyle: TextStyle(color: Colors.black26),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.people)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Roles Tidak Boleh Kosong!";
                }
                return null;
              },
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Add Other Registrations",
                style: TextStyle(
                    color: Color.fromARGB(255, 8, 36, 87),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5),
              FloatingActionButton(
                onPressed: addNewsContainers,
                heroTag: null,
                backgroundColor: const Color.fromARGB(255, 8, 36, 87),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width:5),
              FloatingActionButton(
                onPressed: removeRegistContainer,
                heroTag: null,
                backgroundColor: Colors.red,
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

  @override
  void initState() {
    super.initState();
    final controllers = createRegistrationControllers();
    revampResgistControllerss.add(
      controllers,
    );
    getListsPosisi();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: revampRegistrationsKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (revampResgistControllerss.isNotEmpty)
                buildsRegistContainers(
                  revampResgistControllerss.first,
                ),
              ...addtionalRegistContainers,
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
