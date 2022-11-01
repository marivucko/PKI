import 'package:meta/meta.dart';

@immutable
abstract class LoginState {
  final bool enableErrorText;
  LoginState(this.enableErrorText);
}

class InitialLoginState extends LoginState {
  InitialLoginState(bool enableErrorText) : super(enableErrorText);
}
