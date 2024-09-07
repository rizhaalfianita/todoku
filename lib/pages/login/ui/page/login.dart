import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoku_app/constants.dart';
import 'package:todoku_app/global_widgets/custom_button_with_icon.dart';
import 'package:todoku_app/pages/home/ui/page/home.dart';
import 'package:todoku_app/pages/landing/landing.dart';
import 'package:todoku_app/pages/login/bloc/google_auth_bloc.dart';
import 'package:todoku_app/pages/login/ui/widget/button_google_login.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<GoogleAuthBloc, GoogleAuthState>(
        listener: (context, state) {
          if (state is GoogleAuthSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Landing(),
              ),
              (route) => false,
            );
          }
        },
        child: Container(
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
                      fontSize: 20.0,
                      color: black,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const ButtonGoogleLogin(),
              const SizedBox(
                height: 12,
              ),
              CustomButtonWithIcon(
                text: "Login as Guest",
                color: black,
                icon: "assets/images/email.svg",
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                      (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
