import 'dart:math';

import 'package:card_hero/db/user_database.dart';
import 'package:card_hero/model/user_model.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['No gender', 'Man', 'Woman'];

class DropdownUserGender extends StatefulWidget {
  const DropdownUserGender({super.key});

  @override
  State<DropdownUserGender> createState() => _DropdownUserGenderState();
}

class _DropdownUserGenderState extends State<DropdownUserGender> {
  late UserDatabase userDatabase;
  List<User> _userList = [];

  @override
  void initState() {
    super.initState();
    userDatabase = UserDatabase();
    userDatabase.getDataBase().whenComplete(() async {
      _getUserInfo();
      setState(() {});
    });
  }

  void _getUserInfo() async {
    final users = await userDatabase.getAllUsers();
    setState(() {
      _userList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? dropdownValue;
    if (_userList.isEmpty) {
      dropdownValue = list.first;
    } else {
      if (_userList.first.icon!.isEmpty) {
        dropdownValue = list.first;
      } else {
        dropdownValue = decodeGender(_userList.first.icon);
      }
    }

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
      elevation: 16,
      style: const TextStyle(
          color: Colors.blueGrey, fontSize: 20, fontStyle: FontStyle.normal),
      underline: Container(),
      onChanged: (String? value) {
        userDatabase.insertOrUpdateIconInUser(checkGender(value!));
        setState(() {
          dropdownValue = value!;
          Navigator.pushNamed(context, '/list_card');
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  String? checkGender(String name) {
    var genderIds = {'No gender': '0', 'Man': '1', 'Woman': '2', null: '3'};
    return genderIds[name];
  }

  String? decodeGender(String? name) {
    var genderIds = {'0': 'No gender', '1': 'Man', '2': 'Woman', '3': null};
    return genderIds[name];
  }
}
