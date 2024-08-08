import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = Color(0xff5D9CEC);
  static Color backGroundLight = Color(0xffDFECDB);
  static Color backGroundDark = Color(0xff060E1E);
  static Color grey = Color(0xffC8C9CB);
  static Color red = Color(0xffEC4B4B);
  static Color green = Color(0xff61E757);
  static Color white = Color(0xffffffff);
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backGroundLight,
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
  );
  static ThemeData darkTheme = ThemeData();
}
