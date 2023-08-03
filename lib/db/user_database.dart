import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/user_model.dart';

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserDatabase {
  final String tableName = 'users';

//  final String userDB = 'UserDatabase.db';
  final String userDB = 'UserDatabase.db';

  Future<Database> getDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'user_database');
    var database =
        await openDatabase(path, version: 3, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql =
        "CREATE TABLE users (id_sql_lite TEXT, id_firebase TEXT, phone TEXT, password TEXT, stiles TEXT, longitude TEXT, latitude TEXT, language TEXT, icon TEXT, name TEXT, image TEXT, description_card TEXT, description_user TEXT, status_search TEXT, lvl TEXT, rating TEXT, id_device TEXT);";
    await database.execute(sql);
  }

  Future<void> insertOrUpdateImageInUser(String image) async {
    Database db = await getDataBase();
//    db.rawDelete("DROP TABLE IF EXISTS users");
    int? count =
        Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM users"));
//    print("++++++++++++++DB++++DELETED");
//    db.rawDelete("DELETE FROM users");
    if (count != null && count >= 1) {
      await db.rawUpdate(
          "UPDATE users SET image = '$image' WHERE id_sql_lite='user'");
    } else {
      print("++++++++++++++DB++++${image.length}");
      await db.rawInsert(
          "INSERT INTO users (id_sql_lite, image) VALUES ('user', '$image');");
    }
  }

  Future<void> insertOrUpdateIconInUser(String? icon) async {
    Database db = await getDataBase();
    int? count =
    Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM users"));
    if (count != null && count >= 1) {
      print("++++++UPDATE++++++++DB++++${icon}");
      await db.rawUpdate(
          "UPDATE users SET icon = '$icon' WHERE id_sql_lite='user'");
    } else {
      print("++++++INSERT++++++++DB++++${icon}");
      await db.rawInsert(
          "INSERT INTO users (id_sql_lite, icon) VALUES ('user', '$icon');");
    }
  }

  Future<void> insertOrUpdateStatusSearch(String? status) async {
    Database db = await getDataBase();
    int? count =
    Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM users"));
    if (count != null && count >= 1) {
      print("++++++UPDATE++++++++DB++++${status}");
      await db.rawUpdate(
          "UPDATE users SET status_search = '$status' WHERE id_sql_lite='user'");
    } else {
      print("++++++INSERT++++++++DB++++${status}");
      await db.rawInsert(
          "INSERT INTO users (id_sql_lite, status_search) VALUES ('user', '$status');");
    }
  }

  Future<void> insertOrUpdateUserName(String? name) async {
    Database db = await getDataBase();
    int? count =
    Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM users"));
    if (count != null && count >= 1) {
      await db.rawUpdate(
          "UPDATE users SET name = '$name' WHERE id_sql_lite='user'");
    } else {
      await db.rawInsert(
          "INSERT INTO users (id_sql_lite, name) VALUES ('user', '$name');");
    }
  }

  Future<void> insertUserRegistration(
    String phone,
    String password,
    String name,
  ) async {
    Database db = await getDataBase();
        print("++++++++++++++DB++++CREATE");
//    String sql =
//        "CREATE TABLE users (id_sql_lite TEXT, id_firebase TEXT, phone TEXT, password TEXT, stiles TEXT, longitude TEXT, latitude TEXT, language TEXT, icon TEXT, name TEXT, image TEXT, description_card TEXT, description_user TEXT, status_search TEXT, lvl TEXT, rating TEXT, id_device TEXT);";
//    await db.execute(sql);
    int? count =
        Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM users"));
    if (count != null && count >= 1) {
      print(
          "++++++UPDATE++DB++++phone: $phone, password: $password, name: $name");
      await db.rawUpdate(
          "UPDATE users SET phone = '$phone', password = '$password', name = '$name' WHERE id_sql_lite='user'");
    } else {
      print(
          "++++++INSERT+INTO++DB++++phone: $phone, password: $password, name: $name");
      await db.rawInsert(
          "INSERT INTO users (id_sql_lite, phone, password, name) VALUES ('user','$phone', '$password', '$name');");
    }
  }

