import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:card_hero/db/user_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

import '../../menu/navbar.dart';
import '../model/user_model.dart';

var themeAppColor = Colors.blue[400];
var themeMargin = const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0);
var themePadding = const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0);

var themeTextCardColor = Colors.white;
var themeTextFont = FontWeight.bold;
var themeTextSize = 22.0;

var changePhotoCard = 'Change photo card';
var changeDescription = 'Change description';
var themeSizeButton = const Size.fromHeight(30);

List<User> pList = [];

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
  List<User> userssss = [];
  User user = const User();

  @override
  initState() {
    super.initState();
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
//      user=data;
      print("+++++++++++++++${userssss.toString()}");
      print("+++++++++++++++${userssss.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    FlipCardController _cong = FlipCardController();
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text('My hero'),
        backgroundColor: themeAppColor,
      ),
      body: Container(
        margin: themeMargin,
        padding: themePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlipCard(
              rotateSide: RotateSide.bottom,
              onTapFlipping: true,
              axis: FlipAxis.vertical,
              controller: _cong,
              frontWidget: Center(
                child: SizedBox(
                  height: 450,
                  width: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    // Image border
                    child: SizedBox.fromSize(
                        size: Size.fromRadius(50),
                        child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              getImage(userssss),
                              getName(userssss)
                            ])), // Image radius
//                        child:  getImage(userssss)),
                  ),
                ),
              ),
              backWidget: buildCardView(450, 300, 60, 50,
                  Image.asset('assets/cover.jpg', fit: BoxFit.cover)),
            ),
            Column(
              children: <Widget>[
                loadImageButton(context, changePhotoCard),
                buildFilledButton(context, changeDescription, '/todo')
              ],
            ),
          ],
        ),
      ),
    );
  }

  Image getImage(List userssss) {
    if (userssss.isNotEmpty) {
      return Image.memory(base64.decode(userssss.last.image!));
    } else {
      return Image.asset('assets/cover.jpg', fit: BoxFit.cover);
    }
  }

  Text getName(List userssss) {
    if (userssss.isNotEmpty) {
      if (userssss.last.name == null) {
        return getText('Enter your name');
      } else {
        return getText(userssss.last.name);
      }
    }
    return Text('Enter your name');
  }

  Text getText(String text) {
    return Text(text,
        style: TextStyle(
            color: themeTextCardColor,
            fontWeight: themeTextFont,
            fontSize: themeTextSize));
  }

  Center buildCardView(double height, double width, double radiusBorder,
      double radiusImage, Image image) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radiusBorder), // Image border
          child: SizedBox.fromSize(
              size: Size.fromRadius(radiusImage), // Image radius
              child: image),
        ),
      ),
    );
  }

  FilledButton buildFilledButton(
      BuildContext context, String name, String url) {
    return FilledButton(
        onPressed: () {
          Navigator.pushNamed(context, url);
        },
        style: FilledButton.styleFrom(
          fixedSize: themeSizeButton,
          backgroundColor: themeAppColor,
          elevation: 5,
        ),
        child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ));
  }

  FilledButton loadImageButton(BuildContext context, String name) {
    String byte64String;
    return FilledButton(
        onPressed: () async {
          try {
            byte64String = await pickImage();
            if (byte64String.length > 0) {
              UserDatabase().insertOrUpdateImageInUser(byte64String);
            }
            Navigator.pushNamed(context, '/');
          } catch (e) {
            print("ERROR while picking file.");
            Navigator.pushNamed(context, '/');
          }
        },
        style: FilledButton.styleFrom(
          fixedSize: themeSizeButton,
          backgroundColor: themeAppColor,
          elevation: 5,
        ),
        child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ));
  }

  Future<String> pickImage() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);
    var imageBytes = await image!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }
}
