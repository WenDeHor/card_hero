import 'package:card_hero/db/user_database.dart';
import 'package:card_hero/model/user_model.dart';
import 'package:card_hero/utils/user_status/bi_object.dart';
import 'package:card_hero/utils/user_status/constants_dropdown.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>[
  'I am resting',
  'I am looking for a friend',
  'In search of love',
  'I want to play',
  'I want to go for a walk',
  'I am walking',
  'I work'
];

List<BiObject> list2 = [
  BiObject(zero, resting),
  BiObject(one, lookingFriend),
  BiObject(two, searchLove),
  BiObject(three, wantPlay),
  BiObject(four, wantWalk),
  BiObject(five, walking),
  BiObject(six, work)
];

class DropdownUserStatus extends StatefulWidget {
  const DropdownUserStatus({super.key});

  @override
  State<DropdownUserStatus> createState() => _DropdownUserStatusState();
}

class _DropdownUserStatusState extends State<DropdownUserStatus> {
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
    String? dropdownValue = _userList.isNotEmpty&&_userList[0].lvl != null
        ? decodeStatus(_userList.first.statusSearch)
        : list.first;

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
      elevation: 16,
      style: const TextStyle(
          color: Colors.blueGrey, fontSize: 20, fontStyle: FontStyle.normal),
      underline: Container(),
      onChanged: (String? value) {
        userDatabase.insertOrUpdateStatusSearch(checkStatus(value!));
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

  String? checkStatus(String name) {
    var genderIds = {
      resting: zero,
      lookingFriend: one,
      searchLove: two,
      wantPlay: three,
      wantWalk: four,
      walking: five,
      work: six
    };
    return genderIds[name];
  }

  String? decodeStatus(String? name) {
    var genderIds = {
      zero: resting,
      one: lookingFriend,
      two: searchLove,
      three: wantPlay,
      four: wantWalk,
      five: walking,
      six: work
    };
    return genderIds[name];
  }
}
