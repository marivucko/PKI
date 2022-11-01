import 'package:flutter/widgets.dart';
import 'package:starter_pack/bloc/register/bloc.dart';

class Order {

  static const int ORDER_NOT_PROCESSED = 0;
  static const int ORDER_ALLOWED = 1;
  static const int ORDER_NOT_ALLOWED = 2;

  final String id;
  final String username;
  final double price;
  final int status;

  Order({
    this.id,
    this.username,
    this.price,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "price": price,
      "status": status,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "price": price,
      "status": status,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['username'],
      price: json['price'],
      status: json['status'],
    );
  }

  factory Order.fromJson1(String id, Map<String, dynamic> json) {
    return Order(
      id: id,
      username: json['username'],
      price: json['price'],
      status: json['status'],
    );
  }
}
