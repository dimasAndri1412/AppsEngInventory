import 'package:appsenginventory/RevampBarangKeluar/MaterialBarangKeluar/dropdownlistlemaribarangkeluar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Controller/key.dart';
import '../Services/gsheetscontrollers.dart';
import '../Services/gsheetsservices.dart';

class RevampBarangKeluarField extends StatefulWidget {
  const RevampBarangKeluarField({super.key});

  @override
  State<RevampBarangKeluarField> createState() => _RevampBarangKeluarFieldState();
}

class _RevampBarangKeluarFieldState extends State<RevampBarangKeluarField> {

  String? dropDownValues;
  String? dropDownListLemariBarangKeluar;
  List<Map<String, String>> daftarBarangAktif = [];
  String? selectedBarang;
  int nextNoBarangKeluar = 1;
  List<Widget> addtionalBarangContainers = [];
  List<DropDownListLemariBarangKeluar> lemariposisiBarangKeluar = [];
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

  void hitungStockAkhir(Map<String, TextEditingController> controllersss,) {
    final stockAwal = int.tryParse(controllersss["stockawalBarangkeluar"]?.text ?? "0") ?? 0;
    final jumlahKeluar = int.tryParse(controllersss["jumlahBarangKeluar"]?.text ?? "0") ?? 0;
    final stockAkhir = stockAwal - jumlahKeluar;

    controllersss["stockAkhirBarangKeluar"]?.text = stockAkhir.toString();
  }

  Future<void> generateNoBarangKeluar(Map<String, TextEditingController> controllersss,) async {

    final index = revampBarangKeluarControllerss.indexOf(controllersss);
    final noUrut = index == -1
        ? revampBarangKeluarControllerss.length + 1
        : index + 1;

    if ((controllersss["tanggalBarangKeluar"]?.text ?? "").isNotEmpty) {
      controllersss["nomerUrutBarangKeluar"]?.text = noUrut.toString();
    } else {
      controllersss["nomerUrutBarangKeluar"]?.clear();
    }
  }

  Map<String, TextEditingController> createBarangKeluarControllers() {

    return {

      "nomerUrutBarangKeluar": TextEditingController(),
      "kodeBarangKeluar": TextEditingController(),
      "tanggalBarangKeluar": TextEditingController(),
      "namaBarangKeluar": TextEditingController(),
      "jumlahBarangKeluar": TextEditingController(),
      "satuanBarangKeluar": TextEditingController(),
      "picBarangKeluar": TextEditingController(),
      "lemariBarangKeluar": TextEditingController(),
      "keteranganBarangKeluar": TextEditingController(),
      "stockawalBarangkeluar": TextEditingController(),
      "totalMasukBarangKeluar": TextEditingController(),
      "totalKeluarBarangKeluar": TextEditingController(),
      "stockAkhirBarangKeluar": TextEditingController(),
    };
  }

