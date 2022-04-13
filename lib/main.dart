import 'package:checkly/pages/list.dart';
import 'package:flutter/material.dart';
import 'package:checkly/pages/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/list',
    routes: {
      '/home': (context) => Home(),
      '/list': (context) => List(),
    },
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0),
      scaffoldBackgroundColor: Colors.transparent,
    ),

  ));
}