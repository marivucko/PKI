import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:sembast/sembast.dart';
import 'package:get_it/get_it.dart';
import 'package:starter_pack/services/database_services.dart';
import 'beans/product.dart';
import 'package:http/http.dart' as http;

class ProductDatabase {

  static const String TABLE_NAME_PRODUCT = 'product';
  static const String TABLE_PRODUCT = 'product';

  var store = intMapStoreFactory.store();
  var factory = databaseFactoryWeb;
  var database;

  Future<bool> insertProduct(Product product) async {
    var response = await http.post(DatabaseService.FIREBASE_URL + "product.json",
      body: json.encode({
        "image": product.image,
        "name": product.name,
        "price": product.price,
        "description": product.description,
        "manual": product.manual,
      })
    );
    return response.statusCode == 200;
  }

  Future<List<Product>> getAllProducts() async {
    List<Product> products = [];
    final response = await http.get(DatabaseService.FIREBASE_URL + "product.json");
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach((profileId, profileData) {
      products.add(
        Product(
          id: profileId,
          image: profileData['image'],
          name: profileData['name'],
          price: profileData['price'],
          description: profileData['description'],
          manual: profileData['manual'],
        ),
      );
    });
    return products;
  }

  Future<void> printAllproducts() async {
    List<Product> products = await getAllProducts();
    print('-----------------------------------------');
    for (int i = 0; i < products.length; i++) {
      print("id: ${products[i].id} ${products[i].toMap()}");
    }
    print('-----------------------------------------');
  }

}