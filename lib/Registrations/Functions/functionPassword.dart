import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Services/gsheetsservices.dart';

class functionKeys  extends StatelessWidget {

  const functionKeys({super.key});

  static String generatedPassword() {

    String uppers  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String lowers  = 'abcdefghijklmnopqrstuvwxyz';
    String numbers = '123456789';
    String symbols = '!@#&*';

    String passwords = "";

    int passlenght = 10;

    String format = uppers + lowers + numbers + symbols;

    List<String> list = format.split('').toList();

    Random formatRandom = Random();

    for (int i = 0; i < passlenght; i++) {
      int index = formatRandom.nextInt(list.length);
      passwords += list[index];
    }
    return passwords;
  }

  static Future<String> generatedEmployeeID() async {
    try {
      await GSheetsServicesEmployees.init();
      final worksheet = GSheetsServicesEmployees.sheet;
      if (worksheet == null) {
        throw Exception('Worksheet DataEmployee tidak ditemukan.');
      }
      final rows = await worksheet.values.allRows();
      final String date = DateFormat('yyyyMMdd').format(DateTime.now());
      int sequence = 1;
      for (final row in rows) {
        if (row.isEmpty) continue;

        for (final value in row) {
          final employeeID = value.toString().trim();

          if (employeeID.startsWith(date) &&
              employeeID.length == 12) {

            final String sequenceString =
            employeeID.substring(8);

            final int? number =
            int.tryParse(sequenceString);

            if (number != null && number >= sequence) {
              sequence = number + 1;
            }
          }
        }
      }
      final String sequenceFormatted =
      sequence.toString().padLeft(4, '0');
      return '$date$sequenceFormatted';
    } catch (e) {
      debugPrint(
        'Error generate EmployeeID: $e',
      );

      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}