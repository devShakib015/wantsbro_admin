import 'package:flutter/material.dart';

import 'package:wantsbro_admin/theming/color_constants.dart';

ThemeData mainTheme = ThemeData.dark().copyWith(
  primaryColor: mainColor,
  accentColor: mainColor,
  bottomAppBarColor: mainColor,
  snackBarTheme: SnackBarThemeData(
    backgroundColor: mainColor,
    elevation: 5,
    contentTextStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  scaffoldBackgroundColor: mainBackgroundColor,
  appBarTheme: AppBarTheme(
    color: mainBackgroundColor,
    centerTitle: true,
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20,
    showSelectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
  ),
  dialogBackgroundColor: mainBackgroundColor,
  highlightColor: mainColor,
  cardColor: mainColor,
  canvasColor: mainBackgroundColor,
  backgroundColor: mainBackgroundColor,
  primaryColorDark: mainBackgroundColor,
  splashColor: Colors.red,
  buttonColor: mainColor,
  inputDecorationTheme: InputDecorationTheme(
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: mainColor, width: 3),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: mainColor, width: 4),
    ),
    fillColor: mainColor,
    labelStyle: TextStyle(color: white),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: mainColor, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: mainColor, width: 3),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(mainColor)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(mainColor)),
  ),
  toggleableActiveColor: mainColor,
  buttonTheme: ButtonThemeData(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  focusColor: mainColor,
  dividerColor: mainColor,
  iconTheme: IconThemeData(color: white),
  accentIconTheme: IconThemeData(color: white),
  primaryIconTheme: IconThemeData(color: white),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: mainColor,
    foregroundColor: white,
  ),
);
