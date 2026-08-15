import 'package:appsenginventory/RevampRegistrations/revampregistrationbuttons.dart';
import 'package:appsenginventory/RevampRegistrations/revampregistrationfields.dart';
import 'package:flutter/material.dart';

class RevampRegistrationWrapper extends StatefulWidget {
  const RevampRegistrationWrapper({super.key});

  @override
  State<RevampRegistrationWrapper> createState() => _RevampRegistrationWrapperState();
}

class _RevampRegistrationWrapperState extends State<RevampRegistrationWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(

        children: <Widget>[
          const Expanded(
              child: RevampRegistrationFields()
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 87,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0),
                topLeft: Radius.circular(25.0),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 20.0,
                ),
              ],
            ),
            child: const RevampRegistrationButtons(),
          ),
        ],
      ),
    );
  }
}
