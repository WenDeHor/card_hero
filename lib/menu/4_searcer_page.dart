import 'package:card_hero/db/user_database.dart';
import 'package:card_hero/menu/defoult_flip_card.dart';
import 'package:card_hero/model/user_FDB.dart';
import 'package:card_hero/model/user_model.dart';
import 'package:card_hero/utils/build_card_view.dart';
import 'package:card_hero/utils/image_and_name_from_list_user.dart';
import 'package:card_hero/utils/image_picker.dart';
import 'package:card_hero/utils/progress_indicator.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//import 'package:provider/provider.dart';

import '../utils/app_bar.dart';
import 'footer_bar.dart';

ImageAndNameFromListUser imageAndNameFromListUser = ImageAndNameFromListUser();
ProgressIndicatorUtils progressIndicator = ProgressIndicatorUtils();

BuildCardView buildCardView = BuildCardView();
ImagePickerPage imagePickerPage = ImagePickerPage();

var counter = 0;
var durarion = 500;
const appName = 'CattyLandy';
User user = User();
List<User> userListGlobal = [];

List<UserFDB>testUser = [];

late UserDatabase userDatabase;

class Searcher extends StatefulWidget {
  const Searcher({Key? key}) : super(key: key);

  @override
  SearcherScreenState createState() => SearcherScreenState();
}

class SearcherScreenState extends State<Searcher> {

  @override
  initState() {
    userDatabase = UserDatabase();
    userDatabase.getDataBase().whenComplete(() async {
      _getUserInfo();
      setState(() {});
    });
    super.initState();
//    initFirebase(); //TODO+++++++++++++
    testUser.addAll([
      UserFDB(
          "idSqlLite",
          "idFirebase",
          "49.1111452",
          "28.7099285",
          "1",
          "Tato",
          "This is description Card",
          "This is description User",
          "2"),
      UserFDB(
          "idSqlLite",
          "idFirebase",
          "55.8683112",
          "9.8499901",
          "2",
          "Ivan",
          "This is description Card",
          "This is description User",
          "3"),
    ]

    );
  }

//  void initFirebase() async{
//    WidgetsFlutterBinding.ensureInitialized();
//    await Firebase.initializeApp();
//  }

  void _getUserInfo() async {
    final users = await userDatabase.getAllUsers();
    setState(() {
      userListGlobal = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarConstructor.mineAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Form(
                child: Column(
//                mainAxisAlignment: MainAxisAlignment.end,
//                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DefaultFlipCard().getFlipCard(context),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buttonForm(getNameLogin(), '/user_login'),
                        buttonForm(getNameRegistration(), '/user_registration'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      bottomNavigationBar: FooterBar.getLoginBar(
          context, Colors.blue, Colors.brown, Colors.brown, Colors.brown),
    );
  }

  Padding buttonForm(Text name, String url) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width, // <-- match_parent
        height: 50, // <-- match-parent
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ))),
          onPressed: () async {
            Navigator.pushNamed(context, url);
          },
          child: name,
        ),
      ),
    );
  }

  Text getNameLogin() {
    return const Text('Login',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ));
  }

  Text getNameRegistration() {
    return const Text('Registration',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ));
  }

//    String kilometers = "kilometers";
//    String meters = "meters";
//    String miles = "miles";

//    String getDistanceBetweenPointsNew(String lat1, String lon1, String lat2, String lon2, String unit) {
//      double latitude1 = double.parse(lat1);
//      double longitude1 = double.parse(lon1);
//      double latitude2 = double.parse(lat2);
//      double longitude2 = double.parse(lon2);
//
//      double theta = longitude1 - longitude2;
//      double distance = (60 * 1.1515 * (180 / pi) * acos(
//          sin(latitude1 * (pi / 180)) * sin(latitude2 * (pi / 180)) +
//              cos(latitude1 * (pi / 180)) * cos(latitude2 * (pi / 180)) * cos(theta * (pi / 180))
//      ));
//      if (unit == miles) {
//        return distance.toString();
//      } else if (unit == kilometers) {
//        return (distance * 1.609344).toString();
//      } else {
//        return "no distance";
//      }
//    }

//  private static double calcBearing(double lat1, double lon1, double lat2, double lon2) {
//
//    // to convert degrees to radians, multiply by:
//    final double rad = Math.toRadians(1.0);
//    // to convert radians to degrees:
//    final double deg = Math.toDegrees(1.0);
//
//    double GLAT1 = rad * (lat1);
//    double GLAT2 = rad * (lat2);
//    double GLON1 = rad * (lon1);
//    double GLON2 = rad * (lon2);
//
//    // great circle angular separation in radians
//    double alpha = Math.acos(Math.sin(GLAT1) * Math.sin(GLAT2) + Math.cos(GLAT1) * Math.cos(GLAT2)
//        * Math.cos(GLON1 - GLON2));
//
//    // forward azimuth from point 1 to 2 in radians
//    double s2 = rad * (90.0 - lat2);
//    double FAZ = Math.asin(Math.sin(s2) * Math.sin(GLON2 - GLON1) / Math.sin(alpha));
//
//    double result = FAZ * deg; // radians to degrees
//    if (result < 0.0) result += 360.0; // reset az from -180 to 180 to 0 to 360
//
//    return result;
//  }
  }


