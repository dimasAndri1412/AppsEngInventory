import 'package:appsenginventory/InventoryMasuk/inventorybuttons.dart';
import 'package:appsenginventory/InventoryMasuk/inventoryfield.dart';
import 'package:flutter/material.dart';

class InventoryWrapper extends StatefulWidget {
  const InventoryWrapper({super.key});

  @override
  State<InventoryWrapper> createState() => _InventoryWrapperState();
}

class _InventoryWrapperState extends State<InventoryWrapper> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 30,),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white),
            child: const SingleChildScrollView(
              child: InventoryFields(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const InventoryButtons()
        ],
      ),
    );
  }
}
