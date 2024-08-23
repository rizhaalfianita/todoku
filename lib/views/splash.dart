import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoku_app/constants.dart';
import 'package:todoku_app/views/landing.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Landing())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Todo",
                style: GoogleFonts.lexendDeca(
                    textStyle: const TextStyle(
                        fontSize: 20.0,
                        color: black,
                        fontWeight: FontWeight.w500))),
            TextSpan(
                text: "ku",
                style: GoogleFonts.lexendDeca(
                    textStyle: const TextStyle(
                        fontSize: 20.0,
                        color: orange,
                        fontWeight: FontWeight.w500)))
          ]),
        ),
      ),
    );
  }
}
