import 'package:appsenginventory/ListBarangDiLemari/listbarangperlemari.dart';
import 'package:appsenginventory/MenuPages/menupages.dart';
import 'package:appsenginventory/Reporting/reportingpages.dart';
import 'package:flutter/material.dart';
import '../RevampBarangKeluar/revampbarangkeluarpages.dart';

class NavigationMenuPages extends StatefulWidget {
  const NavigationMenuPages({super.key});

  @override
  State<NavigationMenuPages> createState() => _NavigationMenuPagesState();
}

class _NavigationMenuPagesState extends State<NavigationMenuPages> {

  int currentIndex = 0;

  final List<Widget> pages = const [
    Menupages(),
    Listbarangperlemari(),
    RevampBarangKeluarPages(),
    ReportingBarangPages()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff17346E),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Dashboard",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: "Barang",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "Keluar",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: "Laporan",
          ),
        ],
      ),
    );
  }
}
