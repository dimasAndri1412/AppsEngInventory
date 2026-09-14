import 'package:appsenginventory/SendingEmail/sendingemailfunctions.dart';
import 'package:appsenginventory/Services/gsheetscontrollers.dart';
import 'package:flutter/material.dart';
import '../../Controller/key.dart';
import '../FunctionsOTP/functionsotp.dart';

class EmailOTPButtons extends StatefulWidget {
  const EmailOTPButtons({super.key});

  @override
  State<EmailOTPButtons> createState() => _EmailOTPButtonsState();
}

class _EmailOTPButtonsState extends State<EmailOTPButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[GestureDetector (
        onTap: () async {
          final otpcodes = FunctionotpKeys.generatedOTP();
          sendOTPControllers.text = otpcodes;
          final now = DateTime.now();
          final createTime =
              "${now.day.toString().padLeft(2, '0')}/"
              "${now.month.toString().padLeft(2, '0')}/"
              "${now.year} "
              "${now.hour.toString().padLeft(2, '0')}:"
              "${now.minute.toString().padLeft(2, '0')}:"
              "${now.second.toString().padLeft(2, '0')}";
          otpCreateTimes.text = createTime;

          if (!otpEmailKeys.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Validasi Email gagal!',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
          final result = await validationEmailOTP();

          if (result.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                'Email tidak ditemukan! OTP tidak dikirim.',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
          await const Sendingemailfunctions().sendingEmailOTPFunc();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Validasi Email Berhasil! OTP telah dikirim.',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              backgroundColor: Colors.green,
        ),
      );
    },
          child: Container(
              height: 50,
              width: 300,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'KIRIM OTP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              )
          ),
        )
      ],
    );
  }
}
