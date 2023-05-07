import 'package:flutter/material.dart';
import 'menu/1_screan.dart';
import 'menu/2_screan.dart';

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white70),
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      '/description': (context) => Home(),
    },
  ));
}
