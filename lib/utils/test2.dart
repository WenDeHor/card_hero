import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _FlipCardCounterState createState() => _FlipCardCounterState();
}

class _FlipCardCounterState extends State<MyApp> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          counter++;
        });
      },
      child: Container(
        child: Center(
          child: Text(
            '$counter',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
