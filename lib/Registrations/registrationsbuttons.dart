import 'package:appsenginventory/Controller/key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../HomePages/homepagesmenus.dart';
import '../Services/gsheetscontrollers.dart';


class Registrationsbuttons extends StatefulWidget {
  const Registrationsbuttons({super.key});

  @override
  State<Registrationsbuttons> createState() => _Registrationsbuttons();
}

class _Registrationsbuttons extends State<Registrationsbuttons> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
         GestureDetector(
           onTap: isLoading
               ? null
               : () async {
             if (!formKeys.currentState!.validate()) {
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(
                   content: Text(
                     'Data belum lengkap. Silakan periksa kembali.',
                   ),
                 ),
               );
               return;
             }
             setState(() {
               isLoading = true;
             });
             try {
               final bool results = await validationEmailAndUserNameFirstLogin();
               if (!mounted) return;

               if (results) {
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(
                     content: Text(
                       'Data berhasil Tersimpan!',
                     ),
                     backgroundColor: Colors.green,
                   ),
                 );
                 Get.to(() => const Homepagesmenus());
               } else {
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(
                     content: Text(
                       'Data Tidak Berhasil Tersimpan!.',
                     ),
                     backgroundColor: Colors.red,
                   ),
                 );
               }
             } catch (e) {
               if (!mounted) return;

               ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                   content: Text(
                     'Terjadi kesalahan: $e',
                   ),
                   backgroundColor: Colors.red,
                 ),
               );

             } finally {
               if (mounted) {
                 setState(() {
                   isLoading = false;
                 });
               }
             }
           },
           child: Container(
               height: 50,
               width: 250,
               margin: const EdgeInsets.symmetric(horizontal: 50),
               decoration: BoxDecoration(
                 color: Colors.blueAccent,
                 borderRadius: BorderRadius.circular(10),
               ),
               child: const Center(
                 child: Text(
                   'SAVE',
                   style: TextStyle(
                       color: Colors.white,
                       fontSize: 20,
                       fontWeight: FontWeight.bold),
                 ),
               )
           ),
         )
      ],
    );
  }
}
