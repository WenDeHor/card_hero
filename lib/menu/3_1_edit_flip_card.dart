import 'dart:convert';

import 'package:card_hero/menu/footer_bar.dart';
import 'package:card_hero/model/user_model.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../db/user_database.dart';
import '../utils/app_bar.dart';

class EditUserFlipCard extends StatefulWidget {
  const EditUserFlipCard({Key? key}) : super(key: key);

  @override
  _EditUserFlipCardState createState() => _EditUserFlipCardState();
}

class _EditUserFlipCardState extends State<EditUserFlipCard> {
  late UserDatabase userDatabase;
  List<User> _userList = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();

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
                  buttonUploadImage(),
                  userInfo(),
                  fieldDescription(),
                  buttonSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: FooterBar.getEditUserInfoBar(context, Colors.blue, Colors.brown),
    );
  }

//TODO Image ================================================
  Padding fieldImage(List<User> userList) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Center(
        child: SizedBox(
          width: (MediaQuery.of(context).size.width / 100) * 80,
          height: (MediaQuery.of(context).size.height / 100) * 55,
          child: userList.isNotEmpty && userList.last.image != null
              ? Image.memory(base64.decode(userList.last.image!))
              : Image.asset('assets/cover23.jpg', fit: BoxFit.cover),
        ),
      ),
    );
  }

  Padding buttonUploadImage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 30.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
          onPressed: () async {
            String byte64String;
            try {
              byte64String = await pickImage();
              if (byte64String.isNotEmpty) {
                userDatabase.insertOrUpdateImageInUser(byte64String);
                showSnackBarBySave('image loaded success');
                Navigator.pushNamed(context, '/user_info');
              } else {
                Navigator.pushNamed(context, '/user_registration');
              }
            } catch (e) {
              errorToast("Please upload photo 3x4");
            }
          },
          child: const Text(
            'Upload photo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }

  Future<String> pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 30);
    var imageBytes = await image!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

//TODO userInfo ================================================
  Padding userInfo() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Center(
        child: Text('User description',
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

  Padding fieldDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: TextFormField(
        controller: _descriptionController,
        minLines: 1,
        maxLines: 8,
        keyboardType: TextInputType.multiline,
        validator: (value) {
          return validatorInput(value, 3, 50, 'Enter please 3 to 50 characters');
        },
        decoration: const InputDecoration(
            hintText: 'Enter description',
            labelText: 'description',
            prefixIcon: Icon(
              Icons.message,
              color: Colors.blueGrey,
            ),
            errorStyle: TextStyle(fontSize: 18.0),
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.all(Radius.circular(9.0)))),
      ),
    );
  }

  dynamic validatorInput(dynamic value, int min, int max, String error) {
    if (value.isEmpty || value.length < min || value.length > max) {
      return error;
    }
    return null;
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
            if (_formKey.currentState!.validate()) {
              userDatabase.insertOrUpdateUserFlipCard(_descriptionController.text);
              showSnackBarBySave('User info saved success');
            }
          },
          child: const Text('Save description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
        ),
      ),
    );
  }

  void showSnackBarBySave(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ));
  }
}
