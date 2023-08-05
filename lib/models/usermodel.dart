// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  String id;
  String name;
  String doorstatus;

  Users({
    required this.id,
    required this.name,
    required this.doorstatus,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        name: json["name"],
        doorstatus: json["doorstatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "doorstatus": doorstatus,
      };
}
