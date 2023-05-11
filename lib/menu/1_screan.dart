import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:card_hero/db/user_database.dart';
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
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

ImageAndNameFromListUser imageAndNameFromListUser = ImageAndNameFromListUser();
ProgressIndicatorUtils progressIndicator = ProgressIndicatorUtils();
ButtonsUtils buttonsUtils = ButtonsUtils();
BuildCardView buildCardView = BuildCardView();

FlipCardController _cong = FlipCardController();
var counter = 0;
var durarion = 500;
User user = User();

List<User> pList = [];
List<User> userssss = [];

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
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserDatabase userDatabase;

//  List<User> userssss = [];

  @override
  initState() {
    super.initState();
    print("+++++++++++++++initState++++++++++++++}");
    this.userDatabase = UserDatabase();
    this.userDatabase.getDataBase().whenComplete(() async {
      _refreshNotes();
      setState(() {});
    });
  }

  int getIdUser() {
    return userssss.length;
  }

  void _refreshNotes() async {
    final datas = await userDatabase.getAllUsers();
    setState(() {
      userssss = datas;
      if (datas.length > 0) {
        user = datas.last;
      }
      print("+++++++++++++++${userssss.toString()}");
      print("+++++++++++++++${userssss.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text('My hero'),
        backgroundColor: themeAppColor,
      ),
      body: Container(
        margin: themeMargin,
        padding: themePadding,
        decoration: new BoxDecoration(
          color: Colors.grey,
          border: new Border.all(color: new Color(0xFF9E9E9E)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
//            OutlinedButton(onPressed: onPressed, child: child)
            OutlinedButton(
                style: flatButtonStyle,
                onPressed: () {
                  _cong.flipcard();
                  setState(() {
                    counter = counter + 1;
                    print('$counter');
                  });
//                  if (kDebugMode) {
//                    print('++++++++++++');
//                    print('$counter');
//                  }
                },
                child: FlipCard(
                  animationDuration: Duration(milliseconds: 800),
                  rotateSide: RotateSide.bottom,
                  onTapFlipping: false,
                  axis: FlipAxis.vertical,
                  controller: _cong,
                  frontWidget: buildCardView.buildCardViewFrontByUser(user),
                  backWidget: buildCardView.buildCardViewBack(
                      Image.asset('assets/cover.jpg', fit: BoxFit.cover)),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                progressIndicator.getProgressIndicator(counter),
              ],
            ),
            Column(
              children: <Widget>[
                buttonsUtils.loadImageButton(context, changePhotoCard),
                buttonsUtils.buildFilledButton(
                    context, changeDescription, '/description')
              ],
            ),
          ],
        ),
      ),
    );
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.black87,
    minimumSize: Size(10, 10),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );
}
