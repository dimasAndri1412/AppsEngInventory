import 'package:appsenginventory/ChangesPersonalSettings/changespersonalsettingfields.dart';
import 'package:flutter/material.dart';

class ChangesPersonalSettingWrappers extends StatefulWidget {
  const ChangesPersonalSettingWrappers({super.key});

  @override
  State<ChangesPersonalSettingWrappers> createState() => _ChangesPersonalSettingWrappersState();
}

class _ChangesPersonalSettingWrappersState extends State<ChangesPersonalSettingWrappers> {
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
              child: ChangesPersonalSettingFields(),
            ),
          ),
        ],
      ),
    );
  }
}
