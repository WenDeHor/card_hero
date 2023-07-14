class User {
  final String? idSqlLite;
  final String? idFirebase;
  final String? phone;
  final String? stiles;
  final String? longitude;
  final String? latitude;
  final String? language;
  final String? icon;
  final String? name;
  final String? image;
  final String? description;
  final String? lvl;
  final String? rating;

  User(
      {this.idSqlLite,
      this.idFirebase,
      this.phone,
      this.stiles,
      this.longitude,
      this.latitude,
      this.language,
      this.icon,
      this.name,
      this.image,
      this.description,
      this.lvl,
      this.rating});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          idSqlLite == other.idSqlLite &&
          idFirebase == other.idFirebase &&
          phone == other.phone &&
          stiles == other.stiles &&
          longitude == other.longitude &&
          latitude == other.latitude &&
          language == other.language &&
          icon == other.icon &&
          name == other.name &&
          image == other.image &&
          description == other.description &&
          lvl == other.lvl &&
          rating == other.rating;

  @override
  int get hashCode =>
      idSqlLite.hashCode ^
      idFirebase.hashCode ^
      phone.hashCode ^
      stiles.hashCode ^
      longitude.hashCode ^
      latitude.hashCode ^
      language.hashCode ^
      icon.hashCode ^
      name.hashCode ^
      image.hashCode ^
      description.hashCode ^
      lvl.hashCode ^
      rating.hashCode;

  @override
  String toString() {
    return 'User{idSqlLite: $idSqlLite, idFirebase: $idFirebase, phone: $phone, stiles: $stiles, longitude: $longitude, latitude: $latitude, language: $language, icon: $icon, name: $name, image: $image, description: $description, lvl: $lvl, rating: $rating}';
  }
}
