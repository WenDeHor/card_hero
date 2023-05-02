import 'package:hive_flutter/adapters.dart';
import 'package:hive_generator/hive_generator.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

//flutter packages pub run build_runner build --delete-conflicting-outputs
@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String imageUrl;

  User(this.id, this.name, this.imageUrl);
}
