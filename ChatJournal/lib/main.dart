import 'dart:async';

import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/themes.dart';

StreamController<bool> isLightTheme = StreamController();

void main() => runApp(const ChatJournalApp());

class ChatJournalApp extends StatelessWidget {
  const ChatJournalApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: true,
      stream: isLightTheme.stream,
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat Journal',
          theme: (snapshot.data == true) ? lightTheme : darkTheme,
          darkTheme: darkTheme,
          home: const HomePage(title: 'Home'),
        );
      },
    );
  }
}
