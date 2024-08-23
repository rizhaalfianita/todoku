import 'package:flutter/material.dart';
import 'package:todoku_app/constants.dart';

Widget menuCard(IconData icon, VoidCallback fun) {
  return InkWell(
    onTap: fun,
    child: Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        color: extraLightGray,
      ),
      child: Icon(
        icon,
        size: 20.0,
      ),
    ),
  );
}
