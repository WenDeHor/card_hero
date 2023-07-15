import 'dart:convert';

import 'package:card_hero/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../db/user_database.dart';
import '../utils/app_bar.dart';

User user = User();

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  late UserDatabase userDatabase;
  List<User> userList = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      userList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarConstructor.registrationAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fieldImage(userList),
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
    double width = (MediaQuery.of(context).size.width / 100) * 80;
    double height = (MediaQuery.of(context).size.height / 100) * 55;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: userList.isNotEmpty
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
        width: MediaQuery.of(context).size.width - 5, // <-- match_parent
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
        controller: nameController,
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
        controller: descriptionController,
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
        controller: phoneController,
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
        controller: passwordController,
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
    Fluttertoast.showToast(
        msg: "Load image",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.deepOrange[200],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void errorToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.deepOrange[200],
        textColor: Colors.white,
        fontSize: 16.0);
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
              userDatabase.insertOrUpdateUserInfo(
                  phoneController.text,
                  nameController.text,
                  descriptionController.text,
                  passwordController.text);
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
