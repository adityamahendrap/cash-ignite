import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    bodySmall: GoogleFonts.poppins().copyWith(color: Colors.black),
    bodyMedium: GoogleFonts.poppins().copyWith(color: Colors.black),
    bodyLarge: GoogleFonts.poppins().copyWith(color: Colors.black),
    labelSmall: GoogleFonts.poppins().copyWith(color: Colors.black),
    labelMedium: GoogleFonts.poppins().copyWith(color: Colors.black),
    labelLarge: GoogleFonts.poppins().copyWith(color: Colors.black),
    displaySmall: GoogleFonts.poppins().copyWith(color: Colors.black),
    displayMedium: GoogleFonts.poppins().copyWith(color: Colors.black),
    displayLarge: GoogleFonts.poppins().copyWith(color: Colors.black),
  ),
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.blue,
    secondary: Colors.blueAccent,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    bodySmall: const TextStyle(color: Colors.white),
    bodyMedium: const TextStyle(color: Colors.white),
    bodyLarge: const TextStyle(color: Colors.white),
    labelSmall: const TextStyle(color: Colors.white),
    labelMedium: const TextStyle(color: Colors.white),
    labelLarge: const TextStyle(color: Colors.white),
    displaySmall: const TextStyle(color: Colors.white),
    displayMedium: const TextStyle(color: Colors.white),
    displayLarge: const TextStyle(color: Colors.white),
  ),
  colorScheme: ColorScheme.dark(
    background: Color(0xFF181A20),
    primary: Colors.blue,
    secondary: Colors.blueAccent,
  ),
);
