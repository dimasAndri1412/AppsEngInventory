import 'package:appsenginventory/Login/loginpagebuttons.dart';
import 'package:appsenginventory/Login/loginpageheaders.dart';
import 'package:appsenginventory/Login/loginpagewrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Registrations/registrationsmenu.dart';

class Loginpagemenus extends StatefulWidget {
  const Loginpagemenus({super.key});

  @override
  State<Loginpagemenus> createState() => _LoginpagemenusState();
}

class _LoginpagemenusState extends State<Loginpagemenus> {
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
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 255, 255, 255), // Putih
                Color.fromARGB(255, 239, 242, 247), // Abu-abu sangat muda
                Color.fromARGB(255, 210, 220, 235), // Abu kebiruan muda
                Color.fromARGB(255, 8, 36, 87),     // Navy gelap
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Loginpageheaders(),
              Transform.translate(
                  offset: const Offset(0, -60),
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          margin: const EdgeInsets.symmetric(),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(60),
                                  topRight: Radius.circular(60),
                                  bottomLeft: Radius.circular(60),
                                  bottomRight: Radius.circular(60)
                              ),
                              boxShadow: [BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 15,
                                  offset: Offset(2, 10)
                              )]
                          ),
                          child: const SingleChildScrollView(
                            child: Loginpagewrappers(),
                          ),
                        ),
                      )
                  ),
              ),
              const Loginpagebuttons(),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Jika Belum Memiliki Account Klik?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.offAll(() => const RegistrationsMenu());
                      },
                      child: Text(
                        'Daftar!',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      )
                  )
                ],

              )
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
