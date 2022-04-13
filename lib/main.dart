import 'package:checkly/pages/list.dart';
import 'package:checkly/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:checkly/pages/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/list': (context) => List(),
      '/settings':(context) => Settings(),
    },
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0),
      scaffoldBackgroundColor: Colors.transparent,
    ),

  ));
}