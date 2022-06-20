import 'package:flutter/material.dart';

ThemeData mainTheme() {
  return ThemeData(
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Colors.white, fontSize: 25),
      labelMedium: TextStyle(color: Colors.white, fontSize: 18),
      titleMedium: TextStyle(color: Colors.grey, fontSize: 18),
      titleSmall: TextStyle(color: Colors.grey, fontSize: 11),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodySmall: TextStyle(color: Colors.white, fontSize: 15),
    ),
    shadowColor: Colors.grey[500],
    backgroundColor: Colors.black,
    canvasColor: Colors.grey[400],
    cardColor: Colors.black87,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
    ),
    // backgroundColor: Colors.black,
    iconTheme: IconThemeData(
      color: Colors.grey[300],
      size: 28,
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: Colors.white,
      textColor: Colors.black,
      iconColor: Colors.black,
    ),
  );
}
