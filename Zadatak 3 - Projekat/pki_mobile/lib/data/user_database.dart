import 'dart:convert';
import 'package:starter_pack/services/database_services.dart';
import 'beans/user.dart';
import 'package:http/http.dart' as http;

class UserDatabase {

  static const String TABLE_NAME_USER = 'User';
  static const String TABLE_USER = 'User';
  var database;

  Future<void> insertUser(User user) async {
    await http.post(DatabaseService.FIREBASE_URL + "user.json",
      body: json.encode({
        "name": user.name,
        "surname": user.surname,
        "address": user.address,
        "phone": user.phone,
        "username": user.username,
        "password": user.password,
        "type": user.type,
      }));
  }

  Future<void> updateUser(User user) async {
   await http.put(DatabaseService.FIREBASE_URL + "user/${user.id}.json/",
    body: json.encode({
      "name": user.name,
      "surname": user.surname,
      "address": user.address,
      "phone": user.phone,
      "username": user.username,
      "password": user.password,
      "type": user.type,
    })
   );
  }

  Future<void> deleteUser(int userId) async {

  }

  Future<User> getUserByUsername(String username) async {
    List<User> users = await getAllUsers();
    for (int i = 0; i < users.length; i++) {
      if (users[i].username == username) {
        return users[i];
      }
    }
    return null;
  }

  Future<List<User>> getAllUsers() async {
    List<User> users = [];
    final response = await http.get(DatabaseService.FIREBASE_URL + "user.json");
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach((profileId, profileData) {
      users.add(
        User(
          id: profileId,
          name: profileData['name'],
          surname: profileData['surname'],
          address: profileData['address'],
          phone: profileData['phone'],
          username: profileData['username'],
          password: profileData['password'],
          type: profileData['type'],
        ),
      );
      User currentUser = User.fromJson1(profileId, profileData);
    });

    return users;
  }

  Future<void> printAllUsers() async {
    List<User> users = await getAllUsers();
    print('-----------------------------------------');
    for (int i = 0; i < users.length; i++) {
      print("id: ${users[i].id} ${users[i].toMap()}");
    }
    print('-----------------------------------------');
  }

}