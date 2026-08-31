import 'package:appsenginventory/ChangesPassword/changespasswordfield.dart';
import 'package:flutter/material.dart';


class ChangesPaswordWrapper extends StatefulWidget {
  const ChangesPaswordWrapper({super.key});

  @override
  State<ChangesPaswordWrapper> createState() => _ChangesPaswordWrapperState();
}

class _ChangesPaswordWrapperState extends State<ChangesPaswordWrapper> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60)),
            child: const SingleChildScrollView(
              child: ChangesPasswordField(),
            ),
          ),
        ],
      ),
    );
  }
}
