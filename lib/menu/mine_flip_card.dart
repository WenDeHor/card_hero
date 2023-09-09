import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:card_hero/db/user_database.dart';
import 'package:card_hero/menu/2_mine_screan.dart';
import 'package:card_hero/model/user_model.dart';
import 'package:card_hero/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:provider/provider.dart';
import '2_mine_screan.dart';

late UserDatabase userDatabase;

class UserFlipCard extends StatelessWidget {
  const UserFlipCard( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FlipCardController _controller = FlipCardController();
    double width = (MediaQuery.of(context).size.width / 100) * 80;
    double height = (MediaQuery.of(context).size.height / 100) * 55;

    String? description = userListGlobal.isNotEmpty && userListGlobal[0].descriptionCard != null
        ? userListGlobal[0].descriptionCard!
        : "Describe your emotions associated with the photo";
    String? level = userListGlobal.isNotEmpty && userListGlobal[0].lvl != null ? userListGlobal[0].lvl! : "0";
    Color cardColor = checkColors(level);

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
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              getDefaultImage(userListGlobal),
              getName(userListGlobal)
            ],
          ),
        ),
        backWidget: Container(
          width: width,
          height: height,
          color: cardColor,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(description, textAlign: TextAlign.center, style: getTextStileTitle()),
          ]),
        ),
      ),
      onTap: () {
        _controller.flipcard();
        ChangeNotifierProvider.read<SimpleCalcWidgetModel>(context)?.incrementRating();
      },
    );
  }

  Widget getUserImage(List<User> userList) {
    Uint8List path = base64.decode(userList[0].image!);
    return Column(
      children: [Image.memory(path, fit: BoxFit.fill)],
    );
  }

  Widget getDefaultImage(List<User> userList) {
    return Column(
      children: [
        userList.isNotEmpty && userList[0].image != null ? getUserImage(userList) : Image.asset('assets/cover23.jpg', fit: BoxFit.cover),
//          getName(userListGlobal)
      ],
    );
  }

  Text getName(List<User> userList) {
    return userList.isNotEmpty && userList[0].name != null ? getText(userList[0].name!) : getText('Enter your name');
  }

  Text getText(String text) {
    return Text(text, style: getTextStileTitle());
  }

  TextStyle getTextStile() {
    return const TextStyle(
      fontFamily: 'DeliciousHandrawn',
      color: Colors.deepOrangeAccent,
      fontStyle: FontStyle.italic,
      fontSize: 40.0,
      shadows: [Shadow(offset: Offset(2.0, 2.0), blurRadius: 6.0, color: Colors.blueGrey)],
    );
  }

  TextStyle getTextStileTitle() {
    return const TextStyle(
        fontFamily: 'DeliciousHandrawn',
        color: Colors.white,
        fontStyle: FontStyle.italic,
        fontSize: 40.0,
        shadows: [Shadow(offset: Offset(2.0, 2.0), blurRadius: 6.0)]);
  }

  Color checkColors(String? lvl) {
    int? value = int.parse(lvl!);
    if (value <= 10) {
      return Colors.grey;
    } else if (10 < value && value <= 30) {
      return Colors.lightBlueAccent;
    } else if (30 < value && value <= 70) {
      return Colors.deepOrangeAccent;
    } else if (70 < value && value <= 200) {
      return Colors.brown;
    } else if (200 < value && value <= 500) {
      return Colors.blueGrey;
    } else if (500 < value && value <= 1000) {
      return Colors.amberAccent;
    } else {
      return Colors.deepPurpleAccent;
    }
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends InheritedNotifier<T> {
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
    return context.dependOnInheritedWidgetOfExactType<ChangeNotifierProvider<T>>()?.notifier;
  }

  static T? read<T extends ChangeNotifier>(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<ChangeNotifierProvider<T>>()?.widget;
    if (widget is ChangeNotifierProvider<T>) {
      return widget.notifier;
    } else {
      return null;
    }
  }
}
