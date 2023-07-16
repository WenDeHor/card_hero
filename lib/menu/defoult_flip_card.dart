import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class DefaultFlipCard {
  final FlipCardController _controller = FlipCardController();

  GestureDetector getFlipCard(BuildContext context) {
    double width = (MediaQuery.of(context).size.width / 100) * 80;
    double height = (MediaQuery.of(context).size.height / 100) * 55;
    Image image = Image.asset('assets/cover23.jpg', fit: BoxFit.cover);
    return GestureDetector(
      child: FlipCard(
        animationDuration: const Duration(milliseconds: 500),
        rotateSide: RotateSide.bottom,
        onTapFlipping: false,
        axis: FlipAxis.vertical,
        controller: _controller,
        frontWidget: Container(
          width: width,
          height: height,
          child: image,
        ),
        backWidget: Container(
          width: width,
          height: height,
          color: Colors.blue[300],
          child: getText(),
        ),
      ),
      onTap: () {
        _controller.flipcard();
      },
    );
  }

  Center getText() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
        child: Text(
          'This is exactly the day that I will remember for a long time, because I remember it and it is very valuable to me.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.5,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
