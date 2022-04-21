import 'package:checkly/pages/guest_name.dart';
import 'package:checkly/pages/list.dart';
import 'package:checkly/pages/listEdit.dart';
import 'package:checkly/pages/login.dart';
import 'package:checkly/pages/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:checkly/pages/home.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  // User? user = FirebaseAuth.instance.currentUser;
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/login',
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
