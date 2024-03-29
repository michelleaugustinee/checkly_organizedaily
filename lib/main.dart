import 'package:checkly/pages/guest_name.dart';
import 'package:checkly/pages/tasks.dart';
import 'package:checkly/pages/tasks_edit.dart';
import 'package:checkly/pages/login.dart';
import 'package:checkly/pages/settings.dart';
import 'package:checkly/utils/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:checkly/pages/home.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  String? username = await SharedPreferenceUtil().getName();
  String initialRoute = '/login';
  await Firebase.initializeApp();
  if (username != null ){
    initialRoute = '/home';
  }
  runApp(MaterialApp(
    initialRoute: initialRoute,
    routes: {
      '/login': (context) => Login(),
      '/home': (context) => Home(),
      // '/tasks': (context) => Tasks(),
      // '/tasksEdit': (context) => TasksEdit(),
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