//TODO==========================================================>>>>>>
  Future<void> insertOrUpdateUserFlipCard(String descriptionCard) async {
    Database db = await getDataBase();
    //db.rawDelete("DELETE FROM $tableName");
    int? count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tableName"));
    if (count != null && count >= 1) {
      print(
          "UPDATE description_card = '$descriptionCard'");
      await db.rawUpdate(
          "UPDATE users SET description_card = '$descriptionCard' WHERE id_sql_lite='user'");
    } else {
      await db.rawInsert(
          "INSERT INTO users (id_sql_lite, description_card) VALUES ('user', '$descriptionCard');");
    }
  }

  Future<List<User>> getAllUsers() async {
    Database db = await getDataBase();
//    print("++++++++++++++DB++++CREATE");
//    String sql =
//        "CREATE TABLE users (id_sql_lite TEXT, id_firebase TEXT, phone TEXT, password TEXT, stiles TEXT, longitude TEXT, latitude TEXT, language TEXT, icon TEXT, name TEXT, image TEXT, description_card_card TEXT, description_card_user TEXT, status_search TEXT, lvl TEXT, rating TEXT, id_device TEXT);";
//    await db.execute(sql);
    List<Map<String, dynamic>> usersMaps = await db.query(tableName);
    return List.generate(usersMaps.length, (index) {
      return User(
          idSqlLite: usersMaps[index]["id_sql_lite"],
          idFirebase: usersMaps[index]["id_firebase"],
          phone: usersMaps[index]["phone"],
          password: usersMaps[index]["password"],
          stiles: usersMaps[index]["stiles"],
          longitude: usersMaps[index]["longitude"],
          language: usersMaps[index]["language"],
          icon: usersMaps[index]["icon"],
          name: usersMaps[index]["name"],
          image: usersMaps[index]["image"],
          descriptionCard: usersMaps[index]["description_card"],
          descriptionUser: usersMaps[index]["description_user"],
          statusSearch: usersMaps[index]["status_search"],
          lvl: usersMaps[index]["lvl"],
          rating: usersMaps[index]["rating"],
          idDevice: usersMaps[index]["id_device"]
      );
    });
  }

  Future<User> getUser() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> user =
        await db.rawQuery("SELECT * FROM $tableName WHERE id_sql_lite='user'");
    if (user.length == 1) {
      return User(
          idSqlLite: user[0]["id_sql_lite"],
          phone: user[0]["phone"],
          name: user[0]["name"],
          image: user[0]["image"],
          descriptionCard: user[0]["description_card"],
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
      await db.rawUpdate(
          "UPDATE $tableName SET lvl = '$lvl', rating = '$rating' WHERE id_sql_lite='user'");
    } else {
      await db.rawInsert(
          "INSERT INTO $tableName (lvl, rating) VALUES ('$lvl', '$rating')");
    }
  }

  Future<User> getRating() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> user = await db.rawQuery(
        "SELECT lvl, rating FROM $tableName WHERE id_sql_lite = 'user'");
    if (user.length == 1) {
      return User(lvl: user[0]["lvl"], rating: user[0]["rating"]);
    } else {
      return User();
    }
  }

  //TODO not use
  Future<void> updateUser(String userId, String name, String image) async {
    Database db = await getDataBase();
    db.rawUpdate(
        "UPDATE $tableName SET name = '$name', image = '$image' WHERE id_sql_lite = 'user'");
  }

  //TODO not use
  Future<void> deleteUser() async {
    Database db = await getDataBase();
    await db.rawDelete("DELETE FROM $tableName WHERE id_sql_lite = 'user'");
  }

  //TODO not use
  Future<void> dropTable() async {
    Database db = await getDataBase();
    db.rawDelete("DROP TABLE IF EXISTS users");
  }
}
