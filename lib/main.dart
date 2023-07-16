import 'package:card_hero/menu/1_1_enter.dart';
import 'package:card_hero/menu/1_2_login.dart';
import 'package:card_hero/menu/1_3_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'menu/2_mine_screan.dart';
import 'menu/3_card_image_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white70),
    initialRoute: '/',
    routes: {
      '/': (context) => const MyApp(),
      '/user_enter': (context) => const UserEnter(),
      '/user_login': (context) => const UserLogin(),
      '/user_registration': (context) => const UserRegistration(),
      '/user_info': (context) => const UserInfo(),
    },
  ));
}
