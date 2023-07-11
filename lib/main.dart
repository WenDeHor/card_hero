import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'menu/1_screan.dart';
import 'menu/2_screan.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome
          .setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [])
      .then((_) => runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primaryColor: Colors.white70),
            initialRoute: '/',
            routes: {
              '/': (context) => MyApp(),
              '/description': (context) => Home(),
            },
          )));

  Future showBar() async {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}
