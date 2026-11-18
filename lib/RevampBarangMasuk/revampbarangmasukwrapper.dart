import 'package:appsenginventory/RevampBarangMasuk/revampbarangmasukbuttons.dart';
import 'package:appsenginventory/RevampBarangMasuk/revampbarangmasukfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RevampBarangMasukWrapper extends StatefulWidget {
  const RevampBarangMasukWrapper({super.key});

  @override
  State<RevampBarangMasukWrapper> createState() =>
      _RevampBarangMasukWrapperState();
}

class _RevampBarangMasukWrapperState
    extends State<RevampBarangMasukWrapper> {
  final Map<String, XFile?> fotoBarangMasuk = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: RevampBarangMasukField(
              fotoBarangMasukMap: fotoBarangMasuk,
            ),
          ),
          Container(
            height: 87,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 20,
                ),
              ],
            ),
            child: RevampBarangMasukButtons(
              fotoBarangMasukMap: fotoBarangMasuk,
            ),
          ),
        ],
      ),
    );
  }
}