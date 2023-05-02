import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';

class ImageConvert {
  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  Future<Uint8List> dataFromBase64String(String base64String) async {
    return base64Decode(base64String);
  }

  Future<String> base64String(Uint8List data) async {
    return base64Encode(data);
  }
}
