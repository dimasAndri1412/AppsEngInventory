import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Functions extends StatelessWidget {
  const Functions({super.key});

  static String generatedEmployeeID(int sequence) {
    final now = DateTime.now();
    final date = DateFormat('yyyyMMdd').format(now);
    final sequenceNumber = sequence.toString().padLeft(4, '0');
    return '$date$sequenceNumber';
  }
  static String generatedKodeBarang(int sequence) {
    final sequenceNumber = sequence.toString().padLeft(2, '0');
    return 'ENG-$sequenceNumber';
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
