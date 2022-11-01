import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:sembast/sembast.dart';
import 'package:get_it/get_it.dart';
import 'package:starter_pack/services/database_services.dart';
import 'beans/order.dart';
import 'package:http/http.dart' as http;

class OrderDatabase {
  static const String TABLE_NAME_ORDER = 'Order';
  static const String TABLE_ORDER = 'Order';

  var store = intMapStoreFactory.store();
  var factory = databaseFactoryWeb;
  var database;

  Future<void> insertOrder(Order order) async {
    await http.post(
      DatabaseService.FIREBASE_URL + "order.json",
      body: json.encode({
        "username": order.username,
        "price": order.price,
        "status": order.status,
      }),
    );
  }

  Future<void> updateOrder(Order order) async {
    await http.put(
      DatabaseService.FIREBASE_URL + "order/${order.id}.json/",
      body: json.encode({
        "username": order.username,
        "price": order.price,
        "status": order.status,
      }),
    );
  }

  Future<void> deleteOrder(int orderId) async {}

  Future<Order> getOrderByOrdername(String username) async {
    List<Order> orders = await getAllOrders();
    for (int i = 0; i < orders.length; i++) {
      if (orders[i].username == username) {
        return orders[i];
      }
    }
    return null;
  }

  Future<List<Order>> getAllOrders() async {
    List<Order> orders = [];
    final response = await http.get(DatabaseService.FIREBASE_URL + "order.json");
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach((profileId, profileData) {
      orders.add(
        Order(
          id: profileId,
          username: profileData['username'],
          price: profileData['price'],
          status: profileData['status'],
        ),
      );
    });
    return orders;
  }

  Future<void> printAllOrders() async {
    List<Order> orders = await getAllOrders();
    print('-----------------------------------------');
    for (int i = 0; i < orders.length; i++) {
      print("$i id: ${orders[i].id} ${orders[i].toMap()}");
    }
    print('-----------------------------------------');
  }
}
