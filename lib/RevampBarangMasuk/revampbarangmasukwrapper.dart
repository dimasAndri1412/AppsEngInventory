import 'package:appsenginventory/RevampBarangMasuk/revampbarangmasukbuttons.dart';
import 'package:appsenginventory/RevampBarangMasuk/revampbarangmasukfield.dart';
import 'package:flutter/material.dart';

class RevampBarangMasukWrapper extends StatefulWidget {
  const RevampBarangMasukWrapper({super.key});

  @override
  State<RevampBarangMasukWrapper> createState() => _RevampBarangMasukWrapperState();
}

class _RevampBarangMasukWrapperState extends State<RevampBarangMasukWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(

        children: <Widget>[
          const Expanded(
              child: RevampBarangMasukField()
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
            child: const RevampBarangMasukButtons(),
          ),
        ],
      ),
    );
  }
}
