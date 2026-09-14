import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/MenuPages/navigationmenu.dart';
import 'package:appsenginventory/Services/gsheetsinsertbarangmasuklemari2.dart';
import 'package:appsenginventory/Services/gsheetsinsertbarangmasuklemari3.dart';
import 'package:appsenginventory/Services/gsheetsinsertnotifikasilemari1.dart';
import 'package:appsenginventory/Services/gsheetstinsertbarangmasuklemari1.dart';
import 'package:appsenginventory/Services/gsheetsinsertbarangmasukcontrollers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Services/gsheetsservices.dart';
import 'package:intl/intl.dart';

import '../Services/notifikasicontroller.dart';

class RevampBarangMasukButtons extends StatefulWidget {
  const RevampBarangMasukButtons({super.key});

  @override
  State<RevampBarangMasukButtons> createState() => _RevampBarangMasukButtonsState();
}

class _RevampBarangMasukButtonsState extends State<RevampBarangMasukButtons> {

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 25,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                      ),
                    ),

                    SizedBox(height: 20),

                    Text(
                      "Menyimpan data...",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      "Mohon tunggu",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  void _hideLoadingDialog() {
    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }


  Future<bool> insertRegistBarangMasuk() async {
    try {
      if (GSheetsServicesEmployees.sheetsBarangMasuk == null) {
        await GSheetsServicesEmployees.init();
      }

      if (GSheetsServicesEmployees.sheetsBarangMasuk == null) {
        throw Exception(
          "Google Sheets gagal diinisialisasi.",
        );
      }

      if (revampBarangMasukControllerss.isEmpty) {
        throw Exception(
          "Tidak ada data registration.",
        );
      }

      for (int index = 0; index < revampBarangMasukControllerss.length; index++) {
        final controllers = revampBarangMasukControllerss[index];
        final tanggalBarangMasuk = controllers["tanggalBarangMasuk"]?.text.trim() ?? '';
        final kodeBarangMasuk = controllers["kodeBarangMasuk"]?.text.trim() ?? '';
        final namaBarangMasuk = controllers["namaBarangMasuk"]?.text.trim().toUpperCase() ?? '';
        final jumlahBarangMasuk = controllers["jumlahBarangMasuk"]?.text.trim() ?? '';
        final satuanBarangMasuk = controllers["satuanBarangController"]?.text.trim() ?? '';
        final picBarangMasuk = controllers["picBarangMasuk"]?.text.trim() ?? '';
        final lemariBarangMasuk = controllers["lemariBarangMasuk"]?.text.trim() ?? '';
        final keteranganBarangMasuk = controllers["keteranganBarangMasuk"]?.text.trim() ?? '';
        final insertController = GsheetsInsertBarangMasuk();

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

      return true;
    } catch (e) {
      debugPrint(
        "ERROR INSERT BARANG MASUK: $e",
      );

      return false;
    }
  }


  Future<void> insertRegistBarangMasukLemari1(Map<String, TextEditingController> controllers,) async {
    try {
      if (GSheetsServicesEmployees.sheetsLemari1 == null) {
        await GSheetsServicesEmployees.init();
      }

      final insertControllerLemari1 = GsheetsBarangMasukLemari1();
      insertControllerLemari1.revampNomerUrutBarangMasuk = controllers["nomerUrutLemari1"]?.text.trim() ?? '';
      insertControllerLemari1.revampKodeBarangMasuk = controllers["kodeBarangMasuk"]?.text.trim() ?? '';
      insertControllerLemari1.revampNamaBarangMasuk = controllers["namaBarangMasuk"]?.text.trim().toUpperCase() ?? '';
      insertControllerLemari1.revampSatuanBarangMasuk = controllers["satuanBarangController"]?.text.trim() ?? '';
      insertControllerLemari1.revampJumlahBarangMasuk = controllers["jumlahBarangMasuk"]?.text.trim() ?? '';
      insertControllerLemari1.revampTotalBarangMasuk = controllers["totalBarangMasukLemari1"]?.text.trim() ?? '';
      insertControllerLemari1.revampTotalBarangKeluar = controllers["totalBarangKeluarLemari1"]?.text.trim() ?? '';
      insertControllerLemari1.revampJumlahAkhirBarangMasuk = controllers["totalJumlahAkhirLemari1"]?.text.trim() ?? '';
      insertControllerLemari1.revampJumlahMinimunBarangMasuk = controllers["jumlahMinimumBarangMasukLemari1"]?.text.trim() ?? '';
      insertControllerLemari1.revampStatusBarangMasuk = controllers["statusBarangMasukLemari1"]?.text.trim() ?? '';
      await insertControllerLemari1.revampInsertBarangMasukLemari1();

    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertRegistBarangMasukLemari2(Map<String, TextEditingController> controllers,) async {
    try {
      if (GSheetsServicesEmployees.sheetsLemari2 == null) {
        await GSheetsServicesEmployees.init();
      }

      final insertControllerLemari2 = GsheetsBarangMasukLemari2();
      insertControllerLemari2.revampNomerUrutBarangMasuk = controllers["nomerUrutLemari2"]?.text.trim() ?? '';
      insertControllerLemari2.revampKodeBarangMasuk = controllers["kodeBarangMasuk"]?.text.trim() ?? '';
      insertControllerLemari2.revampNamaBarangMasuk = controllers["namaBarangMasuk"]?.text.trim().toUpperCase() ?? '';
      insertControllerLemari2.revampJumlahBarangMasuk = controllers["jumlahBarangMasuk"]?.text.trim() ?? '';
      insertControllerLemari2.revampSatuanBarangMasuk = controllers["satuanBarangController"]?.text.trim() ?? '';
      insertControllerLemari2.revampTotalBarangMasuk = controllers["totalBarangMasukLemari2"]?.text.trim() ?? '';
      insertControllerLemari2.revampTotalBarangKeluar = controllers["totalBarangKeluarLemari2"]?.text.trim() ?? '';
      insertControllerLemari2.revampJumlahAkhirBarangMasuk = controllers["totalJumlahAkhirLemari2"]?.text.trim() ?? '';
      insertControllerLemari2.revampJumlahMinimunBarangMasuk = controllers["jumlahMinimumBarangMasukLemari2"]?.text.trim() ?? '';
      insertControllerLemari2.revampStatusBarangMasuk = controllers["statusBarangMasukLemari2"]?.text.trim() ?? '';
      await insertControllerLemari2.revampInsertBarangMasukLemari2();

    } catch (e) {
      rethrow;
    }
  }


  Future<void> insertRegistBarangMasukLemari3(Map<String, TextEditingController> controllers,) async {
    try {
      if (GSheetsServicesEmployees.sheetsLemari3 == null) {
        await GSheetsServicesEmployees.init();
      }

      final insertControllerLemari3 = GsheetsBarangMasukLemari3();
      insertControllerLemari3.revampNomerUrutBarangMasuk = controllers["nomerUrutLemari3"]?.text.trim() ?? '';
      insertControllerLemari3.revampKodeBarangMasuk = controllers["kodeBarangMasuk"]?.text.trim() ?? '';
      insertControllerLemari3.revampNamaBarangMasuk = controllers["namaBarangMasuk"]?.text.trim().toUpperCase() ?? '';
      insertControllerLemari3.revampJumlahBarangMasuk = controllers["jumlahBarangMasuk"]?.text.trim() ?? '';
      insertControllerLemari3.revampSatuanBarangMasuk = controllers["satuanBarangController"]?.text.trim() ?? '';
      insertControllerLemari3.revampTotalBarangMasuk = controllers["totalBarangMasukLemari3"]?.text.trim() ?? '';
      insertControllerLemari3.revampTotalBarangKeluar = controllers["totalBarangKeluarLemari3"]?.text.trim() ?? '';
      insertControllerLemari3.revampJumlahAkhirBarangMasuk = controllers["totalJumlahAkhirLemari3"]?.text.trim() ?? '';
      insertControllerLemari3.revampJumlahMinimunBarangMasuk = controllers["jumlahMinimumBarangMasukLemari3"]?.text.trim() ?? '';
      insertControllerLemari3.revampStatusBarangMasuk = controllers["statusBarangMasukLemari3"]?.text.trim() ?? '';
      await insertControllerLemari3.revampInsertBarangMasukLemari3();

    } catch (e) {
      debugPrint(
        "ERROR LEMARI3: $e",
      );

      rethrow;
    }
  }


  Future<void> insertNotfikasiRegistBarangMasukLemari1(Map<String, TextEditingController> controllers,) async {
    try {
      if (GSheetsServicesEmployees.sheetNotif == null) {
        await GSheetsServicesEmployees.init();
      }

      final currentDate = DateFormat('yyyy-MM-dd').format(
        DateTime.now(),
      );
      final waktu = DateFormat('HH:mm:ss').format(
        DateTime.now(),
      );

      final inserNotfiControllerLemari1 = GsheetsNotifikasiBarangMasukLemari1();
      inserNotfiControllerLemari1.revampTanggalNotfikasiBarangMasuk = currentDate;
      inserNotfiControllerLemari1.revampNamaProsesNotfikasiBarangMasuk = 'Barang Masuk';
      inserNotfiControllerLemari1.revampKodeNotifikasBarangMasuk = controllers["kodeBarangMasuk"]?.text.trim() ?? '';
      inserNotfiControllerLemari1.revampNamaNotfikiasBarangMasuk = controllers["namaBarangMasuk"]?.text.trim().toUpperCase() ?? '';
      inserNotfiControllerLemari1.revampJumlahNotfikAIBarangMasuk = controllers["jumlahBarangMasuk"]?.text.trim() ?? '';
      inserNotfiControllerLemari1.revampSatuanNotifikasiBarangMasuk = controllers["satuanBarangController"]?.text.trim() ?? '';
      inserNotfiControllerLemari1.revampLemariNotifikasiBarangMasuk = controllers["lemariBarangMasuk"]?.text.trim() ?? '';
      inserNotfiControllerLemari1.revampPICNotfikAIBarangMasuk = controllers["picBarangMasuk"]?.text.trim() ?? '';
      inserNotfiControllerLemari1.revampKeteranganNotfikAIBarangMasuk = controllers["keteranganBarangMasuk"]?.text.trim() ?? '';
      inserNotfiControllerLemari1.revampWaktuNotfikAIBarangMasuk = waktu;
      await inserNotfiControllerLemari1.revampInsertNotifikasiBarangMasukLemari1();

    } catch (e) {
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
                const SnackBar(
                  content: Text(
                    "Gagal Menyimpan Data!",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            _showLoadingDialog();

            try {

              final bool success = await insertRegistBarangMasuk();

              if (!success) {
                throw Exception(
                  "Gagal insert data barang masuk.",
                );
              }


              for (final controllers in revampBarangMasukControllerss) {

                switch (
                controllers["lemariBarangMasuk"]?.text.trim()) {

                  case "Lemari1":
                    await insertRegistBarangMasukLemari1(controllers);
                    await insertNotfikasiRegistBarangMasukLemari1(controllers);
                    if (Get.isRegistered<NotificationController>()) {
                      await Get.find<NotificationController>().refreshNotification();
                    }
                    break;

                  case "Lemari2":
                    await insertRegistBarangMasukLemari2(controllers,);
                    await insertNotfikasiRegistBarangMasukLemari1(controllers,);
                    if (Get.isRegistered<NotificationController>()) {
                      await Get.find<NotificationController>().refreshNotification();
                    }
                    break;

                  case "Lemari3":
                    await insertRegistBarangMasukLemari3(controllers,);
                    await insertNotfikasiRegistBarangMasukLemari1(controllers,);

                    if (Get.isRegistered<NotificationController>()) {
                      await Get.find<NotificationController>().refreshNotification();
                    }
                    break;
                }
              }

              for (final controllers in revampBarangMasukControllerss) {
                for (final controller in controllers.values) {
                  controller.clear();
                }
              }

              _hideLoadingDialog();

              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Data Berhasil Disimpan",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
              );

              Get.to(() => const NavigationMenuPages());

            } catch (e) {

              _hideLoadingDialog();

              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Gagal Menyimpan Data!",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },


          child: Container(
            height: 60,
            width: 300,
            margin: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
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
        ),
      ],
    );
  }
}