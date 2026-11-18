import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddPictureDetailBarang/addpictwrapper.dart';


class DetailBarang extends StatefulWidget {
  final Map<String, String> barang;

  const DetailBarang({
    super.key,
    required this.barang,
  });

  @override
  State<DetailBarang> createState() => _DetailBarangState();
}

class _DetailBarangState extends State<DetailBarang> {
  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case "aman":
        return Colors.green;
      case "⚠ kurang":
      case "kurang":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = widget.barang["Status"] ?? "";

    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff17346E), Color(0xff2457A6)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: Get.back,
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                  const Expanded(
                    child: Text(
                      "Detail Barang",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    // PANGGIL WRAPPER DI SINI
                    AddPictDetailBarangWrapper(
                      barang: widget.barang,
                      onImageUpdated: (newUrl) {
                        setState(() {
                          widget.barang["Url Foto"] = newUrl;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    // Bagian informasi stok & keterangan lainnya...
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Stok Saat Ini", style: TextStyle(color: Colors.grey.shade600)),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${widget.barang["Stok Akhir"] ?? "0"} ",
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: widget.barang["Satuan"] ?? "",
                                      style: const TextStyle(color: Colors.black, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                decoration: BoxDecoration(
                                  color: statusColor(status).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: statusColor(status),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    infoRow("Lokasi", widget.barang["Lokasi"] ?? ""),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Keterangan", style: TextStyle(color: Colors.grey.shade600)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(widget.barang["Keterangan"] ?? "-"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: Text(title, style: TextStyle(color: Colors.grey.shade600))),
          Expanded(child: Text(value, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}