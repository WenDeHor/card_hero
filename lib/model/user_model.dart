
class User {
  final String? id;
  final String? name;
  final String? image;
  final String? description;

  const User({ this.id,  this.name,  this.image, this.description});

  factory User.fromMap(Map<String, dynamic> json) =>
      User(
          id: json["id"],
          name: json["name"],
          image: json["image"],
          description: json["description"]
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, image: ${image?.length}, $description}';
  }
}
