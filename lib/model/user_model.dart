class User {
  final String? idSqlLite;
  final String? idFirebase;
  final String? phone;
  final String? password;
  final String? stiles;
  final String? longitude;
  final String? latitude;
  final String? language;
  final String? icon;
  final String? name;
  late final String? image;
  final String? descriptionCard;
  final String? descriptionUser;
  final String? statusSearch;
  final String? lvl;
  final String? rating;
  final String? idDevice;



  User(
      {this.idSqlLite,
      this.idFirebase,
      this.phone,
      this.password,
      this.stiles,
      this.longitude,
      this.latitude,
      this.language,
      this.icon,
      this.name,
      this.image,
      this.descriptionCard,
      this.descriptionUser,
      this.statusSearch,
      this.lvl,
      this.rating,
      this.idDevice});




  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          idSqlLite == other.idSqlLite &&
          idFirebase == other.idFirebase &&
          phone == other.phone &&
          password == other.password &&
          stiles == other.stiles &&
          longitude == other.longitude &&
          latitude == other.latitude &&
          language == other.language &&
          icon == other.icon &&
          name == other.name &&
          image == other.image &&
          descriptionCard == other.descriptionCard &&
          descriptionUser == other.descriptionUser &&
          statusSearch == other.statusSearch &&
          lvl == other.lvl &&
          rating == other.rating &&
          idDevice == other.idDevice;

  @override
  int get hashCode =>
      idSqlLite.hashCode ^
      idFirebase.hashCode ^
      phone.hashCode ^
      password.hashCode ^
      stiles.hashCode ^
      longitude.hashCode ^
      latitude.hashCode ^
      language.hashCode ^
      icon.hashCode ^
      name.hashCode ^
      image.hashCode ^
      descriptionCard.hashCode ^
      descriptionUser.hashCode ^
      statusSearch.hashCode ^
      lvl.hashCode ^
      rating.hashCode ^
      idDevice.hashCode;

  @override
  String toString() {
    return 'User{idSqlLite: $idSqlLite, idFirebase: $idFirebase, phone: $phone, password: $password, stiles: $stiles, longitude: $longitude, latitude: $latitude, language: $language, icon: $icon, name: $name, image: $image, descriptionCard: $descriptionCard,  descriptionUser: $descriptionUser, statusSearch: $statusSearch, lvl: $lvl, rating: $rating, idDevice: $idDevice;}';
  }
}
