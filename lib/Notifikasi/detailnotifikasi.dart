import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailNotifikasi extends StatelessWidget {
  final String kodeBarang;
  final String namaBarang;
  final String jumlahBarang;
  final String satuan;
  final String lemari;
  final String pic;
  final String keterangan;
  final String tanggal;
  final String waktu;

  const DetailNotifikasi({
    super.key,
    required this.kodeBarang,
    required this.namaBarang,
    required this.jumlahBarang,
    required this.satuan,
    required this.lemari,
    required this.pic,
    required this.keterangan,
    required this.tanggal,
    required this.waktu,
  });

  Widget detailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xffEAF1FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xff2457A6),
              size: 22,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value.isEmpty ? "-" : value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),

      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
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

              child: Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: 10,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const Positioned(
                    left: 60,
                    right: 60,
                    top: 20,
                    child: Center(
                      child: Text(
                        "DETAIL NOTIFIKASI",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 12,
                    child: Text(kodeBarang.isEmpty
                          ? "Notifikasi Barang"
                          : kodeBarang,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 85,
                        height: 85,
                        decoration: BoxDecoration(
                          color: const Color(0xffEAF1FF),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Icon(
                          Icons.notifications_active,
                          size: 45,
                          color: Color(0xff2457A6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Center(
                      child: Text(
                        "Informasi Barang",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    detailItem(
                      icon: Icons.qr_code,
                      title: "Kode Barang",
                      value: kodeBarang,
                    ),
                    detailItem(
                      icon: Icons.inventory_2,
                      title: "Nama Barang",
                      value: namaBarang,
                    ),
                    detailItem(
                      icon: Icons.numbers,
                      title: "Jumlah Barang",
                      value: jumlahBarang,
                    ),
                    detailItem(
                      icon: Icons.straighten,
                      title: "Satuan",
                      value: satuan,
                    ),
                    detailItem(
                      icon: Icons.inventory,
                      title: "Lemari",
                      value: lemari,
                    ),
                    detailItem(
                      icon: Icons.person,
                      title: "PIC",
                      value: pic,
                    ),
                    detailItem(
                      icon: Icons.description,
                      title: "Keterangan",
                      value: keterangan,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Waktu Notifikasi",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    detailItem(
                      icon: Icons.calendar_today,
                      title: "Tanggal",
                      value: tanggal,
                    ),
                    detailItem(
                      icon: Icons.access_time,
                      title: "Waktu",
                      value: waktu,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}