import 'package:appsenginventory/ChangesPasswordSettings/changespasssettingfields.dart';
import 'package:flutter/material.dart';

class ChangesPassSettingWrappers extends StatefulWidget {
  const ChangesPassSettingWrappers({super.key});

  @override
  State<ChangesPassSettingWrappers> createState() => _ChangesPassSettingWrappersState();
}

class _ChangesPassSettingWrappersState extends State<ChangesPassSettingWrappers> {
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
              child: ChangesPassSettingsFields(),
            ),
          ),
        ],
      ),
    );
  }
}
