import 'dart:convert';
import 'dart:math';
import 'package:card_hero/menu/footer_bar.dart';
import 'package:card_hero/model/user_model.dart';
import 'package:card_hero/utils/dropdown_user_gender.dart';
import 'package:card_hero/utils/dropdown_user_status.dart';
import 'package:card_hero/utils/user_status/constants_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:image_picker/image_picker.dart';

import '../db/user_database.dart';
import '../utils/app_bar.dart';

String labelNameText = 'your name';
const List<String> listUserStatus = <String>[
  'I am resting',
  'I am looking for a friend',
  'In search of love',
  'I want to play',
  'I want to go for a walk',
  'I am walking',
  'I work'
];

class EditUserListCard extends StatefulWidget {
  const EditUserListCard({Key? key}) : super(key: key);

  @override
  _EditUserListCardState createState() => _EditUserListCardState();
}

class _EditUserListCardState extends State<EditUserListCard> {
  late UserDatabase userDatabase;
  List<User> _userList = [];
  String? loadUserStatus;
  int? distance = 123;
  Icon userGender = const Icon(
    Icons.account_box_outlined,
    size: 50,
    color: Colors.grey,
  );

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userDatabase = UserDatabase();
    userDatabase.getDataBase().whenComplete(() async {
      _getUserInfo();
      generateDistance();
      setState(() {});
    });
  }

  void _getUserInfo() async {
    final users = await userDatabase.getAllUsers();
    setState(() {
      _userList = users;
      if (_userList.first.name != null) {
        labelNameText = _userList.first.name!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor.infoAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  listObject(),
                  userTitleInfo(),
                  widgetRow('Gender', const DropdownUserGender()),
                  widgetRow('Status ', const DropdownUserStatus()),
                  fieldName(),
                  buttonSaveName()
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: FooterBar.getEditUserInfoBar(context, Colors.brown, Colors.blue),
    );
  }

  Row widgetRow(String name, StatefulWidget widget) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 10, 0),
          child: Text(
            name,
            style: const TextStyle(color: Colors.black, fontSize: 20, fontStyle: FontStyle.normal),
          ),
        ),
        widget
      ],
    );
  }

  OutlinedButton listObject() {
    updateUserStatus();
    updateUserGender();
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: Colors.blue,
        minimumSize: const Size(88, 70),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: Container(
          padding: const EdgeInsets.all(1),
          child: Row(
            children: [
              userIcon(userGender),
              userListInfo(labelNameText, loadUserStatus!),
              Column(
                children: [
                  userListRow(distance.toString()),
                  userListRow("m"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateUserStatus() {
    loadUserStatus = _userList.isNotEmpty && _userList[0].statusSearch != null
        ? decodeStatus(_userList[0].statusSearch)
        : listUserStatus.first;
  }

  void updateUserGender() async {
    _userList.isNotEmpty && _userList[0].icon != null
        ? getIcon(_userList[0].icon)
        : getDefaultIcon();
  }

  void getIcon(String? value) {
    String val = value ?? "0";
    int index = int.parse(val);
    if (index == 0) {
      getDefaultIcon();
    } else if (index == 1) {
      userGender = const Icon(
        Icons.man,
        size: 50,
        color: Colors.brown,
      );
    } else if (index == 2) {
      userGender = const Icon(
        Icons.woman,
        size: 50,
        color: Colors.deepOrangeAccent,
      );
    }
  }

  void getDefaultIcon() {
    userGender = const Icon(
      Icons.transgender,
      size: 40,
      color: Colors.grey,
    );
  }

  Expanded userListInfo(String name, String status) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Text(
            status,
            style: TextStyle(color: Colors.grey[500], fontSize: 15),
          ),
        ],
      ),
    );
  }

  Column userIcon(Icon userGender) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        userGender,
      ],
    );
  }

  Text userListRow(String data) {
    return Text(
      data,
      style: TextStyle(color: Colors.grey[500], fontSize: 15),
    );
  }

//TODO userInfo ================================================
  Padding userTitleInfo() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Center(
        child: Text('User info in the list',
            style: TextStyle(
                fontFamily: 'DeliciousHandrawn',
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontStyle: FontStyle.italic,
                fontSize: 40.0,
                shadows: [Shadow(offset: Offset(2.0, 2.0), blurRadius: 6.0)])),
      ),
    );
  }

  Padding fieldName() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
      child: TextFormField(
        controller: _nameController,
        validator: (value) {
          return validatorInput(value, 3, 20, 'Enter please 3 to 20 characters');
        },
        decoration: InputDecoration(
            hintText: 'Enter your name',
            hintStyle: const TextStyle(color: Colors.grey, fontStyle: FontStyle.normal, fontSize: 15),
            labelText: labelNameText,
            labelStyle: const TextStyle(color: Colors.blueGrey, fontStyle: FontStyle.normal, fontSize: 20),
            prefixIcon: const Icon(
              Icons.accessibility,
              color: Colors.blueGrey,
            ),
            errorStyle: const TextStyle(fontSize: 20.0),
            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.all(Radius.circular(9.0)))),
      ),
    );
  }

  dynamic validatorInput(dynamic value, int min, int max, String error) {
    if (value.isEmpty || value.length < min || value.length > max) {
      return error;
    }
    return null;
  }

  Padding buttonSaveName() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 30.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 5,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate() && labelNameText != _nameController.text) {
              labelNameText = _nameController.text;
              userDatabase.insertOrUpdateUserName(_nameController.text);
              showSnackBarBySave();
              Navigator.pushNamed(context, '/list_card');
            }
          },
          child: const Text('Save name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
        ),
      ),
    );
  }

  void generateDistance() {
    Random random = Random();
    setState(() {
      distance = random.nextInt(300) + 60;
    });
  }

  void showSnackBarBySave() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('User name: ${_nameController.text} . Saved success'),
      backgroundColor: Colors.green,
    ));
  }

  String? decodeStatus(String? name) {
    var genderIds = {zero: resting, one: lookingFriend, two: searchLove, three: wantPlay, four: wantWalk, five: walking, six: work};
    return genderIds[name];
  }

  String? decodeGender(String? name) {
    var genderIds = {'0': 'No gender', '1': 'Man', '2': 'Woman', '3': null};
    return genderIds[name];
  }
}
