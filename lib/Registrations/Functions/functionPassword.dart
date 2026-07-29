import 'dart:math';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}