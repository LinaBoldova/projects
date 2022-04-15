import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      fontSize: 15,
      color: Colors.black,
    ),
    bodyText1: TextStyle(
      fontSize: 14,
      color: Colors.black26,
    ),
    headline4: TextStyle(),
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  focusColor: Colors.lightGreen[200],
  cardColor: const Color.fromRGBO(216, 205, 176, 0.6),
  hoverColor: const Color.fromRGBO(216, 205, 176, 0.4),
  scaffoldBackgroundColor: const Color.fromRGBO(231, 233, 238, 1),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromRGBO(216, 205, 176, 1),
  ),
  bottomAppBarColor: const Color.fromRGBO(135, 148, 192, 0.7),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color.fromRGBO(135, 148, 192, 0.7),
    showUnselectedLabels: true,
    selectedItemColor: Color.fromRGBO(231, 233, 238, 1),
    unselectedItemColor: Color.fromRGBO(28, 33, 53, 1),
    selectedIconTheme: IconThemeData(
      color: Color.fromRGBO(231, 233, 238, 20),
      size: 28,
    ),
    unselectedIconTheme: IconThemeData(
      color: Color.fromRGBO(28, 33, 53, 1),
      size: 28,
    ),
  ),
  appBarTheme: const AppBarTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(7),
      ),
    ),
    backgroundColor: Color.fromRGBO(135, 148, 192, 1),
    titleTextStyle: TextStyle(
      color: Color.fromRGBO(28, 33, 53, 1),
      fontSize: 19,
    ),
    iconTheme: IconThemeData(
      color: Color.fromRGBO(28, 33, 53, 1),
    ),
  ),
  brightness: Brightness.light,
  hintColor: Colors.black54,
);

final darkTheme = ThemeData(
  hintColor: Colors.white54,
  iconTheme: const IconThemeData(
    color: Colors.white70,
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.white70,
    textColor: Colors.white,
  ),
  textTheme: const TextTheme(
      bodyText2: TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
      bodyText1: TextStyle(
        fontSize: 14,
        color: Colors.white70,
      ),
      headline4: TextStyle()),
  cardColor: Colors.white10,
  focusColor: const Color.fromRGBO(165, 175, 118, 1),
  hoverColor: const Color.fromRGBO(252, 217, 131, 0.8),
  scaffoldBackgroundColor: Colors.black87,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromRGBO(252, 217, 131, 1),
  ),
  bottomAppBarColor: Colors.black87,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.black87,
    showUnselectedLabels: true,
    selectedItemColor: Color.fromRGBO(252, 217, 131, 1),
    unselectedItemColor: Colors.white70,
    selectedIconTheme: IconThemeData(
      color: Color.fromRGBO(252, 217, 131, 1),
      size: 28,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.white70,
      size: 28,
    ),
  ),
  appBarTheme: const AppBarTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(7),
      ),
    ),
    backgroundColor: Colors.black87,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 19,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  brightness: Brightness.dark,
);
