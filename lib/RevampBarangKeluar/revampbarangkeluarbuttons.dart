import 'package:appsenginventory/MenuPages/menupages.dart';
import 'package:appsenginventory/MenuPages/navigationmenu.dart';
import 'package:appsenginventory/Services/gsheetsinsertbarangkeluarcontrollers.dart';
import 'package:appsenginventory/Services/gsheetsupdatestockbaranglemari1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/key.dart';
import '../Services/gsheetsservices.dart';

class RevampBarangKeluarButtons extends StatefulWidget {
  const RevampBarangKeluarButtons({super.key});

  @override
  State<RevampBarangKeluarButtons> createState() =>
      _RevampBarangKeluarButtonsState();
}

class _RevampBarangKeluarButtonsState
    extends State<RevampBarangKeluarButtons> {
  Future<void> insertRegistBarangKeluar() async {
    try {
      if (GSheetsServicesEmployees.sheetsBarangKeluar == null) {
        await GSheetsServicesEmployees.init();
      }

      for (final controllers in revampBarangKeluarControllerss) {
        final insert = GsheetsInsertBarangKeluar()
          ..revampNomerUrutBarangKeluar = controllers["nomerUrutBarangKeluar"]?.text.trim()
          ..revampKodeBarangKeluar = controllers["kodeBarangKeluar"]?.text.trim()
          ..revampTanggalBarangKeluar = controllers["tanggalBarangKeluar"]?.text.trim()
          ..revampNamaBarangKeluar = controllers["namaBarangKeluar"]?.text.trim()
          ..revampJumlahBarangKeluar = controllers["jumlahBarangKeluar"]?.text.trim()
          ..revampSatuanBarangKeluar = controllers["satuanBarangKeluar"]?.text.trim()
          ..revampPICBarangKeluar = controllers["picBarangKeluar"]?.text.trim()
          ..revampLemariBarangKeluar = controllers["lemariBarangKeluar"]?.text.trim()
          ..revampKeteranganBarangKeluar = controllers["keteranganBarangKeluar"]?.text.trim();
        await insert.revampInsertBarangMasuk();

        final update = GsheetsUpdateBarangKeluar()
          ..revampKodeBarangKeluar = controllers["kodeBarangKeluar"]?.text.trim()
          ..revampNamaBarangKeluar = controllers["namaBarangKeluar"]?.text.trim()
          ..revampJumlahBarangKeluar = controllers["jumlahBarangKeluar"]?.text.trim()
          ..revampLemariBarangKeluar = controllers["lemariBarangKeluar"]?.text.trim();
        await update.revampUpdateStockBarang();
      }
    } catch (e) {
      debugPrint("ERROR: $e");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            if (!revampBarangKeluarkKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Gagal Menyimpan Data!")),
              );
              return;
            }
            await insertRegistBarangKeluar();
            for (final controllers in revampBarangKeluarControllerss) {
              for (final controller in controllers.values) {
                controller.clear();
              }
            }
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Data Berhasil Disimpan")),
            );
            //Get.to(() => const Menupages());
            Get.to(() => const NavigationMenuPages());
          },
          child: Container(
            height: 60,
            width: 300,
            margin: const EdgeInsets.symmetric(
              horizontal: 50,),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 8, 36, 87,),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'SIMPAN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}