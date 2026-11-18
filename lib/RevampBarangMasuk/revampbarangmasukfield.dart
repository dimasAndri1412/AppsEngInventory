
import 'dart:io';

import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/RevampBarangMasuk/MaterialBarangMasuk/dropdownlistlemari.dart';
import 'package:appsenginventory/Services/gsheetscontrollers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../RevampRegistrations/MaterialRevampRegistration/funcntions.dart';
import '../Services/gsheetsservices.dart';

class RevampBarangMasukField extends StatefulWidget {
  final Map<String, XFile?> fotoBarangMasukMap;

  const RevampBarangMasukField({
    super.key,
    required this.fotoBarangMasukMap,
  });

  @override
  State<RevampBarangMasukField> createState() =>
      _RevampBarangMasukFieldState();
}

class _RevampBarangMasukFieldState
    extends State<RevampBarangMasukField> {
  String? dropDownValues;
  String? dropDownListLemari;

  final List<DropDownListLemari> lemariListings = [];
  final ImagePicker _imagePicker = ImagePicker();

  bool isLoadingPosisi = true;

  String _fotoKey(
      Map<String, TextEditingController> controllers,
      ) {
    final controller = controllers['kodeBarangMasuk'];

    if (controller == null) {
      throw StateError(
        'Controller kodeBarangMasuk tidak ditemukan.',
      );
    }

    return identityHashCode(controller).toString();
  }

  void updateStatusBarang(
      Map<String, TextEditingController> controllers,
      String lemari,
      ) {
    final stokAkhir = int.tryParse(
      controllers['totalJumlahAkhir$lemari']?.text ?? '0',
    ) ??
        0;

    final stokMinimum = int.tryParse(
      controllers['jumlahMinimumBarangMasuk$lemari']?.text ?? '0',
    ) ??
        0;

    controllers['statusBarangMasuk$lemari']?.text =
    stokAkhir <= stokMinimum ? '⚠ KURANG' : '✓ AMAN';
  }

  Future<void> pilihFotoBarang(
      Map<String, TextEditingController> controllers, {
        required ImageSource source,
      }) async {
    try {
      final foto = await _imagePicker.pickImage(
        source: source,
        imageQuality: 75,
        maxWidth: 1280,
      );

      if (foto == null || !mounted) return;

      setState(() {
        widget.fotoBarangMasukMap[_fotoKey(controllers)] = foto;
      });
    } catch (e, stackTrace) {
      debugPrint('GAGAL MENGAMBIL FOTO: $e');
      debugPrint('$stackTrace');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengambil foto: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> generateNoBarangMasuk(
      Map<String, TextEditingController> controllers,
      ) async {
    final index = revampBarangMasukControllerss.indexOf(controllers);
    final noUrut = index == -1
        ? revampBarangMasukControllerss.length + 1
        : index + 1;

    if ((controllers['tanggalBarangMasuk']?.text ?? '').isNotEmpty) {
      controllers['nomerUrut']?.text = noUrut.toString();
    } else {
      controllers['nomerUrut']?.clear();
    }
  }

  Future<void> _generateKodeDanNomor(
      Map<String, TextEditingController> controllers,
      dynamic worksheet,
      String fieldNomor,
      ) async {
    try {
      await GSheetsServicesEmployees.init();

      if (worksheet == null) {
        throw Exception('Worksheet lemari tidak ditemukan.');
      }

      final rows = await worksheet.values.allRows();

      if (rows.isEmpty) {
        controllers['kodeBarangMasuk']!.text =
            Functions.generatedKodeBarang(1);
        controllers[fieldNomor]!.text = '1';
        return;
      }

      int headerRow = -1;
      int kodeBarangIndex = -1;
      int nomorIndex = -1;

      for (int r = 0; r < rows.length; r++) {
        for (int c = 0; c < rows[r].length; c++) {
          final value = rows[r][c].toString().trim().toLowerCase();

          if (value == 'kode barang') {
            kodeBarangIndex = c;
          }

          if (value == 'no') {
            nomorIndex = c;
          }
        }

        if (kodeBarangIndex != -1 && nomorIndex != -1) {
          headerRow = r;
          break;
        }
      }

      if (headerRow == -1 ||
          kodeBarangIndex == -1 ||
          nomorIndex == -1) {
        throw Exception(
          'Header "Kode Barang" atau "No" tidak ditemukan.',
        );
      }

      int nextKode = 1;
      int nextNomor = 1;

      for (int i = rows.length - 1; i > headerRow; i--) {
        if (rows[i].length > kodeBarangIndex) {
          final kode = rows[i][kodeBarangIndex].trim();
          final match = RegExp(r'^ENG-(\d+)$').firstMatch(kode);

          if (match != null) {
            nextKode = int.parse(match.group(1)!) + 1;
            break;
          }
        }
      }

      for (int i = rows.length - 1; i > headerRow; i--) {
        if (rows[i].length > nomorIndex) {
          final nomor = int.tryParse(rows[i][nomorIndex].trim());

          if (nomor != null) {
            nextNomor = nomor + 1;
            break;
          }
        }
      }

      controllers['kodeBarangMasuk']!.text =
          Functions.generatedKodeBarang(nextKode);
      controllers[fieldNomor]!.text = nextNomor.toString();
    } catch (e, stackTrace) {
      debugPrint('ERROR GENERATE KODE DAN NOMOR: $e');
      debugPrint('$stackTrace');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membuat kode barang: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> kodeBarangDanNomerUrutLemari1(
      Map<String, TextEditingController> controllers,
      dynamic worksheet,
      ) =>
      _generateKodeDanNomor(controllers, worksheet, 'nomerUrutLemari1');

  Future<void> kodeBarangDanNomerUrutLemari2(
      Map<String, TextEditingController> controllers,
      dynamic worksheet,
      ) =>
      _generateKodeDanNomor(controllers, worksheet, 'nomerUrutLemari2');

  Future<void> kodeBarangDanNomerUrutLemari3(
      Map<String, TextEditingController> controllers,
      dynamic worksheet,
      ) =>
      _generateKodeDanNomor(controllers, worksheet, 'nomerUrutLemari3');

  Map<String, TextEditingController> createBarangMasukControllers() {
    return {
      'nomerUrutLemari1': TextEditingController(),
      'nomerUrutLemari2': TextEditingController(),
      'nomerUrutLemari3': TextEditingController(),

      'totalBarangMasukLemari1': TextEditingController(),
      'totalBarangKeluarLemari1': TextEditingController(),
      'totalJumlahAkhirLemari1': TextEditingController(),
      'jumlahMinimumBarangMasukLemari1': TextEditingController(),
      'statusBarangMasukLemari1': TextEditingController(),

      'totalBarangMasukLemari2': TextEditingController(),
      'totalBarangKeluarLemari2': TextEditingController(),
      'totalJumlahAkhirLemari2': TextEditingController(),
      'jumlahMinimumBarangMasukLemari2': TextEditingController(),
      'statusBarangMasukLemari2': TextEditingController(),

      'totalBarangMasukLemari3': TextEditingController(),
      'totalBarangKeluarLemari3': TextEditingController(),
      'totalJumlahAkhirLemari3': TextEditingController(),
      'jumlahMinimumBarangMasukLemari3': TextEditingController(),
      'statusBarangMasukLemari3': TextEditingController(),

      'nomerUrut': TextEditingController(),
      'kodeBarangMasuk': TextEditingController(),
      'tanggalBarangMasuk': TextEditingController(),
      'namaBarangMasuk': TextEditingController(),
      'jumlahBarangMasuk': TextEditingController(),
      'satuanBarangController': TextEditingController(),
      'picBarangMasuk': TextEditingController(),
      'lemariBarangMasuk': TextEditingController(),
      'keteranganBarangMasuk': TextEditingController(),
    };
  }

  Future<void> getListsPosisiLemari() async {
    try {
      await GSheetsServicesEmployees.init();
      final results = await getDataLemari();

      if (!mounted) return;

      setState(() {
        lemariListings
          ..clear()
          ..addAll(
            results.map(
                  (data) => DropDownListLemari(
                lemariposisi: data['PosisiLemari'] ?? '',
              ),
            ),
          );

        isLoadingPosisi = false;
      });
    } catch (e, stackTrace) {
      debugPrint('ERROR MENGAMBIL POSISI LEMARI: $e');
      debugPrint('$stackTrace');

      if (!mounted) return;

      setState(() {
        isLoadingPosisi = false;
        lemariListings.clear();
      });
    }
  }

  void addNewsContainers() {
    final controllers = createBarangMasukControllers();

    setState(() {
      revampBarangMasukControllerss.add(controllers);
    });
  }

  void removeRegistContainer() {
    if (revampBarangMasukControllerss.isEmpty) return;

    setState(() {
      final controllers = revampBarangMasukControllerss.removeLast();

      widget.fotoBarangMasukMap.remove(_fotoKey(controllers));

      for (final controller in controllers.values) {
        controller.dispose();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getListsPosisiLemari();
  }

  @override
  void dispose() {
    // Foto yang dipilih dikelola oleh Wrapper, jadi tidak dihapus di sini.
    super.dispose();
  }

  Widget startBuildBarangMasukContainers() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 10,
            color: Colors.black26,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Expanded(
            child: Text(
              'Masukan Barang',
              style: TextStyle(
                color: Color.fromARGB(255, 8, 36, 87),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: addNewsContainers,
            heroTag: 'add-first-barang',
            backgroundColor: const Color.fromARGB(255, 8, 36, 87),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _textField({
    required String label,
    required String controllerKey,
    required Map<String, TextEditingController> controllers,
    required String errorText,
    TextInputType? keyboardType,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? prefixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextFormField(
        controller: controllers[controllerKey],
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          border: const UnderlineInputBorder(),
          prefixIcon: prefixIcon,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return errorText;
          }
          return null;
        },
      ),
    );
  }

  Widget buildsBarangMasukContainers(
      Map<String, TextEditingController> controllers,
      int index,
      ) {
    final fotoKey = _fotoKey(controllers);

    return Container(
      key: ValueKey(fotoKey),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 10,
            color: Colors.black26,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Barang Masuk ${index + 1}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 8, 36, 87),
            ),
          ),

          _textField(
            label: 'Tanggal Barang Masuk',
            controllerKey: 'tanggalBarangMasuk',
            controllers: controllers,
            errorText: 'Tanggal barang masuk tidak boleh kosong!',
            readOnly: true,
            prefixIcon: const Icon(Icons.calendar_today),
            onTap: () async {
              final selected = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2100),
              );

              if (selected != null && mounted) {
                controllers['tanggalBarangMasuk']!.text =
                    DateFormat('yyyy-MM-dd').format(selected);
                await generateNoBarangMasuk(controllers);
                if (mounted) setState(() {});
              }
            },
          ),

          _textField(
            label: 'Nama Barang Masuk',
            controllerKey: 'namaBarangMasuk',
            controllers: controllers,
            errorText: 'Nama barang tidak boleh kosong!',
            prefixIcon: const Icon(Icons.note_add),
          ),

          Row(
            children: [
              Expanded(
                child: _textField(
                  label: 'Jumlah',
                  controllerKey: 'jumlahBarangMasuk',
                  controllers: controllers,
                  errorText: 'Jumlah tidak boleh kosong!',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.inventory_2),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  child: DropdownButtonFormField<String>(
                    value: controllers['satuanBarangController']!.text.isEmpty
                        ? null
                        : controllers['satuanBarangController']!.text,
                    decoration: const InputDecoration(
                      labelText: 'Satuan',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Satuan',
                        child: Text('Satuan'),
                      ),
                      DropdownMenuItem(
                        value: 'PCS',
                        child: Text('PCS'),
                      ),
                      DropdownMenuItem(
                        value: 'UNIT',
                        child: Text('UNIT'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;

                      controllers['satuanBarangController']!.text = value;
                      controllers['picBarangMasuk']!.text =
                          sideBarFullNameController.text;

                      setState(() {});
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Pilih satuan!';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),

          _textField(
            label: 'PIC Barang Masuk',
            controllerKey: 'picBarangMasuk',
            controllers: controllers,
            errorText: 'PIC barang masuk tidak boleh kosong!',
            readOnly: true,
            prefixIcon: const Icon(Icons.people),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            child: isLoadingPosisi
                ? const Center(child: CircularProgressIndicator())
                : DropdownButtonFormField<String>(
              value: lemariListings
                  .map((item) => item.lemariposisi)
                  .contains(
                controllers['lemariBarangMasuk']!.text,
              )
                  ? controllers['lemariBarangMasuk']!.text
                  : null,
              decoration: const InputDecoration(
                labelText: 'Posisi Lemari',
                prefixIcon: Icon(Icons.work),
              ),
              hint: const Text('-- Pilih Lemari --'),
              items: lemariListings.map((lemari) {
                return DropdownMenuItem<String>(
                  value: lemari.lemariposisi,
                  child: Text(lemari.lemariposisi),
                );
              }).toList(),
              onChanged: (value) async {
                if (value == null) return;

                controllers['lemariBarangMasuk']!.text = value;
                dropDownListLemari = value;

                await GSheetsServicesEmployees.init();

                if (value == 'Lemari1') {
                  await kodeBarangDanNomerUrutLemari1(
                    controllers,
                    GSheetsServicesEmployees.sheetsLemari1,
                  );
                } else if (value == 'Lemari2') {
                  await kodeBarangDanNomerUrutLemari2(
                    controllers,
                    GSheetsServicesEmployees.sheetsLemari2,
                  );
                } else if (value == 'Lemari3') {
                  await kodeBarangDanNomerUrutLemari3(
                    controllers,
                    GSheetsServicesEmployees.sheetsLemari3,
                  );
                }

                final suffix = value;
                controllers['totalBarangMasuk$suffix']!.text = '0';
                controllers['totalBarangKeluar$suffix']!.text = '0';
                controllers['jumlahMinimumBarangMasuk$suffix']!.text =
                '1';
                controllers['totalJumlahAkhir$suffix']!.text =
                    controllers['jumlahBarangMasuk']!.text;

                updateStatusBarang(controllers, suffix);

                if (mounted) setState(() {});
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tolong pilih lokasi lemari';
                }
                return null;
              },
            ),
          ),

          _textField(
            label: 'Keterangan Barang Masuk',
            controllerKey: 'keteranganBarangMasuk',
            controllers: controllers,
            errorText: 'Keterangan barang masuk tidak boleh kosong!',
            prefixIcon: const Icon(Icons.note),
          ),

          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Foto Barang Masuk',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 8, 36, 87),
                  ),
                ),
                const SizedBox(height: 12),

                Builder(
                  builder: (context) {
                    final foto = widget.fotoBarangMasukMap[fotoKey];

                    if (foto == null) {
                      return Container(
                        height: 150,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              size: 45,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8),
                            Text('Belum ada foto barang'),
                          ],
                        ),
                      );
                    }

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(foto.path),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => pilihFotoBarang(
                          controllers,
                          source: ImageSource.camera,
                        ),
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Ambil Foto'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => pilihFotoBarang(
                          controllers,
                          source: ImageSource.gallery,
                        ),
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Galeri'),
                      ),
                    ),
                  ],
                ),

                if (widget.fotoBarangMasukMap[fotoKey] != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {
                        setState(() {
                          widget.fotoBarangMasukMap.remove(fotoKey);
                        });
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                      label: const Text(
                        'Hapus Foto',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            runSpacing: 5,
            children: [
              const Text(
                'Barang Masuk Lainnya',
                style: TextStyle(
                  color: Color.fromARGB(255, 8, 36, 87),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FloatingActionButton(
                onPressed: addNewsContainers,
                heroTag: 'add-barang-$index',
                mini: true,
                backgroundColor: const Color.fromARGB(255, 8, 36, 87),
                child: const Icon(Icons.add, color: Colors.white),
              ),
              FloatingActionButton(
                onPressed: removeRegistContainer,
                heroTag: 'remove-barang-$index',
                mini: true,
                backgroundColor: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: revampBarangMasukKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (revampBarangMasukControllerss.isEmpty)
              startBuildBarangMasukContainers()
            else
              ...revampBarangMasukControllerss.asMap().entries.map(
                    (entry) => buildsBarangMasukContainers(
                  entry.value,
                  entry.key,
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
