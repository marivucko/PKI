import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent {}

class LoginLoginEvent extends LoginEvent {
  final String username;
  final String password;
  LoginLoginEvent(this.username, this.password);
}
