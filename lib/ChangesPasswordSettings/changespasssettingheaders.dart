import 'package:flutter/material.dart';

class ChangessPassSettingHeaders extends StatefulWidget {
  const ChangessPassSettingHeaders({super.key});

  @override
  State<ChangessPassSettingHeaders> createState() => _ChangessPassSettingHeadersState();
}

class _ChangessPassSettingHeadersState extends State<ChangessPassSettingHeaders> {
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
