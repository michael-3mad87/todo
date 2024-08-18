
import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = const Color(0xff5D9CEC);
  static Color backGroundLight = const Color(0xffDFECDB);
  static Color backGroundDark = const Color(0xff060E1E);
  static Color grey = const Color(0xffC8C9CB);
  static Color red = const Color(0xffEC4B4B);
  static Color green = const Color(0xff61E757);
  static Color white = const Color(0xffffffff);
  static Color black = const Color(0xff363636);
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backGroundLight,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: white,
      selectedItemColor: primaryColor,
      unselectedItemColor: grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: white,
      shape: CircleBorder(
        side: BorderSide(width: 4, color: white),
      ),
    ),
    textTheme: TextTheme(
        titleLarge: TextStyle(
          color: black,
          fontWeight: FontWeight.bold,
        ),
        titleSmall:
            TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w400)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: white,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppTheme.primaryColor,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData();
}
