import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

//import 'package:flutter/rendering.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../menu/navbar.dart';
import '../../menu/2_screan.dart';
import '../db/user_hive_repository.dart';
import '../model/user_model.dart';

var themeAppColor = Colors.blue[400];
var themeMargin = const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0);
var themePadding = const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0);

var changePhotoCard = 'Change photo card';
var changeDescription = 'Change description';
var themeSizeButton = const Size.fromHeight(30);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}

class HomeScreen extends StatefulWidget  {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  {
//  @override
//  Scaffold build(BuildContext context)  {
//    return Scaffold();
//  }

  Future<Widget> build2(BuildContext context) async {
    FlipCardController _cong = FlipCardController();
    Image image;
    final _userDataBox = await Hive.openBox<User>('user_box');
    User? user = _userDataBox.getAt(1);
    if (_userDataBox.getAt(1)?.imageUrl == null) {
      image = Image.asset('assets/cover.jpg', fit: BoxFit.cover);
    } else {
      image = Image.memory(base64Decode(user!.imageUrl));
    }
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
              frontWidget:buildCardView(450, 300, 60, 50, image),
              backWidget: buildCardView(450, 300, 60, 50, Image.asset('assets/cover.jpg', fit: BoxFit.cover)),
            ),
//            Image.asset(image, fit: BoxFit.cover)
            Column(
              children: <Widget>[
                buildFilledButton(context, changePhotoCard, '/todo'),
                buildFilledButton(context, changeDescription, '/todo')
              ],
            ),
          ],
        ),
      ),
    );
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
    return FilledButton(
        onPressed: () async {
          var image = await ImagePicker()
              .pickImage(source: ImageSource.gallery, imageQuality: 45);
          var imageBytes = await image!.readAsBytes();
          String base64Image = base64Encode(imageBytes);
          User user = User('1', 'Your name', base64Image);

          final _userDataBox = await Hive.openBox<User>('user_box');
          _userDataBox.add(user);
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

//  frontWidget: buildCardView(450, 300, 60, 50, 'assets/cover.jpg'),
//  Future<Center> buildCardView2() async {
//    Image image;
//    final _userDataBox = await Hive.openBox<User>('user_box');
//    User? user = _userDataBox.getAt(1);
//    if (_userDataBox.getAt(1)?.imageUrl == null) {
//      image = Image.asset('assets/cover.jpg', fit: BoxFit.cover);
//    } else {
//      image = Image.memory(base64Decode(user!.imageUrl));
//    }
//
//    return Center(
//      child: SizedBox(
//        height: 450,
//        width: 300,
//        child: ClipRRect(
//          borderRadius: BorderRadius.circular(60), // Image border
//          child: SizedBox.fromSize(
//            size: Size.fromRadius(50), // Image radius
//            child: image,
//          ),
//        ),
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return build2( context);
  }
}
