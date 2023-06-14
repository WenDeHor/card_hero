import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'dart:developer';
import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:lil_auto_increment/lil_auto_increment.dart';

import 'package:card_hero/db/user_database.dart';
import 'package:card_hero/db/user_power.dart';
import 'package:card_hero/utils/build_card_view.dart';
import 'package:card_hero/utils/constants.dart';
import 'package:card_hero/utils/progress_indicator.dart';
import 'package:card_hero/menu/navbar.dart';
import 'package:card_hero/model/user_model.dart';
import 'package:card_hero/utils/buttons_utils.dart';
import 'package:card_hero/utils/image_and_name_from_list_user.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user_power.dart';
import '../utils/Inherited_notifier_finish.dart';

ImageAndNameFromListUser imageAndNameFromListUser = ImageAndNameFromListUser();
ProgressIndicatorUtils progressIndicator = ProgressIndicatorUtils();
ButtonsUtils buttonsUtils = ButtonsUtils();
BuildCardView buildCardView = BuildCardView();

var counter = 0;
int _counter2 = 0;
var durarion = 500;
User user = User();
UserPower userPower = UserPower();

List<User> pList = [];
List<User> userssss = [];

//FlipCardController controller = FlipCardController();
GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
int turnCounter = 0;

final _model = SimpleCalcWidgetModel();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late UserDatabase userDatabase;
  late UserPowerDB userPowerDB;

  @override
  initState() {
    super.initState();
    this.userDatabase = UserDatabase();
    this.userPowerDB = UserPowerDB();
    this.userPowerDB.getDataBase().whenComplete(() async {
      getCounter();
      setState(() {});
    });
    this.userDatabase.getDataBase().whenComplete(() async {
      _refreshNotes();
      setState(() {});
    });
  }

  int getIdUser() {
    return userssss.length;
  }

  Future<int> getCounter() async {
    final datas = await userPowerDB.getCounter();
    counter = userPower.counter!;

    setState(() {
      userPower = datas;
      counter = userPower.counter!;
    });
    return counter;
  }

  void incrementCounter() async {
    UserPower userPower = await userPowerDB.getCounter();
    userPower.counter;
    if (userPower.counter != null) {
      int counter2 = userPower.counter! + 1;
      await userPowerDB.insertCounter(counter2);
      setState(() {});
    }
  }

  void _refreshNotes() async {
    final datas = await userDatabase.getAllUsers();
    setState(() {
      userssss = datas;
      if (datas.length > 0) {
        user = datas.last;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text('My hero'),
        backgroundColor: themeAppColor,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          new IconButton(
            icon: new Icon(Icons.monetization_on),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        margin: themeMargin,
        padding: themePadding,
        child: ChangeNotifierProvider(
          model: _model,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 300,
                height: 500,
                child: const FirstFlipCard(),
              ),
             const ResultWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buttonsUtils.loadImageButton(context, changePhotoCard),
                  FilledButton(
                      onPressed: () {
                        setState(() => cardKey.currentState?.toggleCard());
                        if (turnCounter >= 100) {
                          turnCounter++;
                        }
                      },
                      style: FilledButton.styleFrom(
                        fixedSize: themeSizeButton,
                        backgroundColor: themeAppColor,
                        elevation: 5,
                      ),
                      child: Text(
                        'FLIP',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                progressIndicator.getProgressIndicator(turnCounter),
              ],
            );
  }
}

class FirstFlipCard extends StatelessWidget {
  const FirstFlipCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   return FlipCard(
        key: cardKey,
        flipOnTouch: true,
        onFlip: () {
          turnCounter++;
          ChangeNotifierProvider.read<SimpleCalcWidgetModel>(context)
              ?.increment();
          print("turnCounter++++++++++++++++${turnCounter}");
        },
        front: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: buildCardView.buildCardViewFrontByUser(user),
          ),
        ),
        back: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: buildCardView.buildCardViewBack(
                Image.asset('assets/cover.jpg', fit: BoxFit.cover)),
          ),
        ));
  }
}

class ResultWidget extends StatelessWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int value = ChangeNotifierProvider.watch<SimpleCalcWidgetModel>(context)
        ?.firstNumber ??
        10;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        progressIndicator.getProgressIndicator(value),
      ],
    );
  }
}

class SimpleCalcWidgetModel extends ChangeNotifier {
  int? firstNumber=0;
  int? summResult;

  void increment(){
    firstNumber=firstNumber!+1;
    notifyListeners();
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

