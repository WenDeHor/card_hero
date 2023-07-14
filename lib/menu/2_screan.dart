import 'package:card_hero/menu/bottom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../db/user_database.dart';
import '../utils/app_bar.dart';
import '../utils/constants.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  late UserDatabase userDatabase;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
//    userDatabase.getDataBase().whenComplete(() async {
//      setState(() {});
//    });
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
                    fieldImage(),
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

  Padding fieldImage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Center(
        child: Image.asset('assets/cover23.jpg'),
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
          onPressed: () {
            pressedButton();
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
              // If the form is valid, display a snackbar. In the real world,
              // you'd often call a server or save the information in a database.
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Processing data'),
                backgroundColor: Colors.blueGrey,
              ));
            }
          },
          child: const Text('Submit info',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
        ),
      ),
    );
  }
}
