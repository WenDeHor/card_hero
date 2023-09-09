import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:card_hero/db/user_database.dart';
import 'package:card_hero/model/user_model.dart';
import 'package:card_hero/utils/build_card_view.dart';
import 'package:card_hero/utils/constants.dart';
import 'package:card_hero/utils/image_and_name_from_list_user.dart';
import 'package:card_hero/utils/image_picker.dart';
import 'package:card_hero/utils/progress_indicator.dart';
import 'package:card_hero/utils/user_status/constants_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
//import 'package:provider/provider.dart';

import '../utils/app_bar.dart';
import 'footer_bar.dart';
import 'mine_flip_card.dart';

ImageAndNameFromListUser imageAndNameFromListUser = ImageAndNameFromListUser();
ProgressIndicatorUtils progressIndicator = ProgressIndicatorUtils();
//final FlipCardController _controller = FlipCardController();

BuildCardView buildCardView = BuildCardView();
ImagePickerPage imagePickerPage = ImagePickerPage();

var counter = 0;
var durarion = 500;
const appName = 'CattyLandy';
User user = User();
List<User> userListGlobal = [];

late UserDatabase userDatabase;

final _model = SimpleCalcWidgetModel();
//final _modelRating = RatingWidgetModel();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<MyApp> {
  @override
  initState() {
    userDatabase = UserDatabase();
    userDatabase.getDataBase().whenComplete(() async {
      _getUserInfo();
      setState(() {});
    });
    super.initState();
  }

  void _getUserInfo() async {
    final users = await userDatabase.getAllUsers();
    setState(() {
      userListGlobal = users;
    });
  }

  @override
  Widget build(BuildContext context) {
//    double width = (MediaQuery.of(context).size.width / 100) * 80;
//    double height = (MediaQuery.of(context).size.height / 100) * 55;

    int? radius = int.parse(userListGlobal.isNotEmpty && userListGlobal[0].lvl != null ? userListGlobal[0].lvl! : "0") * 10;
    String? status = userListGlobal.isNotEmpty && userListGlobal[0].statusSearch != null ? userListGlobal[0].statusSearch! : "0";
    String? level = userListGlobal.isNotEmpty && userListGlobal[0].lvl != null ? userListGlobal[0].lvl! : "0";

//    String? description = userListGlobal.isNotEmpty && userListGlobal[0].descriptionCard != null
//        ? userListGlobal[0].descriptionCard!
//        : "Describe your emotions associated with the photo";
//    Color cardColor = checkColors(level);

    return Scaffold(
      appBar: AppBarConstructor.mineAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          margin: themeMargin,
          padding: themePadding,
          child: ChangeNotifierProvider(
            model: _model,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const UserFlipCard(),
                const SizedBox(height: 10), //divider
                const LevelScaleWidget(),
                const SizedBox(height: 10), //divider//++++++--------
               resourceWidget(level, status, 5000, radius),
              ], //
            ),
          ),
        ),
      ),
      bottomNavigationBar: FooterBar.getMineBar(context, Colors.blue, Colors.brown, Colors.brown, Colors.brown),
    );
  }

