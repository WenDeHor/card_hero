import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

//FlipCardController controller = FlipCardController();

class MyApp extends StatefulWidget {
  @override
  _MyFlipCardState createState() => _MyFlipCardState();
}

class _MyFlipCardState extends State<MyApp> {
  int _counter = 0;

  get controller => null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
//        controller.flipcard();
        setState(() {
          _counter++;
        });
      },
      child: FlipCard(
        fill: Fill.fillBack,
        // Fill the back side of the card to make in the same size as the front.
        direction: FlipDirection.HORIZONTAL,
        // default
//        side: CardSide.FRONT, // The side to initially display.
        front: Container(
          child: Text('Front'),
        ),
        back: Container(
          child: Text('Back'),
        ),
      ),
    );
  }
}