import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.openSans().fontFamily,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
    colorScheme: ColorScheme.light(
      background: const Color(0xffFAFAFA),
      primary: const Color(0xff374957),
      secondary: const Color(0xffDADADA),
      inversePrimary: Colors.grey.shade800,
    ));
