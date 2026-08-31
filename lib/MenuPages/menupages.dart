import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/ListUsers/detailpersonalinformations.dart';
import 'package:appsenginventory/ListUsers/listmembers.dart';
import 'package:appsenginventory/ListUsers/settingpersonalinformations.dart';
import 'package:appsenginventory/MenuPages/headerscard.dart';
import 'package:appsenginventory/MenuPages/summarywrappers.dart';
import 'package:appsenginventory/Services/gsheetscontrollers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Services/gsheetscardcontrollers.dart';

class Menupages extends StatefulWidget {
  const Menupages({super.key});

  @override
  State<Menupages> createState() => _MenupagesState();
}

class _MenupagesState extends State<Menupages> {

  bool isSidebarOpen = false;

  void toggleSidebar() {
    setState(() {
      isSidebarOpen = !isSidebarOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    sideBarPagesController();
    loadDashboardStokToController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xff17346E),
        elevation: 0,

        leading: IconButton(
          onPressed: toggleSidebar,

          icon: Icon(
            isSidebarOpen
                ? Icons.close
                : Icons.menu,

            color: Colors.white,
          ),
        ),

        title: const Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
              ),
            ],
          ),
        ],
      ),

      body: Stack(
        children: [

          const SingleChildScrollView(

            child: Padding(
              padding: EdgeInsets.all(15),

              child: Column(
                children: [
                   HeadersCard(),
                   SizedBox(height: 20),
                   SummaryWrapper(),
                   SizedBox(height: 20),
                ],
              ),
            ),
          ),

          if (isSidebarOpen)

            Positioned.fill(
              child: GestureDetector(
                onTap: toggleSidebar,
                child: Container(
                  color:
                  Colors.black.withOpacity(0.35),
                ),
              ),
            ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: isSidebarOpen ? 0 : -280,
            top: 0,
            bottom: 0,
            width: 280,
            child: Material(
              elevation: 10,
              child: SafeArea(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [

                      Container(
                        width: double.infinity,

                        padding:
                        const EdgeInsets.only(
                          top: 20,
                          bottom: 15,
                          left: 20,
                          right: 20,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xff17346E),
                        ),

                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),

                              child: const Icon(
                                Icons.person,
                                color: Color(0xff17346E),
                                size: 35,
                              ),
                            ),

                            const SizedBox(height: 10),

                            TextFormField(
                              controller: sideBarFullNameController,
                              readOnly: true,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight:
                                FontWeight.bold,
                              ),

                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),

                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xff17346E),
                                  ),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            TextFormField(
                              controller: sideBarJabatanController,
                              readOnly: true,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.work,
                                  color: Colors.white,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xff17346E),
                                  ),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),

                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            const SizedBox(height: 5),

                            ListTile(
                              leading: const Icon(
                                Icons.person,
                                color: Color(0xff17346E),
                              ),

                              title: const Text(
                                "Detail Pribadi",
                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),
                              onTap: () {
                                final fullName = sideBarFullNameController.text;
                                Get.to(() => DetailPersonalUserPages(fullName: fullName));
                              },
                            ),

                            if (sideBarPosisiController.text.toUpperCase() == "ADMIN")
                              ListTile(
                                leading: const Icon(
                                  Icons.dashboard,
                                  color: Color(0xff17346E),
                                ),
                                title: const Text(
                                  "List Members",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onTap: () {
                                  Get.to(() => const ListUsersPages());
                                },
                              ),

                            const Divider(),

                            ListTile(
                              leading: const Icon(
                                Icons.settings,
                                color: Color(0xff17346E),
                              ),
                              title:
                              const Text(
                                "Pengaturan",
                              ),
                              onTap: () {
                                final fullName = sideBarFullNameController.text;
                                final employeeID = sideBarEmployeeIDController.text;
                                Get.to(() => SettingsPersonalUserPages(
                                    fullName: fullName, employeeID: employeeID));
                              }
                            ),


                            ListTile(
                              leading: const Icon(
                                Icons.logout,
                                color: Colors.red,
                              ),
                              title: const Text(
                                "Logout",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              onTap:
                              toggleSidebar,
                            ),
                          ],
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "AppsEng Inventory",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}