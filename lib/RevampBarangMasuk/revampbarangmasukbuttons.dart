import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/Services/gsheetsinsertbarangmasuklemari2.dart';
import 'package:appsenginventory/Services/gsheetsinsertbarangmasuklemari3.dart';
import 'package:appsenginventory/Services/gsheetstinsertbarangmasuklemari1.dart';
import 'package:appsenginventory/Services/gsheetsinsertbarangmasukcontrollers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../HomePages/homepagesmenus.dart';
import '../Services/gsheetsservices.dart';

class RevampBarangMasukButtons extends StatefulWidget {
  const RevampBarangMasukButtons({super.key});

  @override
  State<RevampBarangMasukButtons> createState() => _RevampBarangMasukButtonsState();
}

class _RevampBarangMasukButtonsState extends State<RevampBarangMasukButtons> {

  Future<void> insertRegistBarangMasuk() async {
    try {
      if (GSheetsServicesEmployees.sheetsBarangMasuk == null) {
        debugPrint("Google Sheets belum diinisialisasi.",);
        await GSheetsServicesEmployees.init();
      }
      if (GSheetsServicesEmployees.sheetsBarangMasuk == null) {
        throw Exception("Google Sheets gagal diinisialisasi.",
        );
      }
      if (revampBarangMasukControllerss.isEmpty) {
        throw Exception("Tidak ada data registration.",
        );
      }

      for ( int index = 0; index < revampBarangMasukControllerss.length; index++
      ) {
        final controllers = revampBarangMasukControllerss[index];
        final nomerUrutBarangMasuk = controllers["nomerUrut"]?.text.trim() ?? '';
        final kodeBarangMasuk = controllers["kodeBarangMasuk"]?.text.trim() ?? '';
        final tanggalBarangMasuk = controllers["tanggalBarangMasuk"]?.text.trim() ?? '';
        final namaBarangMasuk = controllers["namaBarangMasuk"]?.text.trim() ?? '';
        final jumlahBarangMasuk = controllers["jumlahBarangMasuk"]?.text.trim() ?? '';
        final satuanBarangMasuk = controllers["satuanBarangController"]?.text.trim() ?? '';
        final picBarangMasuk = controllers["picBarangMasuk"]?.text.trim() ?? '';
        final lemariBarangMasuk = controllers["lemariBarangMasuk"]?.text.trim() ?? '';
        final keteranganBarangMasuk = controllers["keteranganBarangMasuk"]?.text.trim() ?? '';
        final insertController = GsheetsInsertBarangMasuk();

        insertController.revampNomerUrutBarangMasuk = nomerUrutBarangMasuk;
        insertController.revampKodeBarangMasuk = kodeBarangMasuk;
        insertController.revampTanggalBarangMasuk = tanggalBarangMasuk;
        insertController.revampNamaBarangMasuk = namaBarangMasuk;
        insertController.revampJumlahBarangMasuk = jumlahBarangMasuk;
        insertController.revampSatuanBarangMasuk = satuanBarangMasuk;
        insertController.revampPICBarangMasuk = picBarangMasuk;
        insertController.revampLemariBarangMasuk = lemariBarangMasuk;
        insertController.revampKeteranganBarangMasuk = keteranganBarangMasuk;
        await insertController.revampInsertBarangMasuk();
      }
    } catch (e) {
      debugPrint("ERROR: $e",);
      rethrow;
    }
  }

  Future<void> insertRegistBarangMasukLemari1(
      Map<String, TextEditingController> controllers) async {
    try {
      if (GSheetsServicesEmployees.sheetsLemari1 == null) {
        await GSheetsServicesEmployees.init();
      }

      final insertControllerLemari1 = GsheetsBarangMasukLemari1();
      insertControllerLemari1.revampNomerUrutBarangMasuk = controllers["nomerUrutLemari1"]?.text.trim() ?? '';
      insertControllerLemari1.revampKodeBarangMasuk = controllers["kodeBarangMasuk"]?.text.trim() ?? '';
      insertControllerLemari1.revampNamaBarangMasuk = controllers["namaBarangMasuk"]?.text.trim() ?? '';
      insertControllerLemari1.revampSatuanBarangMasuk = controllers["satuanBarangController"]?.text.trim() ?? '';
      insertControllerLemari1.revampJumlahBarangMasuk = controllers["jumlahBarangMasuk"]?.text.trim() ?? '';
      insertControllerLemari1.revampTotalBarangMasuk = controllers["totalBarangMasukLemari1"]?.text.trim() ?? '';
      insertControllerLemari1.revampTotalBarangKeluar = controllers["totalBarangKeluarLemari1"]?.text.trim() ?? '';
      insertControllerLemari1.revampJumlahAkhirBarangMasuk = controllers["totalJumlahAkhirLemari1"]?.text.trim() ?? '';
      insertControllerLemari1.revampJumlahMinimunBarangMasuk = controllers["jumlahMinimumBarangMasukLemari1"]?.text.trim() ?? '';
      insertControllerLemari1.revampStatusBarangMasuk = controllers["statusBarangMasukLemari1"]?.text.trim() ?? '';
      await insertControllerLemari1.revampInsertBarangMasukLemari1();
    } catch (e) {
      debugPrint("ERROR LEMARI1: $e");
      rethrow;
    }
  }

