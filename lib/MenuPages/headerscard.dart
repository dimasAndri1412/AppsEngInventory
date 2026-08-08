import 'dart:async';
import 'package:intl/intl.dart';
import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/Services/gsheetscontrollers.dart';
import 'package:flutter/material.dart';

class HeadersCard extends StatefulWidget {
  const HeadersCard({super.key});

  @override
  State<HeadersCard> createState() => _HeadersCardState();
}

class _HeadersCardState extends State<HeadersCard> {

  bool isLoading = true;
  DateTime now = DateTime.now();
  Timer? timers;

  @override
  void initState() {
    super.initState();
    loadHeaderPages();

    timers = Timer.periodic(const Duration(seconds: 1), (timers) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    timers?.cancel();
    super.dispose();
  }

  Future<void> loadHeaderPages() async {
    try {
      await headerPagesController();
    } catch (e) {
      debugPrint(
        'Gagal mengambil data header: $e',
      );

    } finally {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    String tanggal = DateFormat(
      'EEEE, dd MMMM yyyy',
      'id_ID',
    ).format(now);

    String jam = DateFormat(
      'HH:mm',
    ).format(now);

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
      child:  Row(
        children: [
           CircleAvatar(
            radius: 28,
            child: Icon(Icons.person,size:40),
          ),
           SizedBox(
               width:15
           ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [

                Text(
                  "Selamat Datang,",
                  style: TextStyle(fontSize:12),
                ),
                TextFormField(
                  controller: HomePagesUserNames,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black,
                  ),
                ),
                TextFormField(
                  controller: HomePagesPositions,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black
                  ),
                    decoration: InputDecoration(
                        border: InputBorder.none
                    )
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children:  [
              Text(
                tanggal,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                jam,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text("WIB")
            ],
          )
        ],
      ),
    );
  }
}
