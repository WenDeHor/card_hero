class User {
  final String? id;
  final String? name;
  final String? imageUrl;

  const User({ this.id,  this.name,  this.imageUrl});

  factory User.fromMap(Map<String, dynamic> json) =>
      User(id: json["id"], name: json["name"], imageUrl: json["imageUrl"]);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}