
class UserPower {
  final String? id;
  final int? counter;

  const UserPower({ this.id,  this.counter});

  factory UserPower.fromMap(Map<String, dynamic> json) =>
      UserPower(
          id: json["id"],
          counter: json["counter"]
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'counter': counter,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, counter: $counter}';
  }
}
