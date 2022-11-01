import 'package:meta/meta.dart';
import 'package:starter_pack/data/beans/user.dart';

@immutable
abstract class RegisterEvent {}

class ProfileOptionsRegisterEvent extends RegisterEvent {}

class HomeRegisterEvent extends RegisterEvent {}

class GoToLoginRegisterEvent extends RegisterEvent {}

class GoToRegisterRegisterEvent extends RegisterEvent {}

class RegisterRegisterEvent extends RegisterEvent {
  final String name;
  final String surname;
  final String address;
  final String phone;
  final String username;
  final String password;
  RegisterRegisterEvent(this.name, this.surname, this.address, this.phone, this.username, this.password);
}

class InitialOptionsRegisterEvent extends RegisterEvent {}

class SetCustomerRegisterEvent extends RegisterEvent {}

class SetVendorRegisterEvent extends RegisterEvent {}


