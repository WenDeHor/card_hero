import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:card_hero/db/user_database.dart';
import 'package:card_hero/db/user_power.dart';
import 'package:card_hero/menu/bottom_app_bar_widget.dart';
import 'package:card_hero/model/user_model.dart';
import 'package:card_hero/utils/build_card_view.dart';
import 'package:card_hero/utils/buttons_utils.dart';
import 'package:card_hero/utils/constants.dart';
import 'package:card_hero/utils/image_and_name_from_list_user.dart';
import 'package:card_hero/utils/image_picker.dart';
import 'package:card_hero/utils/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

import '../model/user_power.dart';
import 'mine_flip_card.dart';

ImageAndNameFromListUser imageAndNameFromListUser = ImageAndNameFromListUser();
ProgressIndicatorUtils progressIndicator = ProgressIndicatorUtils();
ButtonsUtils buttonsUtils = ButtonsUtils();
BuildCardView buildCardView = BuildCardView();

var counter = 0;
var durarion = 500;
const appName = 'CattyLandy';
User user = const User();
UserPower userPower = const UserPower();

List<User> pList = [];
List<User> userssss = [];

ImagePickerPage imagePickerPage = ImagePickerPage();

FlipCardController controller = FlipCardController();
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
    userDatabase = UserDatabase();
    userPowerDB = UserPowerDB();
    userPowerDB.getDataBase().whenComplete(() async {
      getCounter();
      setState(() {});
    });
    userDatabase.getDataBase().whenComplete(() async {
      setState(() {});
    });
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

  @override
  Widget build(BuildContext context) {
    String byte64String;
    return Scaffold(
//      drawer: Navbar(),
      appBar: AppBar(
        title: Text(appName, style: getTextStileTitle()),
        backgroundColor: themeAppColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_box_outlined),
            onPressed: () async {
              //TODO Wiil be new windows with: add image, add text, add skills
              try {
                byte64String = await imagePickerPage.pickImage();
                if (byte64String.length > 0) {
                  UserDatabase().insertOrUpdateImageInUser(byte64String);
                  ChangeNotifierProvider.read<SimpleCalcWidgetModel>(context)
                      ?.updateImage();
                }
                Navigator.pushNamed(context, '/');
              } catch (e) {
                print("ERROR while picking file.");
                Navigator.pushNamed(context, '/');
              }
            },
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
            children: [
              const UserFlipCard(),
              const LevelScaleWidget(),
              resourceWidget(50, 360, 5000, 10)
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }

  Widget resourceWidget(int val_1, int val_2, int val_3, int val_4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            resourceIcons(favorite, imageColor_1, val_1),
            resourceIcons(star, imageColor_2, val_2)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            resourceIcons(add_moderator, imageColor_3, val_3),
            resourceIcons(add_box, imageColor_4, val_4)
          ],
        ),
      ],
    );
  }

  Widget resourceIcons(IconData icons, Color colors, int value) {
    return Row(
      children: [
        Icon(icons, color: colors, size: 40),
        Text(
          "${value}",
          style: getTextStile(),
        ),
      ],
    );
  }

  TextStyle getTextStile() {
    return const TextStyle(
      fontFamily: 'DeliciousHandrawn',
      color: Colors.black,
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
}

class LevelScaleWidget extends StatelessWidget {
  const LevelScaleWidget({Key? key}) : super(key: key);

  int? getCounter() {
    SimpleCalcWidgetModel simpleCalcWidgetModel = SimpleCalcWidgetModel();
    return simpleCalcWidgetModel.getCounter();
  }

  @override
  Widget build(BuildContext context) {
    final int value =
        ChangeNotifierProvider.watch<SimpleCalcWidgetModel>(context)
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
  int? firstNumber = 0;
  int? summResult;
  Uint8List? flipCard;

  void increment() {
    firstNumber = firstNumber! + 1;
    print("turnCounter++++++++++++++++${firstNumber}");
    notifyListeners();
  }

  Uint8List? updateImage(){
    flipCard = base64.decode(user.image!);
    notifyListeners();
    return flipCard;
  }

  int? getCounter() {
    return firstNumber;
  }
}
