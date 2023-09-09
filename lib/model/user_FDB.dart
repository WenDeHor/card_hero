import 'package:card_hero/model/user_model.dart';

class UserFDB {
  final String? idSqlLite;
  final String? idFirebase;
  final String? longitude;
  final String? latitude;
  final String? icon;
  final String? name;
  final String? descriptionCard;
  final String? descriptionUser;
  final String? statusSearch;

  UserFDB(this.idSqlLite, this.idFirebase, this.longitude, this.latitude, this.icon, this.name, this.descriptionCard, this.descriptionUser,
      this.statusSearch);

  UserFDB.name(this.idSqlLite, this.idFirebase, this.longitude, this.latitude, this.icon, this.name, this.descriptionCard, this.descriptionUser,
      this.statusSearch);
}