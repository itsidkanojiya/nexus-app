import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {
  static const primary = Color(0xff77ADA3);
  static const secondary = Color(0xffFEFEF6);
  static const bg_color = Color(0xffFAECD6);
  static const textfield_color = Color.fromARGB(255, 237, 236, 236);
  static double defaultPadding = 18.0;

  static BorderRadius defaultBorderRadius = BorderRadius.circular(20);
  static TextStyle font8B400 = GoogleFonts.poppins(
      fontSize: 8, color: Colors.black, fontWeight: FontWeight.w400);
  static TextStyle hintStyle = GoogleFonts.poppins(
      fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w400);
  static TextStyle fillStyle = GoogleFonts.poppins(
      fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400);
  static TextStyle labelStyle = GoogleFonts.poppins(
      fontSize: 13,
      color: const Color(0xFF001133),
      fontWeight: FontWeight.w400);
  static TextStyle buttonStyle = GoogleFonts.nunito(
      fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600);
  static TextStyle drawerStyle = GoogleFonts.nunito(
      fontSize: 16,
      color: const Color(0xFF001133),
      fontWeight: FontWeight.w500);
  static TextStyle tableTitle = GoogleFonts.nunito(
      fontSize: 16,
      color: const Color(0xFF001133),
      fontWeight: FontWeight.w500);
  static TextStyle tableSubtitle = GoogleFonts.nunito(
      fontSize: 16,
      color: const Color(0xFF001133),
      fontWeight: FontWeight.w700);
}
