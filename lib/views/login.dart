import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoku_app/constants.dart';
import 'package:todoku_app/widgets/custom_button_with_icon.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(top: 48, left: 24, bottom: 32, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Todo",
                  style: GoogleFonts.lexendDeca(
                    textStyle: const TextStyle(
                        fontSize: 18.0,
                        color: black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                TextSpan(
                  text: "ku",
                  style: GoogleFonts.lexendDeca(
                    textStyle: const TextStyle(
                        fontSize: 18.0,
                        color: orange,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ]),
            ),
            Container(
              height: 96,
            ),
            Text(
              "Stay organized, achieve your goals, and effortlessly manage every task, focus on what truly matters.",
              style: GoogleFonts.lexendDeca(
                textStyle: const TextStyle(
                    fontSize: 20.0, color: black, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            CustomButtonWithIcon(
              text: "Login with Google",
              color: orange,
              icon: "assets/images/google.svg",
              onTap: () {},
            ),
            const SizedBox(
              height: 12,
            ),
            CustomButtonWithIcon(
              text: "Login with Email",
              color: black,
              icon: "assets/images/email.svg",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
