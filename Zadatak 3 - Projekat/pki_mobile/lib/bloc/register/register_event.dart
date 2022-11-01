import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent {}

class RegisterRegisterEvent extends RegisterEvent {
  final String name;
  final String surname;
  final String address;
  final String phone;
  final String username;
  final String password;
  RegisterRegisterEvent(this.name, this.surname, this.address, this.phone, this.username, this.password);
}
