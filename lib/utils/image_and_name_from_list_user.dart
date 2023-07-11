import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:card_hero/menu/1_screan.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:card_hero/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/user_model.dart';

class ImageAndNameFromListUser {
  Image getImageByList(List userssss) {
    if (userssss.isNotEmpty) {
      return Image.memory(base64.decode(userssss.last.image!));
    } else {
      return Image.asset('assets/cover.jpg', fit: BoxFit.cover);
    }
  }

  Image getImageByUser(User user) {
    if (user.image == null) {
      return Image.asset('assets/cover.jpg', fit: BoxFit.cover);
    } else {
      Uint8List path = base64.decode(user.image!);
      final size = ImageSizeGetter.getSize(MemoryInput(path));
      final width = size.height;
      final height = size.width;
      print('+++++++++++width : $width ++++++height : $height');
      return Image.memory(base64.decode(user.image!));
    }
  }

  Uint8List getUint8List(User user) {
    return base64.decode(user.image!);
  }

  Text getNameByList(List userssss) {
    if (userssss.isNotEmpty) {
      if (userssss.last.name == null) {
        return getText('Enter your name');
      } else {
        return getText(userssss.last.name);
      }
    }
    return Text('Enter your name');
  }

  Text getNameByUser(User user) {
    if (user.name == null) {
      return getText('Enter your name');
    } else {
      return getText(user.name!);
    }
  }

  Text getText(String text) {
    return Text(text,
        style: TextStyle(
            color: themeTextCardColor,
            fontWeight: themeTextFont,
            fontSize: themeTextSize));
  }
}
