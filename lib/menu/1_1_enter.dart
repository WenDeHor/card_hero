import 'package:card_hero/menu/defoult_flip_card.dart';
import 'package:card_hero/menu/footer_bar.dart';
import 'package:flutter/material.dart';

import '../utils/app_bar.dart';

class UserEnter extends StatefulWidget {
  const UserEnter({Key? key}) : super(key: key);

  @override
  _UserEnterState createState() => _UserEnterState();
}

class _UserEnterState extends State<UserEnter> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor.loginAppBar(context),
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
}
