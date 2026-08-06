import 'package:appsenginventory/Controller/key.dart';
import 'package:flutter/material.dart';

class InventoryOutFields extends StatefulWidget {
  const InventoryOutFields({super.key});

  @override
  State<InventoryOutFields> createState() => _InventoryOutFieldsState();
}

class _InventoryOutFieldsState extends State<InventoryOutFields> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        TextFormField(
          controller: TanggalBarangKeluarContorller,
          decoration: InputDecoration(
            labelText: "Tanggal Barang Keluar",
            labelStyle: TextStyle(
                color: Colors.black
            ),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Tanggal Barang Keluar tidak Boleh Kosong!";
            }
            return null;
          },
        ),
        SizedBox(
          height: 15,
        ),
        DropdownButtonFormField(
          decoration: const InputDecoration(
            labelText: "Barang",
            labelStyle: TextStyle(
                color: Colors.black
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: "Laptop",
              child: Text("Laptop"),
            ),
            DropdownMenuItem(
              value: "Mouse",
              child: Text("Mouse"),
            ),
          ],
          onChanged: (v){},
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: JumlahBarangKeluarContorller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Jumlah Barang Kelaur",
            labelStyle: TextStyle(
                color: Colors.black
            ),
            suffixText: "Pcs",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Jumlah tidak Boleh Kosong!";
            }
            return null;
          },
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: SuplierBarangKeluarContorller,
          decoration: const InputDecoration(
            labelText: "Supplier",
            labelStyle: TextStyle(
                color: Colors.black
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Supplier tidak Boleh Kosong!";
            }
            return null;
          },
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: PICBarangKeluarContorller,
          decoration: const InputDecoration(
            labelText: "PIC",
            labelStyle: TextStyle(
                color: Colors.black
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "PIC tidak Boleh Kosong!";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),

        TextFormField(
          controller: KeteranganBarangKeluarContorller,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: "Keterangan",
            labelStyle: TextStyle(
                color: Colors.black
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Keterangan tidak Boleh Kosong!";
            }
            return null;
          },
        )
      ],
    );
  }
}
