import 'package:appsenginventory/RevampRegistrations/revampregistrationwrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RevampRegistrationsPages extends StatefulWidget {
  const RevampRegistrationsPages({super.key});

  @override
  State<RevampRegistrationsPages> createState() => _RevampRegistrationsPagesState();
}

class _RevampRegistrationsPagesState extends State<RevampRegistrationsPages> {
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
            "PERSONAL INFORMATION",
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
                  Color.fromARGB(255, 255, 255, 255), // Putih
                  Color.fromARGB(255, 239, 242, 247), // Abu-abu sangat muda
                  Color.fromARGB(255, 210, 220, 235),
                  Color.fromARGB(255, 98, 171, 232),// Abu kebiruan muda
                  Color.fromARGB(255, 8, 36, 87),
                ],
              ),
            ),
            child: const RevampRegistrationWrapper()
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
              "PERHATIAN!",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text("APAKAH KAMU YAKIN INGIN KELUAR?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("TIDAK",style:
                TextStyle(color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(onPressed: (){
                Get.back();
                Get.back();
              },
                child: const Text("YA!",style:
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
