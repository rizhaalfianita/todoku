import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoku_app/constants.dart';
import 'package:todoku_app/views/home.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  height: 300,
                  width: double.infinity,
                  child: Image.asset("assets/images/task.png"),
                ),
                const SizedBox(height: 12.0),
                Column(
                  children: [
                    Text(
                      "Your Day, Simplified",
                      style: GoogleFonts.lexendDeca(
                          textStyle: const TextStyle(
                              color: black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Todoku helps you effortlessly organize your day, set priorities, and ensure you accomplish all your tasks.",
                      style: GoogleFonts.lexendDeca(
                          textStyle: const TextStyle(
                              color: black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(boxShadow: [shadow]),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => const Home()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                child: Text(
                  "Get Started",
                  style: GoogleFonts.lexendDeca(
                      textStyle: const TextStyle(
                          color: white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
