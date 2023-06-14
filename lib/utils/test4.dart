import 'package:flutter/material.dart';
int _counter = 0;
class MyApp extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlipCard Example'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _counter++;
            });
          },
          child: FlipCard(),
        ),
      ),
    );
  }
}

class FlipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          '${_counter}',
          style: TextStyle(fontSize: 50, color: Colors.white),
        ),
      ),
    );
  }
}