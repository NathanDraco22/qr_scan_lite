
import 'package:flutter/material.dart';

class AppTheme {

  static final Color primary = Colors.indigo.shade600;

  static final ThemeData light = ThemeData.light().copyWith(

    primaryColor: Colors.white,

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary

    ),

    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: primary
    ),
    scaffoldBackgroundColor: const Color.fromRGBO(220, 220, 220, 1)
  );

   static final ThemeData dark = ThemeData.dark();



}