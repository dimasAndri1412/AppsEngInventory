import 'dart:math';
import 'package:flutter/material.dart';

class FunctionotpKeys extends StatelessWidget {
  const FunctionotpKeys({super.key});

  static String generatedOTP() {
    String numbers = '0123456789';
    String otp = "";
    int otpLength = 6;
    List<String> list = numbers.split('').toList();
    Random random = Random();

    for (int i = 0; i < otpLength; i++) {
      int index = random.nextInt(list.length);
      otp += list[index];
    }

    return otp;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}