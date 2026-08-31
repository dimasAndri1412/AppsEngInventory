import 'package:appsenginventory/ForgotPassword/forgotpasswordbuttons.dart';
import 'package:appsenginventory/ForgotPassword/forgotpasswordheaders.dart';
import 'package:appsenginventory/ForgotPassword/forgotpasswordwrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPages extends StatefulWidget {
  const ForgotPasswordPages({super.key});

  @override
  State<ForgotPasswordPages> createState() => _ForgotPasswordPagesState();
}

class _ForgotPasswordPagesState extends State<ForgotPasswordPages> {
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
            "FORGOT PASSWORD",
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
                const ForgotPasswordHeaders(),
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
                      child: ForgotPasswordWrapper(),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const ForgotPasswordButtons(),
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
