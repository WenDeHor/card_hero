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
          "CREATE TABLE $tableName (idSqlLite TEXT, idFirebase TEXT, phone TEXT, stiles TEXT, longitude TEXT, latitude TEXT, language TEXT, icon TEXT, name TEXT, image TEXT, description TEXT, lvl TEXT, rating TEXT)",
        );
      },
    );
  }

  Future<void> insertOrUpdateImageInUser(
      String idSqlLite,
      String phone,
      String name,
      String image,
      String description,
      String lvl,
      String rating) async {
    Database db = await getDataBase();
    int? count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tableName"));
    if (count != null && count >= 1) {
//      db.rawDelete("DELETE FROM $tableName");
      await db.rawUpdate(
          "UPDATE $tableName SET image = '$image', phone = '$phone', name = '$name', image = '$image', description = '$description', lvl = '$lvl', rating = '$rating'  WHERE idSqlLite='user'");
    } else {
      await db.rawInsert(
          "INSERT INTO $tableName (idSqlLite, phone, name, image, description, lvl, rating) VALUES ('user','$phone','$name','$image','$description','$lvl','$rating')");
    }
  }

  Future<List<User>> getAllUsers() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> usersMaps = await db.query(tableName);
    return List.generate(usersMaps.length, (index) {
      return User(
          idSqlLite: usersMaps[index]["idSqlLite"],
          phone: usersMaps[index]["phone"],
          name: usersMaps[index]["name"],
          image: usersMaps[index]["image"],
          description: usersMaps[index]["description"],
          lvl: usersMaps[index]["lvl"],
          rating: usersMaps[index]["rating"]);
    });
  }

  Future<User> getUser(int userId) async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> user =
        await db.rawQuery("SELECT * FROM $tableName WHERE idSqlLite = $userId");
    if (user.length == 1) {
      return User(
          idSqlLite: user[0]["idSqlLite"],
          phone: user[0]["phone"],
          name: user[0]["name"],
          image: user[0]["image"],
          description: user[0]["description"],
          lvl: user[0]["lvl"],
          rating: user[0]["rating"]);
    } else {
      return User();
    }
  }

  Future<void> setRating(int lvl, int rating) async {
    Database db = await getDataBase();
    int? count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tableName"));
    if (count != null && count >= 1) {
      await db
          .rawUpdate("UPDATE $tableName SET lvl = '$lvl', rating = '$rating' WHERE idSqlLite='user'");
    } else {
      await db.rawInsert(
          "INSERT INTO $tableName (lvl, rating) VALUES ('$lvl', '$rating')");
    }
  }

  Future<User> getRating() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> user =
    await db.rawQuery("SELECT lvl, rating FROM $tableName WHERE idSqlLite = 'user'");
    if (user.length == 1) {
      return User(
          lvl: user[0]["lvl"],
          rating: user[0]["rating"]);
    } else {
      return User();
    }
  }

  //TODO not use
  Future<void> updateUser(String userId, String name, String image) async {
    Database db = await getDataBase();
    db.rawUpdate(
        "UPDATE $tableName SET name = '$name', image = '$image' WHERE idSqlLite = 'user'");
  }
  //TODO not use
  Future<void> deleteUser(User user) async {
    Database db = await getDataBase();
    await db.rawDelete("DELETE FROM $tableName WHERE idSqlLite = 'user'");
  }
  //TODO not use
  Future<void> dropTable() async {
    Database db = await getDataBase();
    db.rawDelete("DROP TABLE IF EXISTS users");
  }
}
