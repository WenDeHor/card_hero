import 'package:card_hero/model/user_power.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/user_power.dart';

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserPowerDB {
  final String tableName = 'usersPower';
  final String userDB = 'UserPowerDatabase.db';

  Future<Database> getDataBase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, userDB);
    return openDatabase(
      path,
      version: 2,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE $tableName (id TEXT, counter INTEGER)",
        );
      },
    );
  }

  Future<void> insertCounter(int counter) async {
    Database db = await getDataBase();
    int? count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tableName"));
    if (count != null && count >= 1) {
      await db
          .rawUpdate("UPDATE $tableName SET counter = '$counter' WHERE id='userPower'");
    } else {
      await db.rawInsert(
          "INSERT INTO $tableName (id, counter) VALUES ('userPower', '$counter')");
    }
  }

  Future<UserPower> getCounter() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> userPower =
    await db.rawQuery("SELECT * FROM $tableName WHERE id = 'userPower'");
    if (userPower.length == 1) {
      return UserPower(
          id: userPower[0]["id"], counter: userPower[0]["counter"]);
    } else {
      return const UserPower();
    }
  }




}
