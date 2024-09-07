import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoku_app/constants.dart';
import 'package:todoku_app/pages/login/bloc/google_auth_bloc.dart';

class ButtonGoogleLogin extends StatelessWidget {
  const ButtonGoogleLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(boxShadow: [shadow]),
      child: ElevatedButton(
        onPressed: () {
          context.read<GoogleAuthBloc>().add(SignInEvent());
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )),
        child: BlocBuilder<GoogleAuthBloc, GoogleAuthState>(
          builder: (context, state) {
            return state is GoogleAuthLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        color: white,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/google.svg",
                            height: 18,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Login with Google",
                            style: GoogleFonts.lexendDeca(
                                textStyle: const TextStyle(
                                    color: white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ],
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/google.svg",
                        height: 18,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Login with Google",
                        style: GoogleFonts.lexendDeca(
                            textStyle: const TextStyle(
                                color: white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
