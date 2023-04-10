import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackthehike/Screens/onboarding_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnBoardingScreen())));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              "images/logo_white.png",
              height: height * 0.3,
              fit: BoxFit.fitHeight,
            ),
            Text(
              "Hack The Hike",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            LottieBuilder.asset(
              "assets/hiking.json",
              height: height * 0.2,
              fit: BoxFit.fitHeight,
            ),
            const Spacer(),
            Text(
              "Developed with ❤️ by AUBBS",
              style: Theme.of(context).textTheme.labelSmall,
            )
          ],
        ),
      ),
    );
  }
}