  Future<void> getListsPosisiLemari() async {
    try {
      await GSheetsServicesEmployees.init();

      final results = await getDataLemari();

      if (!mounted) return;

      setState(() {
        lemariposisiBarangKeluar = results.map((data) {
          return DropDownListLemariBarangKeluar(
            lemariposisiBarangKeluar: data['PosisiLemari'] ?? '',
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
        lemariposisiBarangKeluar = [];
      });
    }
  }

  Future<void> getdataLemari1() async {
    try {
      await GSheetsServicesEmployees.init();

      final results = await getDataBarangLemari1();

      if (!mounted) return;

      setState(() {
        daftarBarangAktif = results;
        selectedBarang = null;
      });
    } catch (e) {
      setState(() {
        daftarBarangAktif = [];
      });
    }
  }


  Future<void> getdataLemari2() async {
    try {
      await GSheetsServicesEmployees.init();

      final results = await getDataBarangLemari2();

      if (!mounted) return;

      setState(() {
        daftarBarangAktif = results;
        selectedBarang = null;
      });
    } catch (e) {
      setState(() {
        daftarBarangAktif = [];
      });
    }
  }

  Future<void> getdataLemari3() async {
    try {
      await GSheetsServicesEmployees.init();

      final results = await getDataBarangLemari3();

      if (!mounted) return;

      setState(() {
        daftarBarangAktif = results;
        selectedBarang = null;
      });
    } catch (e) {
      setState(() {
        daftarBarangAktif = [];
      });
    }
  }


  void removeRegistContainer() {
    if (revampBarangKeluarControllerss.isEmpty) return;
    setState(() {
      final controllers = revampBarangKeluarControllerss.removeLast();
      for (var controller in controllers.values) {
        controller.dispose();
      }
    });
  }

  @override
  void dispose() {
    for (var controllers in revampBarangKeluarControllerss) {
      for (var controller in controllers.values) {
        controller.dispose();
      }
    }
    revampBarangKeluarControllerss.clear();
    super.dispose();
  }


  void addNewsContainers() {
    final controllers = createBarangKeluarControllers();
    setState(() {
      revampBarangKeluarControllerss.add(controllers);
    });
  }

  Widget startBuildBarangKeluarContainers(Map<String, TextEditingController> controlersss) {
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
                "Masukan Barang Keluar",
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

  Widget buildsBarangKeluarContainers(
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
              controller: controllersss["tanggalBarangKeluar"],
              decoration: const InputDecoration(
                  labelText: "Tanggal Barang Keluar",
                  hintText: "Silahkan Masukan Tangg Barang Keluar",
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
                    controllersss["tanggalBarangKeluar"]?.text = "'$formatedDates";
                  });
                } else {}
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Tanggal Barang Keluar Tidak Boleh Kosong!";
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
              value: lemariposisiBarangKeluar.map((posisi) => posisi.lemariposisiBarangKeluar,)
                  .contains(controllersss["lemariBarangKeluar"]?.text,)
                  ? controllersss["lemariBarangKeluar"]?.text
                  : null,

              hint: const Text(
                "-- Pilih Lemari --",
                style: TextStyle(
                  color: Colors.black26,
                ),
              ),

              items: lemariposisiBarangKeluar.map((lemari) {
                return DropdownMenuItem<String>(
                  value: lemari.lemariposisiBarangKeluar,
                  child: Text(
                    lemari.lemariposisiBarangKeluar,
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

                controllersss["lemariBarangKeluar"]!.text = value;
                dropDownListLemariBarangKeluar = value;
                if (value == "Lemari1") {
                  controllersss["kodeBarangKeluar"]?.clear();
                  await getdataLemari1();
                } else if (value == "Lemari2") {
                  controllersss["kodeBarangKeluar"]?.clear();
                  await getdataLemari2();
                } else if (value == "Lemari3") {
                  controllersss["kodeBarangKeluar"]?.clear();
                  await getdataLemari3();
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Tolong Pilih Lokasi Lemari";
                }
                return null;
              },
            ),
          ),
          DropdownButtonFormField<String>(
            isExpanded: true,
            value: daftarBarangAktif.any((e) => e["Nama Barang"] == selectedBarang)
                ? selectedBarang
                : null,
            hint: const Text("-- Pilih Barang --"),
            items: daftarBarangAktif.map((barang) {
              return DropdownMenuItem<String>(
                value: barang["Nama Barang"],
                child: Text(
                  barang["Nama Barang"] ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              );
            }).toList(),
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.book),
            ),
              onChanged: (value) async {

                if (value == null) return;
                final barangDipilih = daftarBarangAktif.firstWhere(
                      (e) => e["Nama Barang"] == value,
                );
                setState(() {
                  selectedBarang = value;
                  controllersss["namaBarangKeluar"]?.text = barangDipilih["Nama Barang"] ?? "";
                  controllersss["kodeBarangKeluar"]?.text = barangDipilih["Kode Barang"] ?? "";
                  controllersss["satuanBarangKeluar"]?.text = barangDipilih["Satuan"] ?? "";
                  controllersss["stockawalBarangkeluar"]?.text = barangDipilih["Stok Awal"] ?? "";
                  controllersss["stockAkhirBarangKeluar"]?.text = barangDipilih["Stok Akhir"] ?? "";
                  controllersss["picBarangKeluar"]?.text = sideBarFullNameController.text;
                });
              },
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black87))),
            child: TextFormField(
              controller: controllersss["kodeBarangKeluar"],
              readOnly: true,
              decoration: const InputDecoration(
                  labelText: "Kode Barang Keluar",
                  hintText: "Silahkan Masukan Kode Barang Keluar",
                  hintStyle: TextStyle(color: Colors.black26),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.people)),
              onChanged: (value) async {
                await generateNoBarangKeluar(controllersss);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Kode Barang Keluar Tidak Boleh Kosong!";
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
                          controller: controllersss["jumlahBarangKeluar"],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Jumlah",
                            hintText: "Jumlah",
                            hintStyle: TextStyle(color: Colors.black26),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.inventory_2),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              hitungStockAkhir(controllersss);
                              print(controllersss["stockAkhirBarangKeluar"]?.text);
                            }
                          },
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
                        padding: const EdgeInsets.all(5),
                        width: 170,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black87),
                          ),
                        ),
                        child: TextFormField(
                          readOnly: true,
                          controller: controllersss["satuanBarangKeluar"],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Satuan",
                            hintText: "Satuan",
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
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black87))),
            child: TextFormField(
              controller: controllersss["picBarangKeluar"],
              decoration: const InputDecoration(
                labelText: "PIC Barang Keluar",
                hintText: "Silahkan Masukan PIC Barang Keluar",
                hintStyle: TextStyle(color: Colors.black26),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.people),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "PIC Barang Keluar Tidak Boleh Kosong!";
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
              controller: controllersss["keteranganBarangKeluar"],
              decoration: const InputDecoration(
                  labelText: "Keterangan Barang Keluar",
                  hintText: "Silahkan Masukan Keterangan Barang Keluar",
                  hintStyle: TextStyle(color: Colors.black26),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.note)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Keterangan Barang Keluar Tidak Boleh Kosong!";
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
                "Barang Keluar Lainya",
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
    return  Scaffold(
      body: Form(
        key: revampBarangKeluarkKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (revampBarangKeluarControllerss.isEmpty)
                startBuildBarangKeluarContainers({})
              else
                ...revampBarangKeluarControllerss.map(
                      (controllers) => buildsBarangKeluarContainers(controllers),
                ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
