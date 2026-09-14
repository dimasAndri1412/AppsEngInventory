import 'package:appsenginventory/Notifikasi/detailnotifikasi.dart';
import 'package:appsenginventory/Services/gsheetscontrollers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListNotifikasi extends StatefulWidget {
  const ListNotifikasi({super.key});

  @override
  State<ListNotifikasi> createState() => _ListNotifikasiState();
}

class _ListNotifikasiState extends State<ListNotifikasi> {
  List<Map<String, String>> allUsers = [];
  List<Map<String, String>> filteredUsers = [];

  bool isLoading = true;

  final TextEditingController searchController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadUsers() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      final data = await getListNotifikasi();

      if (!mounted) return;

      setState(() {
        allUsers = data;
        filteredUsers = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error loadUsers: $e");

      if (!mounted) return;

      setState(() {
        allUsers = [];
        filteredUsers = [];
        isLoading = false;
      });

      Get.snackbar(
        "Error",
        "Gagal mengambil data notifikasi",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void filterUsers(String value) {
    final search = value.toLowerCase().trim();

    setState(() {
      if (search.isEmpty) {
        filteredUsers = allUsers;
        return;
      }

      filteredUsers = allUsers.where((user) {
        final tanggalNotif = (user["Tanggal "] ?? "").toLowerCase();
        final picNotif = (user["PIC"] ?? "").toLowerCase();
        final lemariNotif = (user["Lemari"] ?? "").toLowerCase();
        final kodeBarangNotif = (user["KodeBarang"] ?? "").toLowerCase();
        final namaBarangNotif = (user["NamaBarang"] ?? "").toLowerCase();

        return tanggalNotif.contains(search) ||
            picNotif.contains(search) ||
            lemariNotif.contains(search) ||
            kodeBarangNotif.contains(search) ||
            namaBarangNotif.contains(search);
      }).toList();
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
                  height: 125,
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
                      "LIST NOTIFIKASI",
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
                      onChanged: filterUsers,
                      decoration: InputDecoration(
                        hintText: "Cari Tanggal, Lemari, PIC...",
                        border: InputBorder.none,
                        prefixIcon: IconButton(
                          onPressed: () {
                            Get.back();
                          },

                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                          ),
                        ),

                        suffixIcon: const Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(
                    Icons.notifications_none,
                    color: Color(0xff2457A6),
                  ),
                  const SizedBox(width: 8),
                  Text("${filteredUsers.length} Notifikasi",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: isLoading ? const Center(child: CircularProgressIndicator(),
              ) : filteredUsers.isEmpty ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_off,
                      size: 60,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Text("Data notifikasi tidak ditemukan",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ) : RefreshIndicator(onRefresh: loadUsers,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),

                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];
                    final tanggal = user["Tanggal"] ?? "";
                    final kodebarang = user["KodeBarang"] ?? "";
                    final namabarang = user["NamaBarang"] ?? "";
                    final jumlahbarang = user["JumlahBarang"] ?? "";
                    final satuan = user["Satuan"] ?? "";
                    final lemari = user["Lemari"] ?? "";
                    final pic = user["PIC"] ?? "";
                    final waktu = user["Waktu"] ?? "";
                    final keterangan = user["Keterangan"] ?? "";

                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Get.to(
                            DetailNotifikasi(
                                kodeBarang: kodebarang,
                                namaBarang: namabarang,
                                jumlahBarang: jumlahbarang,
                                satuan: satuan,
                                lemari: lemari,
                                pic: pic,
                                keterangan: keterangan,
                                tanggal: tanggal,
                                waktu: waktu )
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 58,
                                height: 58,
                                decoration: BoxDecoration(
                                  color: const Color(0xffEAF1FF),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(
                                  Icons.notifications,
                                  size: 32,
                                  color: Color(0xff2457A6),
                                ),
                              ),

                              const SizedBox(width: 13),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      kodebarang,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      namabarang,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      "Lemari: $lemari",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      "PIC: $pic",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      "Tanggal: $tanggal",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text("Waktu: $waktu",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}