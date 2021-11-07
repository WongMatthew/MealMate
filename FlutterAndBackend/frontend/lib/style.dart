import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData DefaultTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Color(0xFFFF8D4D),
    textTheme: DefaultTextTheme(),
  );
}

TextTheme DefaultTextTheme() {
  return TextTheme(
    headline1: GoogleFonts.roboto(
      fontSize: 64,
      color: Colors.white,
      shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(0.0, 4.0)),]
      ),
      subtitle1: GoogleFonts.roboto(
      fontSize: 15,
      color: Colors.black,
      ),

    bodyText1: GoogleFonts.roboto(
      fontSize: 36,
      color: Colors.white,
      shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(0.0, 4.0)),]
      ),
    bodyText2: GoogleFonts.roboto(
      fontSize: 24,
      color: Colors.white,
      shadows: <Shadow>[Shadow(color: Color(0xFFCEA1A1), offset: Offset(0.0, 0.0)),]
      ),
  );
}