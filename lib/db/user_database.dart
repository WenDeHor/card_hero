import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/user_model.dart';

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserDatabase {
  final String tableName = 'users';
  final String userDB = 'UserDatabase.db';

  Future<Database> getDataBase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, userDB);
    return openDatabase(
      path,
      version: 2,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE $tableName (id TEXT, name TEXT, image TEXT, description TEXT)",
        );
      },
    );
  }

  Future<void> insertOrUpdateImageInUser(String image) async {
    Database db = await getDataBase();
    int? count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tableName"));
    if (count != null && count >= 1) {
//      db.rawDelete("DELETE FROM $tableName");
      await db
          .rawUpdate("UPDATE $tableName SET image = '$image' WHERE id='user'");
    } else {
      await db.rawInsert(
          "INSERT INTO $tableName (id, image) VALUES ('user', '$image')");
    }
  }

  Future<List<User>> getAllUsers() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> usersMaps = await db.query(tableName);
    return List.generate(usersMaps.length, (index) {
      return User(
          id: usersMaps[index]["id"],
          name: usersMaps[index]["name"],
          image: usersMaps[index]["image"],
          description: usersMaps[index]["description"]);
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
    db.rawDelete("DELETE FROM $tableName WHERE id = 1");
  }

  Future<void> dropTable() async {
    Database db = await getDataBase();
    db.rawDelete("DROP TABLE IF EXISTS users");
  }
}
