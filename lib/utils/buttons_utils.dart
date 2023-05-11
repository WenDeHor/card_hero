import 'dart:convert';

import 'package:card_hero/db/user_database.dart';
import 'package:card_hero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ButtonsUtils{
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