import 'package:appsenginventory/Login/loginpagemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Hompagesbuttons extends StatefulWidget {
  const Hompagesbuttons({super.key});

  @override
  State<Hompagesbuttons> createState() => _HompagesbuttonsState();
}

class _HompagesbuttonsState extends State<Hompagesbuttons> {
  bool isLoading = false;

  Future<void> startButton() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 800),
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    Get.to(() => const Loginpagemenus(),);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: isLoading
              ? null
              : () {
            startButton();
          },
          child: Container(
            height: 50,
            width: 300,
            margin: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            decoration: BoxDecoration(
              color: isLoading ? Colors.indigo.shade300
                  : Colors.indigo,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: isLoading ? const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              ) : const Text(
                'START',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}