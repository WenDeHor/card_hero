import 'package:flutter/material.dart';
import 'dart:io';

//import 'package:flutter/rendering.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

import '../../menu/navbar.dart';
import '../../menu/1_screan.dart';
import '../../menu/2_screan.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white70),
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(),
        '/todo': (context) => Home(),
      },
    ));


