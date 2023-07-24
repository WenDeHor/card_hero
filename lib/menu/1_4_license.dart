import 'package:card_hero/menu/footer_bar.dart';
import 'package:card_hero/oss_licenses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_bar.dart';

//https://medium.com/@anslemAnsy/generating-licenses-for-your-flutter-app-the-easy-way-99deec74aeb9
class UserLicense extends StatelessWidget {
  const UserLicense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor.loginAppBar(context),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: ossLicenses.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => LicenceDetailPage(
                        title: ossLicenses[index].name[0].toUpperCase() +
                            ossLicenses[index].name.substring(1),
                        licence: ossLicenses[index].license!,
                      ),
                    ),
                  );
                },
                //capitalize the first letter of the string
                title: Text(
                  ossLicenses[index].name[0].toUpperCase() +
                      ossLicenses[index].name.substring(1),
                ),
                subtitle: Text(ossLicenses[index].description),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: FooterBar.getLoginBar(
          context, Colors.brown, Colors.brown, Colors.brown, Colors.blue),
    );
  }
}

//detail page for the licence
class LicenceDetailPage extends StatelessWidget {
  final String title, licence;

  const LicenceDetailPage(
      {super.key, required this.title, required this.licence});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor.loginAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8)),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  licence,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FooterBar.getLoginBar(
          context, Colors.brown, Colors.brown, Colors.brown, Colors.blue),
    );
  }
}
