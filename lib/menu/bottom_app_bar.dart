import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

var iconSize = 30.0;

class BottomAppBarForm {
 static Widget getBottomAppBar(
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
          buttonForm("Mine menu", Icons.home_filled, colorsMineMenu),
          buttonForm("List friends", Icons.api, colorsListFriends),
          buttonForm("Stile app", Icons.add_chart, colorsStileApp),
          buttonForm("Details", Icons.adjust, colorsDetails),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

 static Column buttonForm(String name, IconData icon, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            pressedButton(name);
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

 static void pressedButton(String name) {
    Fluttertoast.showToast(
        msg: name,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[300],
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
