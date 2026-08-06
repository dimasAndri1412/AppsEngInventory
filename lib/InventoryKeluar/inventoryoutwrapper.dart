import 'package:appsenginventory/InventoryKeluar/inventoryoutbuttons.dart';
import 'package:appsenginventory/InventoryKeluar/inventoryoutfield.dart';
import 'package:flutter/material.dart';

class InventoryOutWrapper extends StatefulWidget {
  const InventoryOutWrapper({super.key});

  @override
  State<InventoryOutWrapper> createState() => _InventoryOutWrapperState();
}

class _InventoryOutWrapperState extends State<InventoryOutWrapper> {
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
              child: InventoryOutFields(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const InventoryOutButtons()
        ],
      ),
    );
  }
}
