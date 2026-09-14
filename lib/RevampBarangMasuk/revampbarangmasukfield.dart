import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/RevampBarangMasuk/MaterialBarangMasuk/dropdownlistlemari.dart';
import 'package:appsenginventory/Services/gsheetscontrollers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../RevampRegistrations/MaterialRevampRegistration/funcntions.dart';
import '../Services/gsheetsservices.dart';

class RevampBarangMasukField extends StatefulWidget {
  const RevampBarangMasukField({super.key});

  @override
  State<RevampBarangMasukField> createState() => _RevampBarangMasukFieldState();
}

class _RevampBarangMasukFieldState extends State<RevampBarangMasukField> {

  String? dropDownValues;
  String? dropDownListLemari;
  int nextKodeSequence = 1;
  List<Widget> addtionalBarangContainers = [];
  List<DropDownListLemari> lemariListings = [];
  bool isLoadingPosisi = true;

  void updateStatusBarang(
      Map<String, TextEditingController> controllersss, String lemari,) {
    final stokAkhir = int.tryParse(
      controllersss["totalJumlahAkhir$lemari"]?.text ?? "0",
    ) ?? 0;
    final stokMinimum = int.tryParse(
      controllersss["jumlahMinimumBarangMasuk$lemari"]?.text ?? "0",
    ) ?? 0;
    controllersss["statusBarangMasuk$lemari"]?.text =
    stokAkhir <= stokMinimum ? "⚠ KURANG" : "✓ AMAN";
  }

  Future<void> generateNoBarangMasuk(Map<String, TextEditingController> controllersss,) async {

    final index = revampBarangMasukControllerss.indexOf(controllersss);
    final noUrut = index == -1
        ? revampBarangMasukControllerss.length + 1
        : index + 1;

    if ((controllersss["tanggalBarangMasuk"]?.text ?? "").isNotEmpty) {
      controllersss["nomerUrut"]?.text = noUrut.toString();
    } else {
      controllersss["nomerUrut"]?.clear();
    }
  }

