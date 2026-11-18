import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/ListBarangDiLemari/detailbarangperlemari.dart';
import 'package:appsenginventory/RevampBarangMasuk/revampbarangmasukpages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Services/gsheetscontrollers.dart';
import '../Services/gsheetsdeletebarang.dart';

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
    setState(() {
      isLoading = true;
    });

    List<Map<String, String>> data = [];

    try {
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

      if (!mounted) return;

      setState(() {
        allBarang = data;
        filteredBarang = data;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        allBarang = [];
        filteredBarang = [];
        isLoading = false;
      });

      Get.snackbar(
        "Error",
        "Gagal mengambil data barang: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
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

  // ============================================================
  // KONFIRMASI DELETE BARANG
  // ============================================================

  Future<void> confirmDeleteBarang(
      Map<String, String> barang,
      ) async {
    final String kodeBarang =
        barang["Kode Barang"]?.trim() ?? "";

    final String namaBarang =
        barang["Nama Barang"]?.trim() ?? "";

    final String lemari =
    selectedLemari.trim();

    if (kodeBarang.isEmpty) {
      Get.snackbar(
        "Gagal",
        "Kode barang tidak ditemukan.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      return;
    }

    final bool? konfirmasi = await Get.dialog<bool>(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
            ),
            SizedBox(width: 10),
            Text("Hapus Barang"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Apakah Anda yakin ingin menghapus barang ini?",
              style: TextStyle(
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaBarang,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Kode: $kodeBarang",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    "Lokasi: $lemari",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Data yang dihapus tidak dapat dikembalikan.",
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: const Text(
              "BATAL",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),

          ElevatedButton.icon(
            onPressed: () {
              Get.back(result: true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(
              Icons.delete,
              size: 18,
            ),
            label: const Text("HAPUS"),
          ),
        ],
      ),
    );

    if (konfirmasi != true) {
      return;
    }

    await deleteBarang(
      kodeBarang: kodeBarang,
      lemari: lemari,
    );
  }

  // ============================================================
  // DELETE BARANG
  // ============================================================

  Future<void> deleteBarang({
    required String kodeBarang,
    required String lemari,
  }) async {
    // Tampilkan loading kecil
    Get.dialog(
      const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 15),
                Text(
                  "Menghapus barang...",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );

    try {
      final bool berhasil =
      await deleteBarangBerdasarkanKodeDanLemari(
        kodeBarang: kodeBarang,
        lemari: lemari,
      );

      // Tutup loading
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      if (berhasil) {
        Get.snackbar(
          "Berhasil",
          "Barang $kodeBarang berhasil dihapus dari $lemari.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Refresh daftar barang
        await loadBarang();
      } else {
        Get.snackbar(
          "Gagal",
          "Barang dengan kode $kodeBarang tidak ditemukan.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Tutup loading jika masih terbuka
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat menghapus barang: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),

      body: SafeArea(
        child: Column(
          children: [
            // ====================================================
            // HEADER
            // ====================================================
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
                      decoration: const InputDecoration(
                        hintText: "Cari barang atau kode...",
                        border: InputBorder.none,
                        suffixIcon:  Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ====================================================
            // DROPDOWN LEMARI
            // ====================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
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

                    selectedItemBuilder:
                        (BuildContext context) {
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

            // ====================================================
            // LIST BARANG
            // ====================================================

            Expanded(
              child: isLoading ? const Center(
                child: CircularProgressIndicator(),
              ) : filteredBarang.isEmpty ? const Center(
                child: Text(
                  "Data barang tidak ditemukan",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ) : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                itemCount: filteredBarang.length,
                itemBuilder:
                    (context, index) {
                  final barang = filteredBarang[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(15),

                    onTap: () {
                      Get.to(
                            () => DetailBarang(
                          barang: barang,
                        ),
                      );
                    },

                    child: Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(
                        bottom: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(
                          12,
                        ),

                        child: Row(
                          children: [
                            // ==================================
                            // ICON / FOTO BARANG INVENTORY
                            // ==================================
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: (barang["Url Foto"] != null && barang["Url Foto"]!.isNotEmpty) ? Image.network(
                                  barang["Url Foto"]!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.inventory_2,
                                      size: 30,
                                      color: Colors.grey,
                                    );
                                  },
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                    );
                                  },
                                ) : const Icon(
                                  Icons.inventory_2,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            // ==================================
                            // INFORMASI BARANG
                            // ==================================

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Row(
                                    children: [
                                      // NAMA BARANG
                                      Expanded(
                                        child: Text(
                                          barang[
                                          "Nama Barang"] ??
                                              "",
                                          maxLines: 2,
                                          overflow:
                                          TextOverflow
                                              .ellipsis,
                                          style:
                                          const TextStyle(
                                            fontWeight:
                                            FontWeight
                                                .bold,
                                            fontSize:
                                            15,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 5,
                                      ),

                                      // ==================================
                                      // TOMBOL TONG SAMPAH
                                      // ==================================

                                      IconButton(
                                        tooltip:
                                        "Hapus barang",
                                        padding:
                                        EdgeInsets
                                            .zero,
                                        constraints:
                                        const BoxConstraints(
                                          minWidth: 40,
                                          minHeight:
                                          40,
                                        ),
                                        onPressed: () {
                                          confirmDeleteBarang(
                                            barang,
                                          );
                                        },
                                        icon:
                                        const Icon(
                                          Icons
                                              .delete_outline,
                                          color:
                                          Colors.red,
                                          size: 25,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 3,
                                  ),

                                  Text(
                                    barang[
                                    "Kode Barang"] ??
                                        "",
                                    style: TextStyle(
                                      color: Colors
                                          .grey
                                          .shade600,
                                      fontSize: 12,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 8,
                                  ),

                                  Text(
                                    "Stok: ${barang["Stok Akhir"]} ${barang["Satuan"]}",
                                    style:
                                    const TextStyle(
                                      color:
                                      Colors.green,
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              width: 8,
                            ),

                            // ==================================
                            // LOKASI LEMARI
                            // ==================================

                            Container(
                              padding:
                              const EdgeInsets
                                  .symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration:
                              BoxDecoration(
                                color: Colors
                                    .blue.shade50,
                                borderRadius:
                                BorderRadius
                                    .circular(
                                  20,
                                ),
                              ),
                              child: Text(
                                barang["Lokasi"] ??
                                    selectedLemari,
                                style: TextStyle(
                                  color: Colors
                                      .blue
                                      .shade700,
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

      // ==========================================================
      // FLOATING ACTION BUTTON
      // ==========================================================

      floatingActionButton:
      FloatingActionButton(
        backgroundColor: const Color(0xff2457A6),

        onPressed: () {
          Get.to(
                () => const RevampBarangMasukPages(),
          );
        },

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}