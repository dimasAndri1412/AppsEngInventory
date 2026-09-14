import 'package:appsenginventory/Controller/clearfunc.dart';
import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/HomePages/homepagesmenus.dart';
import 'package:appsenginventory/ListUsers/detailpersonalinformations.dart';
import 'package:appsenginventory/ListUsers/listmembers.dart';
import 'package:appsenginventory/ListUsers/settingpersonalinformations.dart';
import 'package:appsenginventory/MenuPages/headerscard.dart';
import 'package:appsenginventory/MenuPages/summarywrappers.dart';
import 'package:appsenginventory/Notifikasi/listnotifikasi.dart';
import 'package:appsenginventory/Services/gsheetscontrollers.dart';
import 'package:appsenginventory/Services/gsheetsinsertlogoutcontrollers.dart';
import 'package:appsenginventory/Services/notifikasicontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Services/gsheetscardcontrollers.dart';

class Menupages extends StatefulWidget {
  const Menupages({
    super.key,
  });

  @override
  State<Menupages> createState() => _MenupagesState();
}

class _MenupagesState extends State<Menupages> {
  bool isSidebarOpen = false;

  void toggleSidebar() {
    if (!mounted) return;

    setState(() {
      isSidebarOpen = !isSidebarOpen;
    });
  }

  void closeSidebar() {
    if (!mounted) return;

    if (isSidebarOpen) {
      setState(() {
        isSidebarOpen = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    sideBarPagesController();
    loadDashboardStokToController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.isRegistered<NotificationController>()) {
        Get.find<NotificationController>().refreshNotification();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.find<NotificationController>();

    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xff17346E),
        elevation: 0,

        leading: IconButton(
          onPressed: toggleSidebar,
          icon: Icon(
            isSidebarOpen ? Icons.close : Icons.menu,
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
          Obx(() {
            final jumlah =
                notificationController.notificationCount.value;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () async {
                    notificationController.notificationCount.value = 0;

                    await Get.to(() => const ListNotifikasi());

                    if (Get.isRegistered<NotificationController>()) {
                      await notificationController.refreshNotification();
                    }
                  },
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),

                if (jumlah > 0)
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          jumlah > 99
                              ? "99+"
                              : jumlah.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),
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
                onTap: closeSidebar,
                child: Container(
                  color: Colors.black.withOpacity(0.35),
                ),
              ),
            ),

          AnimatedPositioned(
            duration: const Duration(
              milliseconds: 300,
            ),
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

                        padding: const EdgeInsets.only(
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
                                fontWeight: FontWeight.bold,
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
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onTap: () {
                                final fullName = sideBarFullNameController.text;
                                closeSidebar();
                                Get.to(() => DetailPersonalUserPages( fullName: fullName),
                                );
                              },
                            ),

                            if (sideBarPosisiController.text.trim().toUpperCase() == "ADMIN")
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
                                  closeSidebar();
                                  Get.to(() => const ListUsersPages(),
                                  );
                                },
                              ),

                            const Divider(),

                            ListTile(
                              leading: const Icon(
                                Icons.settings,
                                color: Color(0xff17346E),
                              ),

                              title: const Text(
                                "Pengaturan",
                              ),

                              onTap: () {
                                final fullName = sideBarFullNameController.text;
                                final employeeID = sideBarEmployeeIDController.text;

                                closeSidebar();

                                Get.to(() => SettingsPersonalUserPages(fullName: fullName, employeeID: employeeID),
                                );
                              },
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
                              onTap: () async {
                                final shouldLogout = await _showConfirmDialog(context,);
                                if (shouldLogout == true) {
                                  closeSidebar();
                                  Get.offAll(() => const Homepagesmenus());
                                  await GsheetsInsertLogoutControllers().revampInsertLogOutControllers();
                                  ClearControllerFunc.clearControllers();
                                }
                              },
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

  Future<bool?> _showConfirmDialog(BuildContext context,) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.warning_amber,
            color: Colors.deepOrange,
          ),
          title: const Text(
            "Attentions!",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Kamu Yakin Ingin Keluar ?",
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text(
                "TIDAK",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text(
                "YA",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}