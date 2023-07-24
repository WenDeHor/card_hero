import 'package:flutter/material.dart';

var iconSize = 30.0;

class FooterBar {
  static Widget getMineBar(
    BuildContext context,
    Color colorsMineMenu,
    Color colorsListFriends,
    Color colorsStileApp,
    Color colorsDetails,
  ) {
    return BottomAppBar(
      elevation: 0,
      height: 70,
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 100),
          buttonForm(context, "Mine menu", Icons.home_filled, colorsMineMenu),
          buttonForm(context, "List friends", Icons.api, colorsListFriends),
          buttonForm(context, "Stile app", Icons.add_chart, colorsStileApp),
          buttonForm(context, "Details", Icons.adjust, colorsDetails),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  static Widget getLoginBar(
    BuildContext context,
    Color colorsHome,
    Color colorsLogin,
    Color colorsRegistration,
    Color colorsLicense,
  ) {
    return BottomAppBar(
      elevation: 0,
      height: 70,
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 100),
          buttonFormDefault(
              context, "Home", Icons.home_filled, colorsHome, '/user_enter'),
          buttonFormDefault(
              context, "Login", Icons.camera, colorsLogin, '/user_login'),
          buttonFormDefault(
              context,
              "Registration",
              Icons.account_circle_outlined,
              colorsRegistration,
              '/user_registration'),
          buttonFormDefault(context, "License", Icons.lightbulb_outline,
              colorsLicense, '/license'),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  static Column buttonFormDefault(BuildContext context, String name,
      IconData icon, Color color, String url) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            getUrl(context, url);
          },
          icon: Icon(
            icon,
            color: color,
          ),
          iconSize: iconSize,
        ),
        Text(name,
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0)),
      ],
    );
  }

  static void getUrl(BuildContext context, String url) {
    Navigator.pushNamed(context, url);
  }

  static Column buttonForm(
      BuildContext context, String name, IconData icon, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            pressedButton(context, name);
          },
          icon: Icon(
            icon,
            color: color,
          ),
          iconSize: iconSize,
        ),
        Text(name,
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0)),
      ],
    );
  }

  static void pressedButton(BuildContext context, String name) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(name),
      backgroundColor: Colors.deepOrange[200],
    ));
  }
}
