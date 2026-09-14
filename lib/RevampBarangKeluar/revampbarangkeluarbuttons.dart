import 'package:appsenginventory/Services/gsheetsinsertnotifikasilemarikeluar.dart';
import 'package:intl/intl.dart';
import 'package:appsenginventory/MenuPages/navigationmenu.dart';
import 'package:appsenginventory/Services/gsheetsinsertbarangkeluarcontrollers.dart';
import 'package:appsenginventory/Services/gsheetsupdatestockbaranglemari1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/key.dart';
import '../Services/gsheetsinsertnotifikasilemari1.dart';
import '../Services/gsheetsservices.dart';

class RevampBarangKeluarButtons extends StatefulWidget {
  const RevampBarangKeluarButtons({super.key});

  @override
  State<RevampBarangKeluarButtons> createState() =>
      _RevampBarangKeluarButtonsState();
}

class _RevampBarangKeluarButtonsState extends State<RevampBarangKeluarButtons> {


  bool _isLoading = false;

  void _showLoadingDialog() {
    if (!mounted) return;

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
    if (!mounted) return;

    if (Navigator.of(
      context,
      rootNavigator: true,
    ).canPop()) {
      Navigator.of(
        context,
        rootNavigator: true,
      ).pop();
    }
  }


  Future<void> insertRegistBarangKeluar() async {
    try {
      if (GSheetsServicesEmployees.sheetsBarangKeluar == null) {
        await GSheetsServicesEmployees.init();
      }

      if (GSheetsServicesEmployees.sheetsBarangKeluar == null) {
        throw Exception(
          "Google Sheets barang keluar gagal diinisialisasi.",
        );
      }

      if (revampBarangKeluarControllerss.isEmpty) {
        throw Exception(
          "Tidak ada data barang keluar.",
        );
      }

      final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final waktu = DateFormat('HH:mm:ss').format(DateTime.now());

      for (final controllers in revampBarangKeluarControllerss) {

        final insert = GsheetsInsertBarangKeluar()
          ..revampKodeBarangKeluar = controllers["kodeBarangKeluar"]?.text.trim()
          ..revampTanggalBarangKeluar = controllers["tanggalBarangKeluar"]?.text.trim()
          ..revampNamaBarangKeluar = controllers["namaBarangKeluar"]?.text.trim()
          ..revampJumlahBarangKeluar = controllers["jumlahBarangKeluar"]?.text.trim()
          ..revampSatuanBarangKeluar = controllers["satuanBarangKeluar"]?.text.trim()
          ..revampPICBarangKeluar = controllers["picBarangKeluar"]?.text.trim()
          ..revampLemariBarangKeluar = controllers["lemariBarangKeluar"]?.text.trim()
          ..revampKeteranganBarangKeluar = controllers["keteranganBarangKeluar"]?.text.trim();
        await insert.revampInsertBarangMasuk();


        final insertNotif = GsheetsNotifikasiBarangMasukKeluar()
          ..revampTanggalNotfikasiBarangKeluar = currentDate
          ..revampNamaProsesNotfikasiBarangKeluar = "Barang Keluar"
          ..revampKodeNotifikasBarangKeluar = controllers["kodeBarangKeluar"]?.text.trim()
          ..revampNamaNotfikiasBarangKeluar = controllers["namaBarangKeluar"]?.text.trim()
          ..revampJumlahNotfikasiBarangKeluar = controllers["jumlahBarangKeluar"]?.text.trim()
          ..revampSatuanNotifikasiBarangKeluar = controllers["satuanBarangKeluar"]?.text.trim()
          ..revampLemariNotifikasiBarangKeluar = controllers["lemariBarangKeluar"]?.text.trim()
          ..revampPICNotfikAIBarangKeluar = controllers["picBarangKeluar"]?.text.trim()
          ..revampKeteranganNotfikasBarangKeluar = controllers["keteranganBarangKeluar"]?.text.trim()
          ..revampWaktuNotfikasiBarangKeluar = waktu;
        await insertNotif.revampInsertNotifikasiBarangKeluar();


        final update = GsheetsUpdateBarangKeluar()
          ..revampKodeBarangKeluar = controllers["kodeBarangKeluar"]?.text.trim()
          ..revampNamaBarangKeluar = controllers["namaBarangKeluar"]?.text.trim()
          ..revampJumlahBarangKeluar = controllers["jumlahBarangKeluar"]?.text.trim()
          ..revampLemariBarangKeluar = controllers["lemariBarangKeluar"]?.text.trim();
        await update.revampUpdateStockBarang();
      }

    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertNotfikasiRegistBarangKeluarLemari1(
      Map<String, TextEditingController> controllers,
      ) async {
    try {
      if (GSheetsServicesEmployees.sheetNotif == null) {
        await GSheetsServicesEmployees.init();
      }

      final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now(),);
      final waktu = DateFormat('HH:mm:ss').format(DateTime.now(),);

      final inserNotfiControllerLemari1 = GsheetsNotifikasiBarangMasukLemari1();
      inserNotfiControllerLemari1.revampTanggalNotfikasiBarangMasuk = currentDate;
      inserNotfiControllerLemari1.revampNamaProsesNotfikasiBarangMasuk = 'Barang Keluar';
      inserNotfiControllerLemari1.revampKodeNotifikasBarangMasuk = controllers["kodeBarangKeluar"]?.text.trim();
      inserNotfiControllerLemari1.revampNamaNotfikiasBarangMasuk = controllers["namaBarangKeluar"]?.text.trim();
      inserNotfiControllerLemari1.revampJumlahNotfikAIBarangMasuk = controllers["jumlahBarangKeluar"]?.text.trim();
      inserNotfiControllerLemari1.revampSatuanNotifikasiBarangMasuk = controllers["satuanBarangKeluar"]?.text.trim();
      inserNotfiControllerLemari1.revampPICNotfikAIBarangMasuk = controllers["picBarangKeluar"]?.text.trim();
      inserNotfiControllerLemari1.revampKeteranganNotfikAIBarangMasuk = controllers["keteranganBarangKeluar"]?.text.trim();
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
          onTap: _isLoading ? null
              : () async {

            if (!revampBarangKeluarkKey.currentState!.validate()) {
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

            setState(() {
              _isLoading = true;
            });

            _showLoadingDialog();

            try {

              await insertRegistBarangKeluar();

              for (final controllers in revampBarangKeluarControllerss) {
                for (final controller in controllers.values) {
                  controller.clear();
                }
              }

              _hideLoadingDialog();

              if (!mounted) return;

              setState(() {
                _isLoading = false;
              });


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

              Get.offAll(() => const NavigationMenuPages());

            } catch (e) {

              _hideLoadingDialog();

              if (!mounted) return;

              setState(() {
                _isLoading = false;
              });

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
              color: _isLoading ? Colors.grey
                  : const Color.fromARGB(255, 8, 36, 87),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: _isLoading ? const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ) : const Text(
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