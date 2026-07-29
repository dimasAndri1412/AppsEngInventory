import 'package:appsenginventory/Registrations/registrationsheaders.dart';
import 'package:appsenginventory/Registrations/registrationswrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationsMenu extends StatefulWidget {
  const RegistrationsMenu({super.key});

  @override
  State<RegistrationsMenu> createState() => _RegistrationsMenuState();
}

class _RegistrationsMenuState extends State<RegistrationsMenu> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldNavigateBack = (await _showConfirmDialog(context)) as bool;
        return shouldNavigateBack;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _showConfirmDialog(context);
            },
            icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
          ),
          backgroundColor: const Color.fromARGB(255, 8, 36, 87),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "REGISTRATIONS USER",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 8, 36, 87),     // Navy gelap
                Color.fromARGB(255, 26, 74, 138),   // Biru tua
                Color.fromARGB(255, 90, 149, 222),  // Biru muda
                Color.fromARGB(255, 255, 255, 255), // Putih
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              const Registrationsheaders(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: const SingleChildScrollView(
                    child: Registrationswrappers(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<Future<bool?>> _showConfirmDialog(BuildContext context) async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: const Icon(Icons.warning_amber,
                color: Colors.deepOrange),
            title: const Text(
              "Attentions!",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text("ARE YOU SURE WANT TO EXIT WITHOUT SAVE"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("NO",style:
                TextStyle(color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(onPressed: (){
                Get.back();
                //ctr_data().clear_func();
                Get.back();
              },
                child: const Text("YES",style:
                TextStyle(color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }
    );
  }
}
