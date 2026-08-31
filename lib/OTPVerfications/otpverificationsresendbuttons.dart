import 'dart:async';
import 'package:appsenginventory/Controller/key.dart';
import 'package:appsenginventory/SendingEmail/sendingemailfunctions.dart';
import 'package:flutter/material.dart';

class OtpVerificationsResndButtons extends StatefulWidget {
  const OtpVerificationsResndButtons({super.key});

  @override
  State<OtpVerificationsResndButtons> createState() => _OtpVerificationsResndButtonsState();
}

class _OtpVerificationsResndButtonsState extends State<OtpVerificationsResndButtons> {

  int secondsRemainings = 90;
  bool enabledResend = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startCountDown();
  }

  void startCountDown() {
    enabledResend = false;
    secondsRemainings = 90;
    timer = Timer.periodic( const Duration(seconds: 1), (Timer timer) {
      if (secondsRemainings > 0) {
        setState(() {
          secondsRemainings--;
        });
      } else {
        setState(() {
          enabledResend = true;
          timer.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatTimes(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2,'0')}';
  }

  @override
  Widget build(BuildContext context) {

    String emails = otpemailcontroller.text;
    var nameUsers = emails.split("@");
    var emailChars = emails.replaceRange(2, nameUsers[0].length, "*" * (nameUsers[0].length - 2));
    String emaisValues = emailChars;

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: enabledResend ? () {
            startCountDown();
            const Sendingemailfunctions().reSendingEmailOTPFunc();
          } : null,
          child: Container(
              height: 50,
              width: 300,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  enabledResend
                      ? 'RESEND TO $emaisValues'
                      : 'RESEND IN ${formatTimes(secondsRemainings)}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),

                ),
              )
          ),
        )
      ],
    );
  }
}
