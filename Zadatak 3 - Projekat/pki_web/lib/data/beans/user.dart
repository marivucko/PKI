import 'package:flutter/widgets.dart';
import 'package:starter_pack/bloc/register/bloc.dart';

class User {
  final String id;
  final String name;
  final String surname;
  final String address;
  final String phone;
  final String username;
  final String password;
  final int type;

  User({
    this.id,
    this.name,
    this.surname,
    this.address,
    this.phone,
    this.username,
    this.password,
    this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "surname": surname,
      "address": address,
      "phone": phone,
      "username": username,
      "password": password,
      "type": type,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "surname": surname,
      "address": address,
      "phone": phone,
      "username": username,
      "password": password,
      "type": type,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      address: json['address'],
      phone: json['phone'],
      username: json['username'],
      password: json['password'],
      type: json['type'],
    );
  }

  factory User.fromJson1(String id, Map<String, dynamic> json) {
    return User(
      id: id,
      name: json['name'],
      surname: json['surname'],
      address: json['address'],
      phone: json['phone'],
      username: json['username'],
      password: json['password'],
      type: json['type'],
    );
  }
}
