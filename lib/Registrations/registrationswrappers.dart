import 'package:appsenginventory/Registrations/registrationsFields.dart';
import 'package:appsenginventory/Registrations/registrationsbuttons.dart';
import 'package:flutter/material.dart';

class Registrationswrappers extends StatefulWidget {
  const Registrationswrappers({super.key});

  @override
  State<Registrationswrappers> createState() => _RegistrationswrappersState();
}

class _RegistrationswrappersState extends State<Registrationswrappers> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 30,),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(60)),
            child: const SingleChildScrollView(
              child: RegistrationsFieldapps(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Registrationsbuttons()
        ],
      ),
    );
  }
}
