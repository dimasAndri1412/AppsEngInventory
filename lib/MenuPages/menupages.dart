import 'package:appsenginventory/MenuPages/buttonnavigator.dart';
import 'package:appsenginventory/MenuPages/chatcard.dart';
import 'package:appsenginventory/MenuPages/headerscard.dart';
import 'package:appsenginventory/MenuPages/summarycard.dart';
import 'package:flutter/material.dart';

class Menupages extends StatefulWidget {
  const Menupages({super.key});

  @override
  State<Menupages> createState() => _MenupagesState();
}

class _MenupagesState extends State<Menupages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xff17346E),
        elevation: 0,
        leading: const Icon(
            Icons.menu,
            color: Colors.white,
        ),
        title: const Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                ),
              ),
              Positioned(
                right: 10,
                top: 8,
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      "3",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const HeadersCard(),
              const SizedBox(height: 20),

              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  SummaryCard(
                    title: "Total Barang",
                    value: "1.250",
                    unit: "Item",
                    icon: Icons.inventory_2,
                    color: Colors.blue,
                  ),
                  SummaryCard(
                    title: "Total Barang",
                    value: "1.250",
                    unit: "Item",
                    icon: Icons.inventory_2,
                    color: Colors.blue,),
                  SummaryCard(
                    title: "Total Stok",
                    value: "3.456",
                    unit: "Pcs",
                    icon: Icons.all_inbox,
                    color: Colors.green,
                  ),
                  SummaryCard(
                    title: "Total Stok",
                    value: "3.456",
                    unit: "Pcs",
                    icon: Icons.all_inbox,
                    color: Colors.green,
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const ChatCard()
            ],
          ),
        ),
      )
    );
  }
}
