import 'package:flutter/material.dart';

class DetailUserPages extends StatelessWidget {
  final Map<String, String> user;

  const DetailUserPages({
    super.key,
    required this.user,
  });

  Widget buildDetailItem({
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
            color: Colors.grey.withOpacity(0.12),
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
              borderRadius:
              BorderRadius.circular(10),
            ),

            child: Icon(
              icon,
              color: const Color(0xff2457A6),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value.isEmpty ? "-" : value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
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
    final fullName = user["FullName"] ?? "";
    final posisi = user["Posisi"] ?? "";

    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 25,
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
                            "DETAIL MEMBER",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 80,
                    height: 80,
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
                      size: 45,
                      color: Color(0xff2457A6),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    fullName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      posisi.isEmpty
                          ? "-"
                          : posisi,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  buildDetailItem(
                    icon: Icons.badge_outlined,
                    title: "Employee ID",
                    value:
                    user["EmployeeID"] ?? "",
                  ),
                  buildDetailItem(
                    icon: Icons.person_outline,
                    title: "Full Name",
                    value:
                    user["FullName"] ?? "",
                  ),
                  buildDetailItem(
                    icon: Icons.account_circle_outlined,
                    title: "Username",
                    value:
                    user["UserName"] ?? "",
                  ),
                  buildDetailItem(
                    icon: Icons.work_outline,
                    title: "Posisi / Role",
                    value:
                    user["Posisi"] ?? "",
                  ),
                  buildDetailItem(
                    icon: Icons.email_outlined,
                    title: "Email",
                    value:
                    user["Email"] ?? "",
                  ),
                  buildDetailItem(
                    icon: Icons.phone_outlined,
                    title: "Nomor Telepon",
                    value:
                    user["NomerTelpon"] ?? "",
                  ),
                  buildDetailItem(
                    icon: Icons.cake_outlined,
                    title: "Tanggal Lahir",
                    value:
                    user["TanggalLahir"] ?? "",
                  ),
                  buildDetailItem(
                    icon: Icons.location_on_outlined,
                    title: "Alamat",
                    value:
                    user["Alamat"] ?? "",
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