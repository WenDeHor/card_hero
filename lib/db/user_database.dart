import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/user_model.dart';

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  final String tableName = 'users';

  Future<Database> getDataBase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "UserDatabase.db");

    return openDatabase(
      path,
      version: 3,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE $tableName (id TEXT, name TEXT, image TEXT)",
        );
//        await db.execute(
//            "INSERT INTO $tableName ('id', 'name', 'image') values (?, ?, ?)",
//        ["1", "Start name", "cover.jpg"]
//        );
      },
    );
  }

  Future<int> insertUser(User user) async {
    int userId = 0;
    Database db = await getDataBase();
    int? count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tableName"));
    if (count != null && count >= 1) {
//      if (count > 1) {
//        await db.rawDelete("DELETE FROM $tableName WHERE id = '1'");
//      }
      db.rawUpdate(
          "UPDATE $tableName SET id = '${user.id}', name = '${user.name}', image = '${user.image}' WHERE id = '$count'");
    } else {
      var result = await db.rawInsert(
          "INSERT Into $tableName (id, name, image)"
          " VALUES (?, ?, ?)",
          ["1", user.name, user.image]);
      return result;
    }

//    var res = await db.rawInsert(
//        "INSERT Into $tableName (id, name, image) VALUES (${user.id}, ${user.name}, ${user.image})");
//    final String? id;
//    final String? name;
//    final String? imageUrl;
    await db.insert(tableName, user.toMap()).then((value) {
      userId = value;
    });
    return userId;
  }

  Future<List<User>> getAllUsers() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> usersMaps = await db.query(tableName);
    return List.generate(usersMaps.length, (index) {
      return User(
          id: usersMaps[index]["id"],
          name: usersMaps[index]["name"],
          image: usersMaps[index]["image"]);
    });
  }

  Future<User> getUser(int userId) async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> user =
        await db.rawQuery("SELECT * FROM $tableName WHERE id = $userId");
    if (user.length == 1) {
      return User(
          id: user[0]["id"], name: user[0]["name"], image: user[0]["image"]);
    } else {
      return const User();
    }
  }

  Future<void> updateUser(String userId, String name, String image) async {
    Database db = await getDataBase();
    db.rawUpdate(
        "UPDATE $tableName SET name = '$name', image = '$image' WHERE id = '$userId'");
  }

  Future<void> deleteUser(User user) async {
    Database db = await getDataBase();
    await db.rawDelete("DELETE FROM $tableName WHERE id = '${user.id}'");
  }

  Future<void> deleteAll() async {
    Database db = await getDataBase();
    db.rawDelete("DELETE FROM $tableName");
  }

  Future<void> dropTable() async {
    Database db = await getDataBase();
    db.rawDelete("DROP TABLE IF EXISTS users");
  }
}
