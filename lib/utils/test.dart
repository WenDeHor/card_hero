import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class MyApp extends StatefulWidget {
  @override
  _FlipCardDemoState createState() => _FlipCardDemoState();
}

class _FlipCardDemoState extends State<MyApp> {
  int turnCounter = 0;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flip Card Demo"),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          child: FlipCard(
            key: cardKey,
            flipOnTouch: false,
            onFlip: () => setState(() => turnCounter++),
            front: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text("Front of Card ${turnCounter}",
                    style: TextStyle(fontSize: 18, color: Colors.deepOrange)),
              ),
            ),
            back: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text("Back of Card",
                    style: TextStyle(fontSize: 18, color: Colors.deepOrange)),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => cardKey.currentState?.toggleCard());
        },
        child: Icon(Icons.flip),
      ),
    );
  }
}