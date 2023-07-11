import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '1_screan.dart';

class ButtonsGroup extends StatelessWidget {
  const ButtonsGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buttonsUtils.loadImageButton(context, changePhotoCard),
        FilledButton(
            onPressed: () {
              setState() {
                cardKey.currentState?.activate();
                controller.flipcard();
                if (turnCounter >= 100) {
                  turnCounter++;
                  print("${turnCounter}");
                }
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
    );
  }
}