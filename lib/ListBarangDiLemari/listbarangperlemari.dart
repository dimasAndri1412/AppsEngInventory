import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/ListBarangDiLemari/detailbarangperlemari.dart';
import 'package:appsenginventory/MenuPages/navigationmenu.dart';
import 'package:appsenginventory/RevampBarangMasuk/revampbarangmasukpages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Services/gsheetscontrollers.dart';

class Listbarangperlemari extends StatefulWidget {
  const Listbarangperlemari({super.key});

  @override
  State<Listbarangperlemari> createState() => _ListbarangperlemariState();
}

class _ListbarangperlemariState extends State<Listbarangperlemari> {
  List<Map<String, String>> allBarang = [];
  List<Map<String, String>> filteredBarang = [];
  String selectedLemari = "Lemari1";
  final List<String> daftarLemari = [
    "Lemari1",
    "Lemari2",
    "Lemari3",
  ];

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadBarang();
  }

  Future<void> loadBarang() async {
    setState(() => isLoading = true);

    List<Map<String, String>> data = [];

    switch (selectedLemari) {
      case "Lemari1":
        data = await getListDataBarangLemari1();
        break;
      case "Lemari2":
        data = await getListDataBarangLemari2();
        break;
      case "Lemari3":
        data = await getListDataBarangLemari3();
        break;
    }

    setState(() {
      allBarang = data;
      filteredBarang = data;
      isLoading = false;
    });
  }

  void filterBarang(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredBarang = allBarang;
      } else {
        filteredBarang = allBarang.where((item) {
          return (item["Nama Barang"] ?? "")
              .toLowerCase()
              .contains(value.toLowerCase()) ||
              (item["Kode Barang"] ?? "")
                  .toLowerCase()
                  .contains(value.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 120,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff17346E),
                        Color(0xff2457A6),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                const Positioned(
                  top: 15,
                  left: 20,
                  right: 20,
                  child: Center(
                    child: Text(
                      "LIST BARANG",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  right: 20,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: filterBarang,
                      decoration: InputDecoration(
                        hintText: "Cari barang atau kode...",
                        border: InputBorder.none,
                        prefixIcon: IconButton(
                          onPressed: () {
                            Get.off(() => const NavigationMenuPages());
                          },
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),
                        suffixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: const Color(0xff2457A6),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedLemari,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    selectedItemBuilder: (BuildContext context) {
                      return daftarLemari.map((lemari) {
                        return Row(
                          children: [
                            const Icon(
                              Icons.warehouse,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              lemari,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      }).toList();
                    },
                    items: daftarLemari.map((lemari) {
                      return DropdownMenuItem<String>(
                        value: lemari,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.warehouse,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              lemari,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) async {
                      if (value == null) return;
                      setState(() {
                        selectedLemari = value;
                      });
                      await loadBarang();
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : filteredBarang.isEmpty
                  ? const Center(
                child: Text(
                  "Data barang tidak ditemukan",
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: filteredBarang.length,
                itemBuilder: (context, index) {
                  final barang = filteredBarang[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Get.to(
                            () => DetailBarang(barang: barang),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      margin:
                      const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding:
                        const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.inventory_2,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    barang["Nama Barang"] ?? "",
                                    style:
                                    const TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),

                                  const SizedBox(height: 3),

                                  Text(
                                    barang["Kode Barang"] ?? "",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Stok: ${barang["Stok Akhir"]} ${barang["Satuan"]}",
                                    style:
                                    const TextStyle(
                                      color: Colors.green,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color:
                                Colors.blue.shade50,
                                borderRadius:
                                BorderRadius.circular(
                                    20),
                              ),
                              child: Text(
                                barang["Lokasi"] ?? selectedLemari,
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontSize: 12,
                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff2457A6),
        onPressed: () {
          Get.to(() => const RevampBarangMasukPages());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}