  Future<void> insertRegistBarangMasukLemari2(
      Map<String, TextEditingController> controllers) async {
    try {
      if (GSheetsServicesEmployees.sheetsLemari2 == null) {
        await GSheetsServicesEmployees.init();
      }

      final insertControllerLemari1 = GsheetsBarangMasukLemari2();
      insertControllerLemari1.revampNomerUrutBarangMasuk = controllers["nomerUrutLemari2"]?.text.trim() ?? '';
      insertControllerLemari1.revampKodeBarangMasuk = controllers["kodeBarangMasuk"]?.text.trim() ?? '';
      insertControllerLemari1.revampNamaBarangMasuk = controllers["namaBarangMasuk"]?.text.trim() ?? '';
      insertControllerLemari1.revampJumlahBarangMasuk = controllers["jumlahBarangMasuk"]?.text.trim() ?? '';
      insertControllerLemari1.revampSatuanBarangMasuk = controllers["satuanBarangController"]?.text.trim() ?? '';
      insertControllerLemari1.revampTotalBarangMasuk = controllers["totalBarangMasukLemari2"]?.text.trim() ?? '';
      insertControllerLemari1.revampTotalBarangKeluar = controllers["totalBarangKeluarLemari2"]?.text.trim() ?? '';
      insertControllerLemari1.revampJumlahAkhirBarangMasuk = controllers["totalJumlahAkhirLemari2"]?.text.trim() ?? '';
      insertControllerLemari1.revampJumlahMinimunBarangMasuk = controllers["jumlahMinimumBarangMasukLemari2"]?.text.trim() ?? '';
      insertControllerLemari1.revampStatusBarangMasuk = controllers["statusBarangMasukLemari2"]?.text.trim() ?? '';
      await insertControllerLemari1.revampInsertBarangMasukLemari2();
    } catch (e) {
      debugPrint("ERROR LEMARI1: $e");
      rethrow;
    }
  }

  Future<void> insertRegistBarangMasukLemari3(
      Map<String, TextEditingController> controllers) async {
    try {
      if (GSheetsServicesEmployees.sheetsLemari3 == null) {
        await GSheetsServicesEmployees.init();
      }

      final insertControllerLemari1 = GsheetsBarangMasukLemari3();
      insertControllerLemari1.revampNomerUrutBarangMasuk = controllers["nomerUrutLemari3"]?.text.trim() ?? '';
      insertControllerLemari1.revampKodeBarangMasuk = controllers["kodeBarangMasuk"]?.text.trim() ?? '';
      insertControllerLemari1.revampNamaBarangMasuk = controllers["namaBarangMasuk"]?.text.trim() ?? '';
      insertControllerLemari1.revampJumlahBarangMasuk = controllers["jumlahBarangMasuk"]?.text.trim() ?? '';
      insertControllerLemari1.revampSatuanBarangMasuk = controllers["satuanBarangController"]?.text.trim() ?? '';
      insertControllerLemari1.revampTotalBarangMasuk = controllers["totalBarangMasukLemar3"]?.text.trim() ?? '';
      insertControllerLemari1.revampTotalBarangKeluar = controllers["totalBarangKeluarLemari3"]?.text.trim() ?? '';
      insertControllerLemari1.revampJumlahAkhirBarangMasuk = controllers["totalJumlahAkhirLemari3"]?.text.trim() ?? '';
      insertControllerLemari1.revampJumlahMinimunBarangMasuk = controllers["jumlahMinimumBarangMasukLemari3"]?.text.trim() ?? '';
      insertControllerLemari1.revampStatusBarangMasuk = controllers["statusBarangMasukLemari3"]?.text.trim() ?? '';
      await insertControllerLemari1.revampInsertBarangMasukLemari3();
    } catch (e) {
      debugPrint("ERROR LEMARI1: $e");
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
            if (!revampBarangMasukKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Gagal Menyimpan Data!")),
              );
              return;
            }
            await insertRegistBarangMasuk();
            for (final controllers in revampBarangMasukControllerss) {
              switch (controllers["lemariBarangMasuk"]?.text) {
                case "Lemari1":
                  await insertRegistBarangMasukLemari1(controllers);
                  break;
                case "Lemari2":
                  await insertRegistBarangMasukLemari2(controllers);
                  break;
                case "Lemari3":
                  await insertRegistBarangMasukLemari3(controllers);
                  break;
              }
            }
            for (final controllers in revampBarangMasukControllerss) {
              for (final controller in controllers.values) {
                controller.clear();
              }
            }
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Data Berhasil Disimpan")),
            );
            Get.to(() => const Hompagesmenus());
          },
          child: Container(
            height: 60,
            width: 300,
            margin: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 8, 36, 87,
              ),
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
        ),
      ],
    );
  }
}
