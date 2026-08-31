import 'package:flutter/material.dart';

class ChangesPersonalSettingHeaders extends StatefulWidget {
  const ChangesPersonalSettingHeaders({super.key});

  @override
  State<ChangesPersonalSettingHeaders> createState() => _ChangesPersonalSettingHeadersState();
}

class _ChangesPersonalSettingHeadersState extends State<ChangesPersonalSettingHeaders> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              width: 250,
              child: Image.asset('lib/assets/images/Untitled-1.png',
              )
          )
        ],
      ),
    );
  }
}
