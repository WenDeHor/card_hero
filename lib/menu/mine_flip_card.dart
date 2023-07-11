import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import '1_screan.dart';

class UserFlipCard extends StatelessWidget {
  const UserFlipCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width;
    double height;
    Uint8List path;
    Image image;
    if (user.image == null) {
      width = (MediaQuery.of(context).size.width / 100) * 80;
      height = (MediaQuery.of(context).size.height / 100) * 55;
      image = Image.asset('assets/cover23.jpg', fit: BoxFit.cover);
    } else {
      path = base64.decode(user.image!);
      final size = ImageSizeGetter.getSize(MemoryInput(path));
      width = (size.height / 100) * 80;
      height = (size.width / 100) * 55;
      image = Image.memory(path, fit: BoxFit.fill);
    }
    return GestureDetector(
      child: FlipCard(
        animationDuration: Duration(milliseconds: 500),
        rotateSide: RotateSide.bottom,
        onTapFlipping: false,
        axis: FlipAxis.vertical,
        controller: controller,
        frontWidget: Container(
          width: width,
          height: height,
          child: image,
        ),
        backWidget: Container(
          width: width,
          height: height,
          color: Colors.blue,
//          child: buildCardViewBack,
        ),
      ),
      onTap: () {
        controller.flipcard();
        ChangeNotifierProvider.read<SimpleCalcWidgetModel>(context)
            ?.increment();

      },
    );
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier>
    extends InheritedNotifier<T> {
  ChangeNotifierProvider({
    Key? key,
    required T model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static T? watch<T extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ChangeNotifierProvider<T>>()
        ?.notifier;
  }

  static T? read<T extends ChangeNotifier>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ChangeNotifierProvider<T>>()
        ?.widget;
    if (widget is ChangeNotifierProvider<T>) {
      return widget.notifier;
    } else {
      return null;
    }
  }
}
