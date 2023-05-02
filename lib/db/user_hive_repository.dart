import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/user_model.dart';

class UserHiveRepository {
  final Box<User> userBox;

  UserHiveRepository(this.userBox);

  Future<void> saveImage(User user) async  {
    var box = await Hive.openBox('user_box');
    box.put("user", user);
  }
}
