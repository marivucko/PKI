import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:starter_pack/data/beans/basket.dart';
import 'package:starter_pack/data/beans/order.dart';
import 'package:starter_pack/data/order_database.dart';
import 'package:starter_pack/data/product_database.dart';
import 'package:starter_pack/data/user_database.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'dart:async';

class DatabaseService {

  static const String FIREBASE_URL = 'https://shop-569a0-default-rtdb.firebaseio.com/';

  UserDatabase userDatabase;
  ProductDatabase productDatabase;
  OrderDatabase orderDatabase;
  User user;
  Basket basket = Basket();

  Future initiate(BuildContext context) async {
    userDatabase = UserDatabase();
    productDatabase = ProductDatabase();
    orderDatabase = OrderDatabase();
  }

  void clearBasket() {
    basket = new Basket();
  }

  void setUser(User user) {
    this.user = user;
  }

  User getUser() {
    return user;
  }

  Future insertUserInfo(User user) async {
    await userDatabase.insertUser(user);
    this.user = user;
  }

}
