import 'package:checkly/pages/guest_name.dart';
import 'package:checkly/pages/list.dart';
import 'package:checkly/pages/listEdit.dart';
import 'package:checkly/pages/login.dart';
import 'package:checkly/pages/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:checkly/pages/home.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/list',
    routes: {
      '/login': (context) => Login(),
      '/home': (context) => Home(),
      '/list': (context) => List(),
      '/listEdit': (context) => ListEdit(),
      '/settings': (context) => Settings(),
      '/guest': (context) => Guest(),
    },
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0),
      scaffoldBackgroundColor: Colors.transparent,
    ),
  ));
}
