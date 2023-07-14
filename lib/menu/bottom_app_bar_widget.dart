import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

var iconSize = 30.0;

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      height: 100,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 100),
          buttonForm("Mine menu", Icons.home_filled, Colors.brown),
          IconButton(
            onPressed: () {
              print('button tapped');
            },
            icon: const Icon(
              Icons.api,
              color: Colors.brown,
            ),
            iconSize: iconSize,
          ),
          IconButton(
            onPressed: () {
              print('button tapped');
            },
            icon: const Icon(
              Icons.add_chart,
              color: Colors.brown,
            ),
            iconSize: iconSize,
          ),
          IconButton(
            onPressed: () {
              print('button tapped');
            },
            icon: const Icon(
              Icons.adjust,
              color: Colors.brown,
            ),
            iconSize: iconSize,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Column buttonForm(String name, IconData icon, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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

  void pressedButton(String name) {
    Fluttertoast.showToast(
        msg: name,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green[300],
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
