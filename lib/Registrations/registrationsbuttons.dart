import 'package:appsenginventory/Controller/key.dart';
import 'package:flutter/material.dart';


class Registrationsbuttons extends StatefulWidget {
  const Registrationsbuttons({super.key});

  @override
  State<Registrationsbuttons> createState() => _Registrationsbuttons();
}

class _Registrationsbuttons extends State<Registrationsbuttons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
         GestureDetector(
           onTap: (){
             if (formKeys.currentState!.validate()) {

             } else {
               const snackBar = SnackBar(
                 content: Text('Registrations Gagal!'),
               );
               ScaffoldMessenger.of(context).showSnackBar(snackBar);
             }
           },
           child: Container(
               height: 50,
               width: 100,
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
                       fontSize: 15,
                       fontWeight: FontWeight.bold),
                 ),
               )
           ),
         )
      ],
    );
  }
}
