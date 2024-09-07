import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoku_app/constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CustomButton({
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(boxShadow: [shadow]),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )),
        child: Text(
          text,
          style: GoogleFonts.lexendDeca(
              textStyle: const TextStyle(
                  color: white, fontSize: 16.0, fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }
}
