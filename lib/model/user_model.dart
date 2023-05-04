
class User {
  final String? id;
  final String? name;
  final String? image;

  const User({ this.id,  this.name,  this.image});

  factory User.fromMap(Map<String, dynamic> json) =>
      User(id: json["id"], name: json["name"], image: json["image"]);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, image: ${image?.length}}';
  }
}
