import 'package:flutter/material.dart';

class ButtonNavigatorPages extends StatefulWidget {
  const ButtonNavigatorPages({super.key});

  @override
  State<ButtonNavigatorPages> createState() => _ButtonNavigatorPagesState();
}

class _ButtonNavigatorPagesState extends State<ButtonNavigatorPages> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
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
