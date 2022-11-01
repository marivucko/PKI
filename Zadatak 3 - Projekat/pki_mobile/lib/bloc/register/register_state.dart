import 'package:meta/meta.dart';

@immutable
abstract class RegisterState {
  final bool enableErrorText;
  RegisterState(this.enableErrorText);
}

class InitialRegisterState extends RegisterState {
  InitialRegisterState(bool enableErrorText) : super(enableErrorText);
}

class MenuOptionsRegisterState extends RegisterState {
  MenuOptionsRegisterState(bool enableErrorText) : super(enableErrorText);
}

