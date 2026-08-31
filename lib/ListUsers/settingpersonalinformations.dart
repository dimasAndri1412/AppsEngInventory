import 'package:appsenginventory/ChangesPasswordSettings/changespasssettingpages.dart';
import 'package:appsenginventory/ChangesPersonalSettings/changespersonalsettingpages.dart';
import 'package:appsenginventory/HomePages/homepagesmenus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Services/gsheetscontrollers.dart';

class SettingsPersonalUserPages extends StatefulWidget {
  final String fullName;
  final String employeeID;

  const SettingsPersonalUserPages({
    super.key,
    required this.fullName,
    required this.employeeID,
  });

  @override
  State<SettingsPersonalUserPages> createState() =>
      _SettingsPersonalUserPagesState();
}

class _SettingsPersonalUserPagesState
    extends State<SettingsPersonalUserPages> {

  Map<String, String>? userData;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getDetailUser();
  }

  Future<void> getDetailUser() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final users = await getListUsers();

      final matchingUsers = users.where((user) {
          final sheetFullName = (user["FullName"] ?? "").trim().toLowerCase();
          final sheetEmployeeID = (user["EmployeeID"] ?? "").trim();
          final loginFullName = widget.fullName.trim().toLowerCase();
          final loginEmployeeID = widget.employeeID.trim();

          return sheetFullName == loginFullName &&
              sheetEmployeeID == loginEmployeeID;
        },
      ).toList();

      if (matchingUsers.isNotEmpty) {
        setState(() {
          userData = matchingUsers.first;
          isLoading = false;
        });
      } else {
        setState(() {
          userData = null;
          isLoading = false;

          errorMessage =
          "Data akun tidak ditemukan.\n\n"
              "Full Name : ${widget.fullName}\n"
              "Employee ID : ${widget.employeeID}";
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Gagal mengambil data akun.\n\n$e";
      });
    }
  }

  Widget buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,

    Color iconColor = const Color(0xff2457A6),
    Color iconBackground = const Color(0xffEAF1FF),
  }) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.10),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),

        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: iconBackground,
            borderRadius: BorderRadius.circular(12),
          ),

          child: Icon(
            icon, color: iconColor,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(
            top: 3,
          ),

          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }


  void showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text(
                "Hapus Akun",
              ),
            ],
          ),

          content: const Text(
            "Apakah Anda yakin ingin ""menghapus akun Anda?\n\n"
                "Data akun yang sudah dihapus ""tidak dapat dikembalikan.",
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                "Batal",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                await deleteUser();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Data gagal diperbarui. ''EmployeeID atau Username tidak ditemukan.',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                  Get.to(() => const Homepagesmenus());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                "Hapus Akun",
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final fullName = userData?["FullName"] ?? widget.fullName;
    final employeeID = userData?["EmployeeID"] ?? widget.employeeID;
    final posisi = userData?["Posisi"] ?? "";

    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),
      body: SafeArea(
        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                20, 15, 20, 25,
              ),

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

              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            "PENGATURAN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Container(
                    width: 70,
                    height: 70,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                        ),
                      ],
                    ),

                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xff2457A6),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    fullName.isEmpty
                        ? "-"
                        : fullName,

                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(employeeID.isEmpty
                              ? "-"
                              : employeeID,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (posisi.isNotEmpty)
                        const SizedBox(
                          width: 8,
                        ),

                      if (posisi.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            posisi,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: isLoading
                  ? const Center(
                child:
                CircularProgressIndicator(
                  color: Color(0xff2457A6),
                ),
              )
                  : errorMessage != null
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_off_outlined,
                        size: 60,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: getDetailUser,
                        child: const Text("Coba Lagi",
                        ),
                      ),
                    ],
                  ),
                ),
              )

                  : ListView(
                padding: const EdgeInsets.all(16),
                children: [

                  const Padding(
                    padding: EdgeInsets.only(
                      left: 4,
                      bottom: 10,
                    ),
                    child: Text(
                      "Pengaturan Akun",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff17346E),
                      ),
                    ),
                  ),

                  buildSettingItem(
                    icon: Icons.person_outline,
                    title: "Data Diri",
                    subtitle: "Ubah informasi pribadi akun",
                    onTap: () {
                      Get.to(() => const ChangesPersonalSettingPages());
                    },
                  ),

                  buildSettingItem(
                    icon: Icons.lock_outline,
                    title: "Ganti Password",
                    subtitle: "Ubah password akun Anda",
                    onTap: () {
                      Get.to(() => const ChangesPassSettingPages());
                    },
                  ),

                  buildSettingItem(
                    icon: Icons.badge_outlined,
                    title: "Informasi Akun",
                    subtitle: "Lihat informasi akun Anda",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            title: const Text("Informasi Akun",
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Full Name",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),

                                const SizedBox(height: 3,),

                                Text(
                                  fullName.isEmpty
                                      ? "-"
                                      : fullName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 12,),

                                Text(
                                  "Employee ID",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),

                                const SizedBox(height: 3,),

                                Text( employeeID.isEmpty
                                      ? "-"
                                      : employeeID,

                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(
                                  height:
                                  12,
                                ),

                                Text(
                                  "Posisi / Role",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),

                                const SizedBox(height: 3),

                                Text(
                                  posisi.isEmpty
                                      ? "-"
                                      : posisi,

                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            actions: [
                              TextButton(onPressed:
                                    () {Navigator.pop(context);
                                },
                                child:
                                const Text("Tutup",
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 10,),

                  buildSettingItem(
                    icon: Icons.delete_outline,
                    title: "Hapus Akun",
                    subtitle: "Hapus akun dan data pribadi",
                    iconColor: Colors.red,
                    iconBackground: const Color(0xffffeeee),
                    onTap: () {
                      showDeleteAccountDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}