import 'package:flutter/material.dart';

//import 'package:flutter/rendering.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

import '../../menu/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Flip card',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomeScreen(),
    );
  }
}

class LeftWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: Text('Side menu'),
      ),
      body: Center(
        child: Text('Side Menu Tutorial'),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    FlipCardController _cong = FlipCardController();
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(title: const Text('Flip card')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlipCard(
              rotateSide: RotateSide.bottom,
              onTapFlipping: true,
              //When enabled, the card will flip automatically when touched.
              axis: FlipAxis.vertical,
              controller: _cong,
              frontWidget: Center(
                child: Container(
                  height: 450,
                  width: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60), // Image border
                    child: SizedBox.fromSize(
                        size: Size.fromRadius(50), // Image radius
                        child:
                            Image.asset('assets/cover.jpg', fit: BoxFit.cover)),
                  ),
                ),
              ),
              backWidget: Center(
                child: Container(
                  height: 450,
                  width: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60), // Image border
                    child: SizedBox.fromSize(
                        size: Size.fromRadius(50), // Image radius
                        child:
                            Image.asset('assets/cover.jpg', fit: BoxFit.cover)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customCard(String title) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: Colors.blue,
      child: Container(
        height: 225,
        width: 150,
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
