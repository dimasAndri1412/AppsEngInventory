import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Services/gsheetscontrollers.dart';
import 'detailusers.dart';


class ListUsersPages extends StatefulWidget {
  const ListUsersPages({super.key});

  @override
  State<ListUsersPages> createState() => _ListUsersPagesState();
}

class _ListUsersPagesState extends State<ListUsersPages> {
  List<Map<String, String>> allUsers = [];
  List<Map<String, String>> filteredUsers = [];
  bool isLoading = true;
  final TextEditingController searchController = TextEditingController();
  String currentRole = "ADMIN";

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
    setState(() {
      isLoading = true;
    });

    try {
      final data = await getListUsers();
      List<Map<String, String>> result = [];
      if (currentRole.toUpperCase() == "ADMIN") {
        result = data;
      }
      else {
        result = data.where((user) {
          return (user["Posisi"] ?? "").toUpperCase() == "MEMBER";
        }).toList();
      }
      if (!mounted) return;

      setState(() {
        allUsers = result;
        filteredUsers = result;
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
        "Error", "Gagal mengambil data user",
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
        final employeeID = (user["EmployeeID"] ?? "").toLowerCase();
        final fullName = (user["FullName"] ?? "").toLowerCase();
        final username = (user["UserName"] ?? "").toLowerCase();
        final email = (user["Email"] ?? "").toLowerCase();
        final posisi = (user["Posisi"] ?? "").toLowerCase();

        return employeeID.contains(search) ||
            fullName.contains(search) ||
            username.contains(search) ||
            email.contains(search) ||
            posisi.contains(search);
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
                      "LIST MEMBER",
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
                      borderRadius:
                      BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: filterUsers,
                      decoration: InputDecoration(
                        hintText: "Cari nama, ID, username...",
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
                    Icons.people_alt_outlined,
                    color: Color(0xff2457A6),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${filteredUsers.length} Member",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  if (currentRole.toUpperCase() == "ADMIN")
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "ADMIN",
                        style: TextStyle(
                          color: Color(0xff2457A6),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : filteredUsers.isEmpty
                  ? const Center(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_search,
                      size: 60,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Data member tidak ditemukan",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )

                  : RefreshIndicator(onRefresh: loadUsers,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),

                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];
                    final fullName = user["FullName"] ?? "";
                    final employeeID = user["EmployeeID"] ?? "";
                    final username = user["UserName"] ?? "";
                    final posisi = user["Posisi"] ?? "";
                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Get.to(() => DetailUserPages(
                            user: user,
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        margin: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            16,),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(13),

                          child: Row(
                            children: [
                              Container(
                                width: 58,
                                height: 58,
                                decoration: BoxDecoration(
                                  color: const Color(0xffEAF1FF,),
                                  borderRadius: BorderRadius.circular(14),
                                ),

                                child: const Icon(
                                  Icons.person,
                                  size: 32,
                                  color: Color(
                                    0xff2457A6,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 13),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      fullName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(employeeID,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text("@$username",
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

                              const SizedBox(width: 8),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),

                                decoration: BoxDecoration(
                                  color: posisi.toUpperCase() == "ADMIN" ? Colors.orange
                                      .shade50 : Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  posisi.isEmpty
                                      ? "-"
                                      : posisi,

                                  style: TextStyle(
                                    color: posisi.toUpperCase() ==
                                        "ADMIN" ? Colors.orange.shade700
                                        : Colors.blue.shade700,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
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