//  Widget getFlipCard(double width, double height, String? description, Color cardColor, BuildContext context) {
//    return GestureDetector(
//      child: FlipCard(
//        animationDuration: const Duration(milliseconds: 500),
//        rotateSide: RotateSide.bottom,
//        onTapFlipping: false,
//        axis: FlipAxis.vertical,
//        controller: _controller,
//        frontWidget: SizedBox(
//          width: width,
//          height: height,
//          child: Stack(
//            alignment: AlignmentDirectional.topStart,
//            children: <Widget>[getDefaultImage(userListGlobal), getName(userListGlobal)],
//          ),
//        ),
//        backWidget: Container(
//          width: width,
//          height: height,
//          color: cardColor,
//          child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
//            Text(description!, textAlign: TextAlign.center, style: getTextStileTitle()),
//          ]),
//        ),
//      ),
//      onTap: () {
//        _controller.flipcard();
//        ChangeNotifierProvider.read<SimpleCalcWidgetModel>(context)?.incrementRating();
//        setState(() {
//
//        });
//      },
//    );
//  }

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

  Widget getLevelScaleWidget(BuildContext context) {
    final levelScaleCounter = ChangeNotifierProvider.watch<SimpleCalcWidgetModel>(context)?.ratingCounter ?? 10;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        progressIndicator.getProgressIndicator(levelScaleCounter),
      ],
    );
  }

  Widget resourceWidget(String val_1, String val_2, int val_3, int val_4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      verticalDirection: VerticalDirection.down,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [resourceIconsUserLevel(levelIcon, imageColor_1, val_1), resourceIconsUserStatus(ratingIcon, imageColor_2, val_2)],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [resourceIcons(peopleInTheRadiusIcon, imageColor_3, val_3), resourceIcons(radiusIcon, imageColor_4, val_4)],
        ),
      ],
    );
  }

  Widget resourceIcons(IconData icons, Color colors, int? value) {
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

  Widget resourceIconsUserStatus(IconData icons, Color colors, String? value) {
    return Row(
      children: [
        Icon(icons, color: colors, size: 40),
        Text(
          "${decodeStatus(value)}",
          style: getTextStile(),
        ),
      ],
    );
  }

  String? decodeStatus(String? name) {
    var genderIds = {zero: restingS, one: lookingFriendS, two: searchLoveS, three: wantPlayS, four: wantWalkS, five: walkingS, six: workS};
    return genderIds[name];
  }

  Widget resourceIconsUserLevel(IconData icons, Color colors, String? value) {
    return Row(
      children: [
        Icon(icons, color: colors, size: 40),
        Text(
          "${decodeLevel(value)}",
          style: getTextStile(),
        ),
      ],
    );
  }

  String? decodeLevel(String? lvl) {
    String? index = checkLevel(lvl);
    var levelIds = {zero: trainee, one: rookie, two: pro, three: expert, four: hero, five: legend};
    return levelIds[index];
  }

  String? checkLevel(String? lvl) {
    int? value = int.parse(lvl!);
    if (value <= 10) {
      return "0";
    } else if (10 < value && value <= 30) {
      return "1";
    } else if (30 < value && value <= 70) {
      return "2";
    } else if (70 < value && value <= 200) {
      return "3";
    } else if (200 < value && value <= 500) {
      return "4";
    } else if (500 < value && value <= 1000) {
      return "5";
    } else {
      return "0";
    }
  }

  Color checkColors(String? lvl) {
    int? value = int.parse(lvl!);
    if (value <= 10) {
      return Colors.white60;
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
      return Colors.white60;
    }
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

  @override
  Widget build(BuildContext context) {
    final levelScaleCounter = ChangeNotifierProvider.watch<SimpleCalcWidgetModel>(context)?.ratingCounter ?? 10;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        progressIndicator.getProgressIndicator(levelScaleCounter),
      ],
    );
  }
}

class SimpleCalcWidgetModel extends ChangeNotifier {
  int? ratingCounter = 0;
  int delta = 1;

  Future<void> _incrementLevel() async {
    List<User> usersList2 = await userDatabase.getAllUsers();
    if (usersList2.first.lvl != null) {
      if (int.parse(usersList2.first.lvl!) <= 1000) {
        userDatabase.insertOrUpdateLevelInUser(parserAndIncrementValue(usersList2.first.lvl, 1));
      }
    }
  }

  void incrementRating() {
    if (ratingCounter == 100) {
      _incrementLevel();
      ratingCounter = 0;
      notifyListeners();
    } else {
      print('+++++++++${ratingCounter}');
      ratingCounter = ratingCounter! + delta;
      notifyListeners();
    }
  }

  String parserAndIncrementValue(String? value, int incrementDelta) {
    return (int.parse(value!) + incrementDelta).toString();
  }
}
