import 'dart:async';
import 'package:coupown/Auth/authgate.dart';
import 'package:flutter/material.dart';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/text_edit.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  double _progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Start the timer and update the progress every 0.03 seconds
    _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer timer) {
      setState(() {
        if (_progress < 1.0) {
          _progress += 0.01; // Increment the progress value
        } else {
          _progress = 1.0; // Ensure progress doesn't exceed 100%
          _timer?.cancel(); // Cancel the timer when progress is 100%
          // Navigate to the Register page
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Authgate()),);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  String get _percentageText => '${(_progress * 100).toInt()}%';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorPrimary,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/logo/Coupown.png",
                height: 250,
                width: 250,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Textedit(text: '0%', fontSize: 8, color: appColorAccent,),
                Textedit(text: _percentageText, color: appColorAccent, fontSize: 8,),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: iconColorSecondary,
                  color: appColorAccent,
                  borderRadius: BorderRadius.circular(16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Loading...",
              style: TextStyle(
                color: appColorAccent,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
