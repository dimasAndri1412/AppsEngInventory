import 'package:appsenginventory/InventoryKeluar/inventoryoutpages.dart';
import 'package:appsenginventory/InventoryMasuk/inventorypages.dart';
import 'package:appsenginventory/MenuPages/menupages.dart';
import 'package:flutter/material.dart';

class ButtonNavigatorPages extends StatefulWidget {
  const ButtonNavigatorPages({super.key});

  @override
  State<ButtonNavigatorPages> createState() => _ButtonNavigatorPagesState();
}

class _ButtonNavigatorPagesState extends State<ButtonNavigatorPages> {

  int currentIndex = 0;
  List<Widget> body = const [
    Menupages(),
    InventoryPages(),
    InventoryOutPages()
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          icon: Icon(Icons.login),
          label: "Masuk",
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
    );
  }
}
