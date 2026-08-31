import 'package:flutter/material.dart';

import 'summarycardpages.dart';

class SummaryWrapper extends StatefulWidget {
  const SummaryWrapper({super.key});

  @override
  State<SummaryWrapper> createState() => _SummaryWrapperState();
}

class _SummaryWrapperState extends State<SummaryWrapper> {
  String selectedLemari = "Lemari1";

  final List<String> daftarLemari = [
    "Lemari1",
    "Lemari2",
    "Lemari3",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: const Color(0xff2457A6),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedLemari,
                isExpanded: true,
                dropdownColor: Colors.white,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                selectedItemBuilder: (BuildContext context) {
                  return daftarLemari.map((lemari) {
                    return Row(
                      children: [
                        const Icon(
                          Icons.warehouse,
                          color: Colors.white,
                        ),

                        const SizedBox(width: 10),

                        Text(
                          lemari,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  }).toList();
                },

                items: daftarLemari.map((lemari) {
                  return DropdownMenuItem<String>(
                    value: lemari,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.warehouse,
                          color: Color(0xff17346E),
                        ),

                        const SizedBox(width: 10),

                        Text(
                          lemari,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),

                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    selectedLemari = value;
                  });
                },
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        SummaryCardPages(
          lemari: selectedLemari,
        ),
      ],
    );
  }
}