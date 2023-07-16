import 'dart:convert';
import 'dart:io';

import 'package:card_hero/menu/footer_bar.dart';
import 'package:card_hero/model/user_model.dart';
import 'package:flutter/material.dart';

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
  String? _idDevice;
  List<User> userList = [];
  final _formKeyRegistration = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
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
      userList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor.loginAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Form(
              key: _formKeyRegistration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  titleRegistration(),
                  fieldName(),
                  fieldPhone(),
                  fieldPassword(),
                  buttonSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: FooterBar.getLoginBar(
          context, Colors.brown, Colors.brown, Colors.blue),
    );
  }

  Padding titleRegistration() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Center(
        child: Text('Registration page',
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
          onPressed: () async {
            if (_formKeyRegistration.currentState!.validate() && userList.isEmpty) {
              userDatabase.insertUserRegistration(
                  _phoneController.text,
                  _passwordController.text,
                  _nameController.text);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Success!. Account created'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushNamed(context, '/user_login');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('User with this phone is present!'),
                backgroundColor: Colors.deepOrangeAccent,
              ));
            }
          },
          child: const Text('Go to app',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
        ),
      ),
    );
  }

  dynamic validatorInput(dynamic value, int min, int max, String error) {
    if (value.isEmpty || value.length < min || value.length > max) {
      return error;
    }
    return null;
  }
}
