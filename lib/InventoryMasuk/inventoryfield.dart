import 'package:appsenginventory/Controller/key.dart';
import 'package:flutter/material.dart';

class InventoryFields extends StatefulWidget {
  const InventoryFields({super.key});

  @override
  State<InventoryFields> createState() => _InventoryFieldsState();
}

class _InventoryFieldsState extends State<InventoryFields> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        TextFormField(
          controller: TanggalBarangMasukContorller,
          decoration: InputDecoration(
            labelText: "Tanggal BarangMasuk",
            labelStyle: TextStyle(
              color: Colors.black
            ),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
                return "Tanggal BarangMasuk tidak Boleh Kosong!";
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
          controller: JumlahBarangMasukContorller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Jumlah Barang Masuk",
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
          controller: SuplierBarangMasukContorller,
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
          controller: PICBarangMasukContorller,
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
          controller: KeteranganBarangMasukContorller,
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
