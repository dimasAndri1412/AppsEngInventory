import 'package:flutter/material.dart';

class HeadersCard extends StatefulWidget {
  const HeadersCard({super.key});

  @override
  State<HeadersCard> createState() => _HeadersCardState();
}

class _HeadersCardState extends State<HeadersCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.15),
            blurRadius: 10,
          )
        ],
      ),
      child: const Row(
        children: [

           CircleAvatar(
            radius: 28,
            child: Icon(Icons.person,size:40),
          ),

           SizedBox(width:15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [

                Text(
                  "Selamat Datang,",
                  style: TextStyle(fontSize:12),
                ),

                SizedBox(height:5),

                Text(
                  "Aji Fredy",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:22),
                ),

                Text("Chief Engineering"),
              ],
            ),
          ),

          Column(
            children:  [

              Text("Kamis,23 Mei 2024"),

              SizedBox(height:10),

              Text(
                "10:30",
                style: TextStyle(
                    fontSize:32,
                    fontWeight: FontWeight.bold),
              ),

              Text("WIB"),
            ],
          )

        ],
      ),
    );
  }
}
