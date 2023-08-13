import 'package:card_hero/db/user_database.dart';
import 'package:card_hero/menu/1_1_enter.dart';
import 'package:card_hero/menu/1_2_login.dart';
import 'package:card_hero/menu/1_3_registration.dart';
import 'package:card_hero/menu/1_4_license.dart';
import 'package:card_hero/menu/3_2_edit_list_card.dart';
import 'package:card_hero/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'menu/2_mine_screan.dart';
import 'menu/3_1_edit_flip_card.dart';

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
          '/license': (context) => const UserLicense(),
          '/flip_card': (context) => const EditUserFlipCard(),
          '/list_card': (context) => const EditUserListCard(),
        },
      ),
//    ),
  );
}