  Future<void> kodeBarangDanNomerUrutLemari1(Map<String, TextEditingController> controllersss, dynamic worksheet,) async {
    try {
      await GSheetsServicesEmployees.init();
      final rows = await worksheet.values.allRows();

      if (rows.isEmpty) {
        controllersss["kodeBarangMasuk"]!.text = Functions.generatedKodeBarang(1);
        controllersss["nomerUrutLemari1"]!.text = "1";
        return;
      }

      int headerRow = -1;
      int kodeBarangIndex = -1;
      int nomerUrutIndex = -1;

      for (int r = 0; r < rows.length; r++) {
        for (int c = 0; c < rows[r].length; c++) {
          final value = rows[r][c].toString().trim().toLowerCase();
          if (value == "kode barang") {
            kodeBarangIndex = c;
            headerRow = r;
          }
          if (value == "no") {
            nomerUrutIndex = c;
            headerRow = r;
          }
        }

        if (kodeBarangIndex != -1 && nomerUrutIndex != -1) {
          break;
        }
      }

      int nextKode = 1;
      int nextUrut = 1;

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
        if (rows[i].length > nomerUrutIndex) {
          final nomor = int.tryParse(rows[i][nomerUrutIndex].trim());

          if (nomor != null) {
            nextUrut = nomor + 1;
            break;
          }
        }
      }
      controllersss["kodeBarangMasuk"]!.text = Functions.generatedKodeBarang(nextKode);
      controllersss["nomerUrutLemari1"]!.text = nextUrut.toString();

      if (kodeBarangIndex == -1 || nomerUrutIndex == -1) {
        debugPrint("Header tidak ditemukan");
        debugPrint("Header row yang terbaca:");
        for (int i = 0; i < rows.length && i < 5; i++) {
          debugPrint("Row $i : ${rows[i]}");
        }
        return;
      }
    } catch (e, s) {
      debugPrint("Error generate kode barang & nomor urut: $e");
      debugPrint("$s");
    }
  }

  Future<void> kodeBarangDanNomerUrutLemari2(Map<String, TextEditingController> controllersss, dynamic worksheet,) async {
    try {
      await GSheetsServicesEmployees.init();
      final rows = await worksheet.values.allRows();

      if (rows.isEmpty) {
        controllersss["kodeBarangMasuk"]!.text = Functions.generatedKodeBarang(1);
        controllersss["nomerUrutLemari2"]!.text = "1";
        return;
      }

      int headerRow = -1;
      int kodeBarangIndex = -1;
      int nomerUrutIndex = -1;

      for (int r = 0; r < rows.length; r++) {
        for (int c = 0; c < rows[r].length; c++) {
          final value = rows[r][c].toString().trim().toLowerCase();
          if (value == "kode barang") {
            kodeBarangIndex = c;
            headerRow = r;
          }
          if (value == "no") {
            nomerUrutIndex = c;
            headerRow = r;
          }
        }

        if (kodeBarangIndex != -1 && nomerUrutIndex != -1) {
          break;
        }
      }

      int nextKode = 1;
      int nextUrut = 1;

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
        if (rows[i].length > nomerUrutIndex) {
          final nomor = int.tryParse(rows[i][nomerUrutIndex].trim());

          if (nomor != null) {
            nextUrut = nomor + 1;
            break;
          }
        }
      }
      controllersss["kodeBarangMasuk"]!.text = Functions.generatedKodeBarang(nextKode);
      controllersss["nomerUrutLemari2"]!.text = nextUrut.toString();

      if (kodeBarangIndex == -1 || nomerUrutIndex == -1) {
        debugPrint("Header tidak ditemukan");
        debugPrint("Header row yang terbaca:");
        for (int i = 0; i < rows.length && i < 5; i++) {
          debugPrint("Row $i : ${rows[i]}");
        }
        return;
      }
    } catch (e, s) {
      debugPrint("Error generate kode barang & nomor urut: $e");
      debugPrint("$s");
    }
  }

  Future<void> kodeBarangDanNomerUrutLemari3(Map<String, TextEditingController> controllersss, dynamic worksheet,) async {
    try {
      await GSheetsServicesEmployees.init();
      final rows = await worksheet.values.allRows();

      if (rows.isEmpty) {
        controllersss["kodeBarangMasuk"]!.text = Functions.generatedKodeBarang(1);
        controllersss["nomerUrutLemari3"]!.text = "1";
        return;
      }

      int headerRow = -1;
      int kodeBarangIndex = -1;
      int nomerUrutIndex = -1;

      for (int r = 0; r < rows.length; r++) {
        for (int c = 0; c < rows[r].length; c++) {
          final value = rows[r][c].toString().trim().toLowerCase();
          if (value == "kode barang") {
            kodeBarangIndex = c;
            headerRow = r;
          }
          if (value == "no") {
            nomerUrutIndex = c;
            headerRow = r;
          }
        }

        if (kodeBarangIndex != -1 && nomerUrutIndex != -1) {
          break;
        }
      }

      int nextKode = 1;
      int nextUrut = 1;

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
        if (rows[i].length > nomerUrutIndex) {
          final nomor = int.tryParse(rows[i][nomerUrutIndex].trim());

          if (nomor != null) {
            nextUrut = nomor + 1;
            break;
          }
        }
      }
      controllersss["kodeBarangMasuk"]!.text = Functions.generatedKodeBarang(nextKode);
      controllersss["nomerUrutLemari3"]!.text = nextUrut.toString();

      if (kodeBarangIndex == -1 || nomerUrutIndex == -1) {
        debugPrint("Header tidak ditemukan");
        debugPrint("Header row yang terbaca:");
        for (int i = 0; i < rows.length && i < 5; i++) {
          debugPrint("Row $i : ${rows[i]}");
        }
        return;
      }
    } catch (e, s) {
      debugPrint("Error generate kode barang & nomor urut: $e");
      debugPrint("$s");
    }
  }

  Map<String, TextEditingController> createBarangMasukControllers() {

    return {
      "nomerUrutLemari1": TextEditingController(),
      "nomerUrutLemari2": TextEditingController(),
      "nomerUrutLemari3": TextEditingController(),

      "totalBarangMasukLemari1": TextEditingController(),
      "totalBarangKeluarLemari1": TextEditingController(),
      "totalJumlahAkhirLemari1": TextEditingController(),
      "jumlahMinimumBarangMasukLemari1": TextEditingController(),
      "statusBarangMasukLemari1": TextEditingController(),


      "totalBarangMasukLemari2": TextEditingController(),
      "totalBarangKeluarLemari2": TextEditingController(),
      "totalJumlahAkhirLemari2": TextEditingController(),
      "jumlahMinimumBarangMasukLemari2": TextEditingController(),
      "statusBarangMasukLemari2": TextEditingController(),

      "totalBarangMasukLemari3": TextEditingController(),
      "totalBarangKeluarLemari3": TextEditingController(),
      "totalJumlahAkhirLemari3": TextEditingController(),
      "jumlahMinimumBarangMasukLemari3": TextEditingController(),
      "statusBarangMasukLemari3": TextEditingController(),

      "nomerUrut": TextEditingController(),
      "kodeBarangMasuk": TextEditingController(),
      "tanggalBarangMasuk": TextEditingController(),
      "namaBarangMasuk": TextEditingController(),
      "jumlahBarangMasuk": TextEditingController(),
      "satuanBarangController": TextEditingController(),
      "picBarangMasuk": TextEditingController(),
      "lemariBarangMasuk": TextEditingController(),
      "keteranganBarangMasuk": TextEditingController()
    };
  }

  Future<void> getListsPosisiLemari() async {
    try {
      await GSheetsServicesEmployees.init();

      final results = await getDataLemari();

      if (!mounted) return;

      setState(() {
        lemariListings = results.map((data) {
          return DropDownListLemari(
            lemariposisi: data['PosisiLemari'] ?? '',
          );
        }).toList();
        isLoadingPosisi = false;
      });
    } catch (e) {
      debugPrint(
        'Error mengambil data posisi: $e',
      );

      if (!mounted) return;

      setState(() {
        isLoadingPosisi = false;
        lemariListings = [];
      });
    }
  }

  void removeRegistContainer() {
    if (revampBarangMasukControllerss.isEmpty) return;
    setState(() {
      final controllers = revampBarangMasukControllerss.removeLast();
      for (var controller in controllers.values) {
        controller.dispose();
      }
    });
  }

  @override
  void dispose() {
    for (var controllers in revampBarangMasukControllerss) {
      for (var controller in controllers.values) {
        controller.dispose();
      }
    }
    revampBarangMasukControllerss.clear();
    super.dispose();
  }


  void addNewsContainers() {
    final controllers = createBarangMasukControllers();
    setState(() {
      revampBarangMasukControllerss.add(controllers);
    });
  }

  Widget startBuildBarangMasukContainers(
      Map<String, TextEditingController> controlersss) {
    return Container(
      key: UniqueKey(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Masukan Barang",
                style: TextStyle(
                    color: Color.fromARGB(255, 8, 36, 87),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                onPressed: addNewsContainers,
                heroTag: null,
                backgroundColor: const Color.fromARGB(255, 8, 36, 87),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildsBarangMasukContainers(
      Map<String, TextEditingController> controllersss) {
    return Container(
      key: UniqueKey(),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black87)
                )
            ),
            child: TextFormField(
              controller: controllersss["tanggalBarangMasuk"],
              decoration: const InputDecoration(
                  labelText: "Tanggal Barang Masuk",
                  hintText: "Silahkan Masukan Tangg Barang Masuk",
                  hintStyle: TextStyle(color: Colors.black26),
                  border: InputBorder.none,
                  icon: Icon(Icons.calendar_today)),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDates = await showDatePicker(
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                              primary: Colors.lightBlue,
                              onPrimary: Colors.white,
                              onSurface: Colors.black),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.blueAccent),
                          ),
                        ),
                        child: child!,
                      );
                    },
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100));

                if (pickedDates != null) {
                  String formatedDates =
                  DateFormat('yyyy-MM-dd').format(pickedDates);
                  setState(() {
                    controllersss["tanggalBarangMasuk"]?.text = formatedDates;
                  });
                } else {}
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Tanggal Barang Masuk Tidak Boleh Kosong!";
                }
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black87))),
            child: TextFormField(
              controller: controllersss["namaBarangMasuk"],
              decoration: const InputDecoration(
                  labelText: "Nama Barang Masuk",
                  hintText: "Silahkan Masukan Nama Barang Masuk",
                  hintStyle: TextStyle(color: Colors.black26),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.note_add)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Nama Barang Masuk Tidak Boleh Kosong!";
                }
                return null;
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: 170,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black87),
                          ),
                        ),
                        child: TextFormField(
                          controller: controllersss["jumlahBarangMasuk"],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Jumlah",
                            hintText: "Jumlah",
                            hintStyle: TextStyle(color: Colors.black26),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.inventory_2),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Jumlah Barang Masuk Tidak Boleh Kosong!";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  )
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 170,
                          height: 75,
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black87),
                            ),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: controllersss["satuanBarangController"]!.text.isNotEmpty
                                ? controllersss["satuanBarangController"]!.text
                                : null,
                            hint: const Text("Pilih"),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            items: const [
                              DropdownMenuItem(value: "Satuan", child: Text("Satuan")),
                              DropdownMenuItem(value: "PCS", child: Text("PCS")),
                              DropdownMenuItem(value: "UNIT", child: Text("UNIT")),
                            ],
                            onChanged: (value) async {

                              await generateNoBarangMasuk(controllersss);
                              controllersss["picBarangMasuk"]!.text = sideBarFullNameController.text;
                              setState(() {
                                controllersss["satuanBarangController"]!.text = value ?? "";
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Pilih Satuan!";
                              }
                              return null;
                            },
                          )
                      ),
                    ],
                  )
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black87))),
            child: TextFormField(
              controller: controllersss["picBarangMasuk"],
              readOnly: true,
              decoration: const InputDecoration(
                  labelText: "PIC Barang Masuk",
                  hintText: "Silahkan Masukan PIC Barang Masuk",
                  hintStyle: TextStyle(color: Colors.black26),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.people)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "PIC Barang Masuk Tidak Boleh Kosong!";
                }
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black87,
                ),
              ),
            ),
            child: isLoadingPosisi ? const Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ),
            ) : DropdownButtonFormField<String>(
              value: lemariListings.map((posisi) => posisi.lemariposisi,)
                  .contains(controllersss["lemariBarangMasuk"]?.text,)
                  ? controllersss["lemariBarangMasuk"]?.text
                  : null,

              hint: const Text(
                "-- Pilih Lemari --",
                style: TextStyle(
                  color: Colors.black26,
                ),
              ),

              items: lemariListings.map((lemari) {
                return DropdownMenuItem<String>(
                  value: lemari.lemariposisi,
                  child: Text(
                    lemari.lemariposisi,
                  ),
                );
              }).toList(),

              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.work,
                ),
              ),

              onChanged: (value) async {
              if (value == null) return;
              controllersss["lemariBarangMasuk"]!.text = value;
              dropDownListLemari = value;
              if (value == "Lemari1") {
                await kodeBarangDanNomerUrutLemari1 (controllersss, GSheetsServicesEmployees.sheetsLemari1);
                controllersss["totalBarangMasukLemari1"]?.text = "0";
                controllersss["totalBarangKeluarLemari1"]?.text = "0";
                controllersss["jumlahMinimumBarangMasukLemari1"]?.text = "1";
                controllersss["totalJumlahAkhirLemari1"]?.text =
                    controllersss["jumlahBarangMasuk"]?.text ?? "0";
                updateStatusBarang(controllersss, "Lemari1");

              } else if (value == "Lemari2") {
                await kodeBarangDanNomerUrutLemari2 (controllersss, GSheetsServicesEmployees.sheetsLemari2);
                controllersss["totalBarangMasukLemari2"]?.text = "0";
                controllersss["totalBarangKeluarLemari2"]?.text = "0";
                controllersss["jumlahMinimumBarangMasukLemari2"]?.text = "1";
                controllersss["totalJumlahAkhirLemari2"]?.text =
                    controllersss["jumlahBarangMasuk"]?.text ?? "0";
                updateStatusBarang(controllersss, "Lemari2");

              } else if (value == "Lemari3") {
                await kodeBarangDanNomerUrutLemari3 (controllersss, GSheetsServicesEmployees.sheetsLemari3);
                controllersss["totalBarangMasukLemari3"]?.text = "0";
                controllersss["totalBarangKeluarLemari3"]?.text = "0";
                controllersss["jumlahMinimumBarangMasukLemari3"]?.text = "1";
                controllersss["totalJumlahAkhirLemari3"]?.text =
                    controllersss["jumlahBarangMasuk"]?.text ?? "0";
                updateStatusBarang(controllersss, "Lemari3");
              }
              if (mounted) setState(() {});
            },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Tolong Pilih Lokasi Lemari";
                }
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black87))),
            child: TextFormField(
              controller: controllersss["keteranganBarangMasuk"],
              decoration: const InputDecoration(
                  labelText: "Keterangan Barang Masuk",
                  hintText: "Silahkan Masukan Keterangan Barang Masuk",
                  hintStyle: TextStyle(color: Colors.black26),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.note)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Keterangan Barang Masuk Tidak Boleh Kosong!";
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            runSpacing: 5,
            children: [
              const Text(
                "Barang Masuk Lainya",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 8, 36, 87),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),

              FloatingActionButton(
                onPressed: addNewsContainers,
                heroTag: null,
                mini: true,
                backgroundColor: const Color.fromARGB(255, 8, 36, 87),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),

              FloatingActionButton(
                onPressed: removeRegistContainer,
                heroTag: null,
                mini: true,
                backgroundColor: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getListsPosisiLemari();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: revampBarangMasukKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (revampBarangMasukControllerss.isEmpty)
                startBuildBarangMasukContainers({})
              else
                ...revampBarangMasukControllerss.map(
                      (controllers) => buildsBarangMasukContainers(controllers),
                ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}