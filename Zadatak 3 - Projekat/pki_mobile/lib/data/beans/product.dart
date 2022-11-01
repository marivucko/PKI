import 'package:flutter/widgets.dart';
import 'package:starter_pack/bloc/register/bloc.dart';

class Product {
  final String id;
  final String image;
  final String name;
  final double price;
  final String description;
  final String manual;

  Product({
    this.id,
    this.image,
    this.name,
    this.price,
    this.description,
    this.manual,
  });

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "name": name,
      "surname": price,
      "address": description,
      "phone": manual,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "image": image,
      "name": name,
      "surname": price,
      "address": description,
      "phone": manual,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      manual: json['manual'],
    );
  }

  factory Product.fromJson1(String id, Map<String, dynamic> json) {
    return Product(
      id: id,
      image: json['image'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      manual: json['manual'],
    );
  }
}
