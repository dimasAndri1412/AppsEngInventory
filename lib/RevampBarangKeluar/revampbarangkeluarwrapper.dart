import 'package:appsenginventory/RevampBarangKeluar/revampbarangkeluarbuttons.dart';
import 'package:appsenginventory/RevampBarangKeluar/revampbarangkeluarfield.dart';
import 'package:appsenginventory/RevampBarangMasuk/revampbarangmasukfield.dart';
import 'package:flutter/material.dart';

class RevampBarangKeluarWrapper extends StatefulWidget {
  const RevampBarangKeluarWrapper({super.key});

  @override
  State<RevampBarangKeluarWrapper> createState() => _RevampBarangKeluarWrapperState();
}

class _RevampBarangKeluarWrapperState extends State<RevampBarangKeluarWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(

        children: <Widget>[
          const Expanded(
              child: RevampBarangKeluarField()
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
            child: const RevampBarangKeluarButtons(),
          ),
        ],
      ),
    );
  }
}
