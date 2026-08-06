import 'package:appsenginventory/Controller/key.dart';
import 'package:flutter/material.dart';

class InventoryOutButtons extends StatelessWidget {
  const InventoryOutButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            if (BarangKeluarKey.currentState!.validate()) {

            } else {
              const snackBar = SnackBar(
                content: Text('Registrations Gagal!'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Container(
              height: 50,
              width: 250,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'SIMPAN',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )
          ),
        )
      ],
    );
  }
}
