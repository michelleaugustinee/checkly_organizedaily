import 'package:checkly/pages/guest.dart';
import 'package:checkly/pages/list.dart';
import 'package:checkly/pages/listEdit.dart';
import 'package:checkly/pages/login.dart';
import 'package:checkly/pages/settingGuest.dart';
import 'package:checkly/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:checkly/pages/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/home': (context) => Home(),
      '/list': (context) => List(),
      '/listEdit': (context) => ListEdit(),
      '/settings': (context) => Settings(),
      '/login': (context) => Login(),
      '/guest': (context) => Guest(),
      '/settingGuest': (context) => SettingGuest(),
    },
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0),
      scaffoldBackgroundColor: Colors.transparent,
    ),
  ));
}
