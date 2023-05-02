import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'menu/1_screan.dart';
import 'menu/2_screan.dart';
import 'model/user_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  final _userDataBox = await Hive.openBox<User>('user_box');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white70),
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      '/todo': (context) => Home(),
    },
  ));
}
