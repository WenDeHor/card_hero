import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

//import 'package:flutter/rendering.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

import '../../menu/navbar.dart';
import '../../menu/2_screan.dart';

var themeAppColor = Colors.blue[400];
var themeMargin = const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0);
var themePadding = const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0);

var changePhotoCard = 'Change photo card';
var changeDescription = 'Change description';
var themeSizeButton = const Size.fromHeight(30);

class MyApp extends StatelessWidget {
//  const MyApp({Key? key}) : super(key: key);
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
//    return MaterialApp(
//      // Remove the debug banner
//      debugShowCheckedModeBanner: false,
//      title: 'Flip card',
//      theme: ThemeData(
//        primarySwatch: Colors.teal,
//      ),
//      home: const HomeScreen(),
//    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    FlipCardController _cong = FlipCardController();

    return Scaffold(
      drawer: Navbar(),
//      floatingActionButton: Theme(
//        data: Theme.of(context).copyWith(splashColor: Colors.red),
//        child: FloatingActionButton(
//          onPressed: () {},
//          child: const Icon(Icons.add),
//        ),
//      ),
      appBar: AppBar(
          title: const Text('My hero'),
          backgroundColor: themeAppColor,),
      body: Container(
        margin: themeMargin,
        padding: themePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlipCard(
              rotateSide: RotateSide.bottom,
              onTapFlipping: true,
              //When enabled, the card will flip automatically when touched.
              axis: FlipAxis.vertical,
              controller: _cong,
              frontWidget: buildCardView(450, 300, 60, 50, 'assets/cover.jpg'),
              backWidget: buildCardView(450, 300, 60, 50, 'assets/cover.jpg'),
            ),
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
      double radiusImage, String image) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radiusBorder), // Image border
          child: SizedBox.fromSize(
              size: Size.fromRadius(radiusImage), // Image radius
              child: Image.asset(image, fit: BoxFit.cover)),
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
//          primary: Colors.teal, // background color
//          onPrimary: Colors.white, // foreground color
          fixedSize: themeSizeButton,
          backgroundColor: themeAppColor,
//          animationDuration: Duration(milliseconds: 5000),
          elevation: 5, // elevation of button
        ),
//        style: ButtonStyle(
//          overlayColor: MaterialStateProperty.resolveWith<Color?>(
//            (Set<MaterialState> states) {
//              return states.contains(MaterialState.pressed)
//                  ? Colors.greenAccent
//                  : Colors.greenAccent;
//            },
//          ),
//        ),
        child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ));
  }
}
