import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.openSans().fontFamily,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary: Colors.white,
      secondary: Colors.grey.shade700,
      inversePrimary: Colors.grey.shade500,
    ));
