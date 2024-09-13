import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? email;
  String? password;
  String? address;
  String? avatar;
  String? name;
  int? phone;
  String? city;

  User({
    this.id,
    this.email,
    this.password,
    this.address,
    this.avatar,
    this.name,
    this.phone,
    this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        avatar: json["avatar"],
        name: json["name"],
        phone: json["phone"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "password": password,
        "address": address,
        "avatar": avatar,
        "name": name,
        "phone": phone,
        "city" : city,
      };
}
