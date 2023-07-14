import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';
//import 'package:minimize_app/minimize_app.dart';

import 'constants.dart';

const appName = 'CattyLandy';

class AppBarConstructor {
  static PreferredSizeWidget mineAppBar(BuildContext context) {
    return AppBar(
      title: Text(appName, style: getTextStileTitle()),
      backgroundColor: themeAppColor,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        getUserRegistration(context),
//        getExit(),
      ],
    );
  }

  static PreferredSizeWidget registrationAppBar(BuildContext context) {
    return AppBar(
      title: Text(appName, style: getTextStileTitle()),
      backgroundColor: themeAppColor,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        revertToMineMenu(context),
//        getExit(),
      ],
    );
  }

  static Padding getUserRegistration(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
      child: IconButton(
        icon: const Icon(Icons.account_box_outlined, size: 40),
        onPressed: () async {
          Navigator.pushNamed(context, '/user_registration');
        },
      ),
    );
  }

  static Padding revertToMineMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
      child: IconButton(
        icon: const Icon(Icons.fast_rewind, size: 40),
        onPressed: () async {
          Navigator.pop(context);
        },
      ),
    );
  }

  static IconButton getExit() {
    return IconButton(
      icon: const Icon(Icons.close_rounded),
      onPressed: () {
        if (Platform.isAndroid) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          });
        } else if (Platform.isIOS) {
          Future.delayed(const Duration(milliseconds: 1000), () {
//            MinimizeApp.minimizeApp();
            exit(0);
          });
        }
      },
    );
  }

  static TextStyle getTextStileTitle() {
    return const TextStyle(
        fontFamily: 'DeliciousHandrawn',
        color: Colors.white,
        fontStyle: FontStyle.italic,
        fontSize: 40.0,
        shadows: [Shadow(offset: Offset(2.0, 2.0), blurRadius: 6.0)]);
  }
}
