import 'package:flutter/material.dart';

class MyTheme {
  static Color bgDark = Color(0xff060E1E);
  static Color primaryLight = Color(0xff5D9CEC);
  static Color blackColor = Color(0xff383838);
  static Color whiteColor = Color(0xffffffff);
  static Color grayColor = Color(0xffC8C9CB);
  static Color greenColor = Color(0xff61E757);
  static Color redColor = Color(0xffEC4B4B);
  static Color bgLight = Color(0xffDFECDB);
  static Color darkBlack = Color(0xff141922);

  static ThemeData lightTheme = ThemeData(
    hintColor: Colors.grey,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(18),
          topLeft: Radius.circular(18),
        ),
      ),
    ),
    primaryColor: primaryLight,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryLight,
        shape: StadiumBorder(
          side: BorderSide(width: 4, color: MyTheme.whiteColor),
        ),
        iconSize: 35),
    scaffoldBackgroundColor: bgLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryLight, unselectedItemColor: Colors.grey),
    appBarTheme: AppBarTheme(backgroundColor: primaryLight),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 22, color: whiteColor),
      titleMedium: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: blackColor),
      titleSmall: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, color: blackColor),
      displayMedium: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, color: primaryLight),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    hintColor: Colors.grey,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: darkBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(18),
          topLeft: Radius.circular(18),
        ),
      ),
    ),
    primaryColor: primaryLight,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryLight,
        shape: StadiumBorder(
          side: BorderSide(width: 4, color: MyTheme.whiteColor),
        ),
        iconSize: 35),
    scaffoldBackgroundColor: bgDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryLight, unselectedItemColor: Colors.white),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 22, color: blackColor),
      titleMedium: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: whiteColor),
      titleSmall: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, color: whiteColor),
      displayMedium: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, color: primaryLight),
    ),
  );
}
