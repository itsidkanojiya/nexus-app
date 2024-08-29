import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {
  static const primary = Color(0xff77ADA3);
  static const primary2 = Color(0xffF2B88D);
  static const background = Color(0xffF5F7F6);
  static final card = Colors.grey[100];
  static const secondary = Color(0xffFEFEF6);
  static const secondary2 = Color(0xff4E8570);
  static const bg_color = Color(0xffFAECD6);
  static const textfield_color = Color.fromARGB(255, 237, 236, 236);
  static double defaultPadding = 18.0;

  static BorderRadius defaultBorderRadius = BorderRadius.circular(20);
  static TextStyle font8B400 = GoogleFonts.aBeeZee(
      fontSize: 8, color: Colors.black, fontWeight: FontWeight.w400);
  static TextStyle hintStyle = GoogleFonts.aBeeZee(
      fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w400);
  static TextStyle fillStyle = GoogleFonts.aBeeZee();
  static TextStyle labelStyle = GoogleFonts.aBeeZee(
      fontSize: 13,
      color: const Color(0xFF001133),
      fontWeight: FontWeight.w400);
  static TextStyle buttonStyle = GoogleFonts.nunito(
      fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600);
  static TextStyle appBarTitle = GoogleFonts.aBeeZee(
      fontSize: 20,
      color: const Color(0xFF001133),
      fontWeight: FontWeight.w500);
  static TextStyle tableTitle =
      GoogleFonts.aBeeZee(fontSize: 16, fontWeight: FontWeight.bold);
  static TextStyle tableSubtitle =
      GoogleFonts.aBeeZee(fontWeight: FontWeight.bold);
}
