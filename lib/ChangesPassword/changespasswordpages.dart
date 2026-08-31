import 'package:appsenginventory/ChangesPassword/changespasswordbutton.dart';
import 'package:appsenginventory/ChangesPassword/changespasswordfield.dart';
import 'package:appsenginventory/ChangesPassword/changespasswordheaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangesPasswordPages extends StatefulWidget {
  const ChangesPasswordPages({super.key});

  @override
  State<ChangesPasswordPages> createState() => _ChangesPasswordPagesState();
}

class _ChangesPasswordPagesState extends State<ChangesPasswordPages> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldNavigateBack = (await _showConfirmDialog(context)) as bool;
        return shouldNavigateBack;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text (
              "PERUBAHAN PASSWORD",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
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
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 239, 242, 247),
              Color.fromARGB(255, 210, 220, 235),
              Color.fromARGB(255, 8, 36, 87),
            ],
          ),
        ),
        child: Transform.translate(
          offset: const Offset(0, -15),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const ChangesPasswordHeaders(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(2, 10),
                      ),
                    ],
                  ),
                  child: const SingleChildScrollView(
                    child: ChangesPasswordField(),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const ChangesPaswordButtons(),
            ],
          ),
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
