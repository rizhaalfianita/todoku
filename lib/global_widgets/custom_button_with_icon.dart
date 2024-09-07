import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoku_app/constants.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String icon;
  final String text;

  const CustomButtonWithIcon({
    required this.text,
    required this.color,
    required this.icon,
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
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 18,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: GoogleFonts.lexendDeca(
                  textStyle: const TextStyle(
                      color: white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }
}
