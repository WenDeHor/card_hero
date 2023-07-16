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
        getUserInfoWidget(context),
        getLoginMineWidget(context),
      ],
    );
  }

  static PreferredSizeWidget infoAppBar(BuildContext context) {
    return AppBar(
      title: Text(appName, style: getTextStileTitle()),
      backgroundColor: themeAppColor,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        revertToMineMenuWidget(context),
      ],
    );
  }

  static PreferredSizeWidget loginAppBar(BuildContext context) {
    return AppBar(
      title: Text(appName, style: getTextStileTitle()),
      backgroundColor: themeAppColor,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        revertWidget(context),
      ],
    );
  }

  static Padding getLoginMineWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: IconButton(
        icon: const Icon(Icons.settings_outlined, size: 30),
        onPressed: ()  {
          Navigator.pushNamed(context, '/user_enter');
        },
      ),
    );
  }

  static Padding getUserInfoWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: IconButton(
        icon: const Icon(Icons.description, size: 30),
        onPressed: () {
          Navigator.pushNamed(context, '/user_info');
        },
      ),
    );
  }

  static Padding getUserRegistrationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: IconButton(
        icon: const Icon(Icons.account_box_outlined, size: 30),
        onPressed: () async {
          Navigator.pushNamed(context, '/user_registration');
        },
      ),
    );
  }

  static Padding revertToMineMenuWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
      child: IconButton(
        icon: const Icon(Icons.fast_rewind, size: 40),
        onPressed: () async {
//          Navigator.pop(context);
          Navigator.pushNamed(context, '/');
        },
      ),
    );
  }

  static Padding revertWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
      child: IconButton(
        icon: const Icon(Icons.fast_rewind, size: 40),
        onPressed: () {
//          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  }

  static IconButton getExitWidget() {
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
