import 'package:meta/meta.dart';
import 'package:starter_pack/data/beans/user.dart';

@immutable
abstract class LoginEvent {}

class ProfileOptionsLoginEvent extends LoginEvent {}

class HomeLoginEvent extends LoginEvent {}

class GoToLoginLoginEvent extends LoginEvent {}

class GoToRegisterLoginEvent extends LoginEvent {}

class LoginLoginEvent extends LoginEvent {
  final String username;
  final String password;
  LoginLoginEvent(this.username, this.password);
}

class InitialOptionsLoginEvent extends LoginEvent {}



