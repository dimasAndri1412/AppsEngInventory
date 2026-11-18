
import 'dart:io';

import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/MenuPages/navigationmenu.dart';
import 'package:appsenginventory/Services/gsheetsinsertbarangmasuklemari2.dart';
import 'package:appsenginventory/Services/gsheetsinsertbarangmasuklemari3.dart';
import 'package:appsenginventory/Services/gsheetsinsertnotifikasilemari1.dart';
import 'package:appsenginventory/Services/gsheetstinsertbarangmasuklemari1.dart';
import 'package:appsenginventory/Services/gsheetsinsertbarangmasukcontrollers.dart';
import 'package:appsenginventory/Services/gsheetsinsertPictureBarangMasuk.dart';
import 'package:appsenginventory/Services/gsheetsservices.dart';
import 'package:appsenginventory/Services/notifikasicontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RevampBarangMasukButtons extends StatefulWidget {
  final Map<String, XFile?> fotoBarangMasukMap;

  const RevampBarangMasukButtons({
    super.key,
    required this.fotoBarangMasukMap,
  });

  @override
  State<RevampBarangMasukButtons> createState() =>
      _RevampBarangMasukButtonsState();
}

class _RevampBarangMasukButtonsState
    extends State<RevampBarangMasukButtons> {
  bool _loadingDialogShown = false;
  bool _isSaving = false;

  String _fotoKey(
      Map<String, TextEditingController> controllers,
      ) {
    return controllers['kodeBarangMasuk']!.hashCode.toString();
  }

  void _showLoadingDialog() {
    if (!mounted || _loadingDialogShown) return;

    _loadingDialogShown = true;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (dialogContext) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
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
                      child: CircularProgressIndicator(strokeWidth: 4),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Menyimpan data...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Mohon tunggu',
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
    if (!_loadingDialogShown) return;

    _loadingDialogShown = false;

    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<bool> insertRegistBarangMasuk() async {
    try {
      await GSheetsServicesEmployees.init();

      if (GSheetsServicesEmployees.sheetsBarangMasuk == null) {
        throw Exception('Worksheet Barang Masuk tidak ditemukan.');
      }

      if (revampBarangMasukControllerss.isEmpty) {
        throw Exception('Tidak ada data barang yang diinput.');
      }

      for (final controllers in revampBarangMasukControllerss) {
        final insertController = GsheetsInsertBarangMasuk();

        insertController.revampKodeBarangMasuk =
            controllers['kodeBarangMasuk']?.text.trim() ?? '';

        insertController.revampTanggalBarangMasuk =
            controllers['tanggalBarangMasuk']?.text.trim() ?? '';

        insertController.revampNamaBarangMasuk =
            controllers['namaBarangMasuk']?.text.trim().toUpperCase() ?? '';

        insertController.revampJumlahBarangMasuk =
            controllers['jumlahBarangMasuk']?.text.trim() ?? '';

        insertController.revampSatuanBarangMasuk =
            controllers['satuanBarangController']?.text.trim() ?? '';

        insertController.revampPICBarangMasuk =
            controllers['picBarangMasuk']?.text.trim() ?? '';

        insertController.revampLemariBarangMasuk =
            controllers['lemariBarangMasuk']?.text.trim() ?? '';

        insertController.revampKeteranganBarangMasuk =
            controllers['keteranganBarangMasuk']?.text.trim() ?? '';

        await insertController.revampInsertBarangMasuk();
      }

      return true;
    } catch (e, stackTrace) {
      debugPrint('ERROR INSERT BARANG MASUK: $e');
      debugPrint('$stackTrace');
      rethrow;
    }
  }

  Future<void> insertRegistBarangMasukLemari1(
      Map<String, TextEditingController> controllers,
      ) async {
    final insertController = GsheetsBarangMasukLemari1();

    insertController.revampNomerUrutBarangMasuk =
        controllers['nomerUrutLemari1']?.text.trim() ?? '';
    insertController.revampKodeBarangMasuk =
        controllers['kodeBarangMasuk']?.text.trim() ?? '';
    insertController.revampNamaBarangMasuk =
        controllers['namaBarangMasuk']?.text.trim().toUpperCase() ?? '';
    insertController.revampSatuanBarangMasuk =
        controllers['satuanBarangController']?.text.trim() ?? '';
    insertController.revampJumlahBarangMasuk =
        controllers['jumlahBarangMasuk']?.text.trim() ?? '';
    insertController.revampTotalBarangMasuk =
        controllers['totalBarangMasukLemari1']?.text.trim() ?? '';
    insertController.revampTotalBarangKeluar =
        controllers['totalBarangKeluarLemari1']?.text.trim() ?? '';
    insertController.revampJumlahAkhirBarangMasuk =
        controllers['totalJumlahAkhirLemari1']?.text.trim() ?? '';
    insertController.revampJumlahMinimunBarangMasuk =
        controllers['jumlahMinimumBarangMasukLemari1']?.text.trim() ?? '';
    insertController.revampStatusBarangMasuk =
        controllers['statusBarangMasukLemari1']?.text.trim() ?? '';

    await insertController.revampInsertBarangMasukLemari1();
  }

  Future<void> insertRegistBarangMasukLemari2(
      Map<String, TextEditingController> controllers,
      ) async {
    final insertController = GsheetsBarangMasukLemari2();

    insertController.revampNomerUrutBarangMasuk =
        controllers['nomerUrutLemari2']?.text.trim() ?? '';
    insertController.revampKodeBarangMasuk =
        controllers['kodeBarangMasuk']?.text.trim() ?? '';
    insertController.revampNamaBarangMasuk =
        controllers['namaBarangMasuk']?.text.trim().toUpperCase() ?? '';
    insertController.revampJumlahBarangMasuk =
        controllers['jumlahBarangMasuk']?.text.trim() ?? '';
    insertController.revampSatuanBarangMasuk =
        controllers['satuanBarangController']?.text.trim() ?? '';
    insertController.revampTotalBarangMasuk =
        controllers['totalBarangMasukLemari2']?.text.trim() ?? '';
    insertController.revampTotalBarangKeluar =
        controllers['totalBarangKeluarLemari2']?.text.trim() ?? '';
    insertController.revampJumlahAkhirBarangMasuk =
        controllers['totalJumlahAkhirLemari2']?.text.trim() ?? '';
    insertController.revampJumlahMinimunBarangMasuk =
        controllers['jumlahMinimumBarangMasukLemari2']?.text.trim() ?? '';
    insertController.revampStatusBarangMasuk =
        controllers['statusBarangMasukLemari2']?.text.trim() ?? '';

    await insertController.revampInsertBarangMasukLemari2();
  }

  Future<void> insertRegistBarangMasukLemari3(
      Map<String, TextEditingController> controllers,
      ) async {
    final insertController = GsheetsBarangMasukLemari3();

    insertController.revampNomerUrutBarangMasuk =
        controllers['nomerUrutLemari3']?.text.trim() ?? '';
    insertController.revampKodeBarangMasuk =
        controllers['kodeBarangMasuk']?.text.trim() ?? '';
    insertController.revampNamaBarangMasuk =
        controllers['namaBarangMasuk']?.text.trim().toUpperCase() ?? '';
    insertController.revampJumlahBarangMasuk =
        controllers['jumlahBarangMasuk']?.text.trim() ?? '';
    insertController.revampSatuanBarangMasuk =
        controllers['satuanBarangController']?.text.trim() ?? '';
    insertController.revampTotalBarangMasuk =
        controllers['totalBarangMasukLemari3']?.text.trim() ?? '';
    insertController.revampTotalBarangKeluar =
        controllers['totalBarangKeluarLemari3']?.text.trim() ?? '';
    insertController.revampJumlahAkhirBarangMasuk =
        controllers['totalJumlahAkhirLemari3']?.text.trim() ?? '';
    insertController.revampJumlahMinimunBarangMasuk =
        controllers['jumlahMinimumBarangMasukLemari3']?.text.trim() ?? '';
    insertController.revampStatusBarangMasuk =
        controllers['statusBarangMasukLemari3']?.text.trim() ?? '';

    await insertController.revampInsertBarangMasukLemari3();
  }

  Future<void> insertNotfikasiRegistBarangMasukLemari1(
      Map<String, TextEditingController> controllers,
      ) async {
    final now = DateTime.now();

    final insertController = GsheetsNotifikasiBarangMasukLemari1();

    insertController.revampTanggalNotfikasiBarangMasuk =
        DateFormat('yyyy-MM-dd').format(now);
    insertController.revampNamaProsesNotfikasiBarangMasuk = 'Barang Masuk';
    insertController.revampKodeNotifikasBarangMasuk =
        controllers['kodeBarangMasuk']?.text.trim() ?? '';
    insertController.revampNamaNotfikiasBarangMasuk =
        controllers['namaBarangMasuk']?.text.trim().toUpperCase() ?? '';
    insertController.revampJumlahNotfikAIBarangMasuk =
        controllers['jumlahBarangMasuk']?.text.trim() ?? '';
    insertController.revampSatuanNotifikasiBarangMasuk =
        controllers['satuanBarangController']?.text.trim() ?? '';
    insertController.revampLemariNotifikasiBarangMasuk =
        controllers['lemariBarangMasuk']?.text.trim() ?? '';
    insertController.revampPICNotfikAIBarangMasuk =
        controllers['picBarangMasuk']?.text.trim() ?? '';
    insertController.revampKeteranganNotfikAIBarangMasuk =
        controllers['keteranganBarangMasuk']?.text.trim() ?? '';
    insertController.revampWaktuNotfikAIBarangMasuk =
        DateFormat('HH:mm:ss').format(now);

    await insertController.revampInsertNotifikasiBarangMasukLemari1();
  }

  Future<void> insertPictureBarangMasuk(
      Map<String, TextEditingController> controllers, {
        required String pathFoto,
      }) async {
    final now = DateTime.now();

    final insertController = GSheetsPictureBarangMasukLemari();

    insertController.revampTanggalPictureBarangMasuk =
        DateFormat('yyyy-MM-dd').format(now);

    insertController.revampWaktuPictureBarangMasuk =
        DateFormat('HH:mm:ss').format(now);

    insertController.revampPosisiLemariBarangMasuk =
        controllers['lemariBarangMasuk']?.text.trim() ?? '';

    insertController.revampKodePictureBarangMasuk =
        controllers['kodeBarangMasuk']?.text.trim() ?? '';

    insertController.revampNamaPictureBarangMasuk =
        controllers['namaBarangMasuk']?.text.trim().toUpperCase() ?? '';

    insertController.revampPathPictureBarangMasuk = pathFoto;

    await insertController.revampInsertPictureBarangMasukLemari1();
  }

  Future<void> _simpanBarangMasuk() async {
    if (_isSaving) return;

    final formState = revampBarangMasukKey.currentState;

    if (formState == null || !formState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gagal menyimpan data. Periksa kembali form.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (revampBarangMasukControllerss.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Belum ada barang yang diinput.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validasi semua barang sebelum menulis data ke Google Sheets.
    for (int i = 0; i < revampBarangMasukControllerss.length; i++) {
      final controllers = revampBarangMasukControllerss[i];
      final kode = controllers['kodeBarangMasuk']?.text.trim() ?? '';
      final lemari = controllers['lemariBarangMasuk']?.text.trim() ?? '';
      final foto = widget.fotoBarangMasukMap[_fotoKey(controllers)];

      if (kode.isEmpty) {
        _showError('Kode barang ke-${i + 1} belum tersedia.');
        return;
      }

      if (!['Lemari1', 'Lemari2', 'Lemari3'].contains(lemari)) {
        _showError('Pilih lokasi lemari untuk barang ke-${i + 1}.');
        return;
      }

      if (foto == null) {
        _showError('Foto untuk barang ke-${i + 1} wajib dipilih.');
        return;
      }

      if (!await File(foto.path).exists()) {
        _showError('File foto barang ke-${i + 1} tidak ditemukan.');
        return;
      }
    }

    setState(() {
      _isSaving = true;
    });

    _showLoadingDialog();

    try {
      await GSheetsServicesEmployees.init();

      if (GSheetsServicesEmployees.sheetsBarangMasuk == null ||
          GSheetsServicesEmployees.sheetsPicture == null) {
        throw Exception(
          'Worksheet Barang Masuk atau worksheet foto tidak ditemukan.',
        );
      }

      // Simpan data utama.
      await insertRegistBarangMasuk();

      // Simpan stok lemari, notifikasi, lalu upload foto per barang.
      for (final controllers in revampBarangMasukControllerss) {
        final lemari =
            controllers['lemariBarangMasuk']?.text.trim() ?? '';
        final foto = widget.fotoBarangMasukMap[_fotoKey(controllers)];

        if (foto == null) {
          throw Exception('Foto tidak ditemukan saat penyimpanan.');
        }

        await insertPictureBarangMasuk(
          controllers,
          pathFoto: foto.path,
        );

        switch (lemari) {
          case 'Lemari1':
            await insertRegistBarangMasukLemari1(controllers);
            break;
          case 'Lemari2':
            await insertRegistBarangMasukLemari2(controllers);
            break;
          case 'Lemari3':
            await insertRegistBarangMasukLemari3(controllers);
            break;
          default:
            throw Exception('Lokasi lemari tidak valid: $lemari');
        }

        await insertNotfikasiRegistBarangMasukLemari1(controllers);
      }

      if (Get.isRegistered<NotificationController>()) {
        await Get.find<NotificationController>().refreshNotification();
      }

      for (final controllers in revampBarangMasukControllerss) {
        for (final controller in controllers.values) {
          controller.clear();
        }
      }

      widget.fotoBarangMasukMap.clear();

      _hideLoadingDialog();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Data dan foto berhasil disimpan.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );

      Get.to(() => const NavigationMenuPages());
    } catch (e, stackTrace) {
      debugPrint('GAGAL MENYIMPAN BARANG MASUK: $e');
      debugPrint('$stackTrace');

      _hideLoadingDialog();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal menyimpan data atau foto: $e',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 6),
        ),
      );
    } finally {
      if (mounted) {
        if (_loadingDialogShown) {
          _hideLoadingDialog();
        }

        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _isSaving ? null : _simpanBarangMasuk,
        child: Container(
          height: 60,
          width: 300,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
            color: _isSaving
                ? Colors.grey
                : const Color.fromARGB(255, 8, 36, 87),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              _isSaving ? 'MENYIMPAN...' : 'SIMPAN',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
