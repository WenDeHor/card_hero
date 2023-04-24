import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var titleMenuName = 'Side menu';
    var assetTitleImageName = 'assets/cover.jpg';
    var textTitleMenuStyle = TextStyle(color: Colors.white, fontSize: 25);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              titleMenuName,
              style: textTitleMenuStyle,
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(assetTitleImageName))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
