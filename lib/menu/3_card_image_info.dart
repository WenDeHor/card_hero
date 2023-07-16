import 'dart:convert';

import 'package:card_hero/model/user_model.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../db/user_database.dart';
import '../utils/app_bar.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  late UserDatabase userDatabase;
  List<User> _userList = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
    print("++++++++++++++++++${users.toString()}");
    print("++++++++++++++++++${users.length}");
    setState(() {
      _userList = users;
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fieldImage(_userList),
                    buttonOnImage(),
                    userInfo(),
                    fieldName(),
                    fieldDescription(),
                    fieldPhone(),
                    fieldPassword(),
                    buttonSubmit(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

//TODO Image ================================================
  Padding fieldImage(List<User> userList) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Center(
        child: SizedBox(
          width: (MediaQuery.of(context).size.width / 100) *
              80, // <-- match_parent
          height: (MediaQuery.of(context).size.height / 100) * 55, //
          child: userList.isNotEmpty && userList.last.image != null
              ? Image.memory(base64.decode(userList.last.image!))
              : Image.asset('assets/cover23.jpg', fit: BoxFit.cover),
        ),
      ),
    );
  }

  Padding buttonOnImage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 30.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width, // <-- match_parent
        height: 50, // <-- match-parent
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ))),
          onPressed: () async {
            String byte64String;
            try {
              byte64String = await pickImage();
              if (byte64String.isNotEmpty) {
                UserDatabase().insertOrUpdateImageInUser(byte64String);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('image loaded success'),
                  backgroundColor: Colors.green,
                ));
                Navigator.pushNamed(context, '/user_info');
              } else {
                Navigator.pushNamed(context, '/user_registration');
              }
            } catch (e) {
              errorToast("Please upload photo 3x4");
            }
          },
          child: const Text('Upload photo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              )),
        ),
      ),
    );
  }

  Future<String> pickImage() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);
    var imageBytes = await image!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

//TODO userInfo ================================================
  Padding userInfo() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Center(
        child: Text('User info',
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
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: TextFormField(
        controller: _nameController,
        validator: (value) {
          return validatorInput(
              value, 3, 20, 'Enter please 3 to 20 characters');
        },
        decoration: const InputDecoration(
            hintText: 'Enter your name',
            labelText: 'your name',
            prefixIcon: Icon(
              Icons.person,
              color: Colors.blueGrey,
            ),
            errorStyle: TextStyle(fontSize: 18.0),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(9.0)))),
      ),
    );
  }

  Padding fieldDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: TextFormField(
        controller: _descriptionController,
        minLines: 1,
        // Set this
        maxLines: 8,
        // and this
        keyboardType: TextInputType.multiline,
        validator: (value) {
          return validatorInput(
              value, 3, 200, 'Enter please 3 to 50 characters');
        },
        decoration: const InputDecoration(
            hintText: 'Enter description',
            labelText: 'description',
            prefixIcon: Icon(
              Icons.description,
              color: Colors.blueGrey,
            ),
            errorStyle: TextStyle(fontSize: 18.0),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(9.0)))),
      ),
    );
  }

  Padding fieldPhone() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: TextFormField(
        controller: _phoneController,
        validator: (value) {
          return validatorInput(value, 3, 15, 'Enter phone');
        },
        decoration: const InputDecoration(
            hintText: 'Enter your phone',
            labelText: 'your phone',
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.blueGrey,
            ),
            errorStyle: TextStyle(fontSize: 18.0),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(9.0)))),
      ),
    );
  }

  Padding fieldPassword() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: TextFormField(
        controller: _passwordController,
        validator: (value) {
          return validatorInput(value, 3, 15, 'Enter password');
        },
        decoration: const InputDecoration(
            hintText: 'Enter your password',
            labelText: 'your password',
            prefixIcon: Icon(
              Icons.add_moderator,
              color: Colors.blueGrey,
            ),
            errorStyle: TextStyle(fontSize: 18.0),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(9.0)))),
      ),
    );
  }

  dynamic validatorInput(dynamic value, int min, int max, String error) {
    if (value.isEmpty || value.length < min || value.length > max) {
      return error;
    }
    return null;
  }

  void pressedButton() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Load image"),
      backgroundColor: Colors.deepOrange[200],
    ));
  }

  void errorToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.deepOrange[200],
    ));
  }

  Padding buttonSubmit() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 30.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 5, // <-- match_parent
        height: 50, // <-- match-parent
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ))),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              userDatabase.insertOrUpdateUserCard(
                  _phoneController.text,
                  _nameController.text,
                  _descriptionController.text,
                  _passwordController.text);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('User info saved success'),
                backgroundColor: Colors.green,
              ));
            }
          },
          child: const Text('Save info',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
        ),
      ),
    );
  }
}
