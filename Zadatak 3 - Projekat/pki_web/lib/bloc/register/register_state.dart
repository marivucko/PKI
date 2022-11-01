import 'package:meta/meta.dart';

@immutable
abstract class RegisterState {
  final int selectedRadio;
  final bool enableErrorText;
  RegisterState(this.selectedRadio, this.enableErrorText);
}

class InitialRegisterState extends RegisterState {
  InitialRegisterState(int selectedRadio, bool enableErrorText) : super(selectedRadio, enableErrorText);
}

class ProfileOptionsRegisterState extends RegisterState {
  ProfileOptionsRegisterState(int selectedRadio, bool enableErrorText) : super(selectedRadio, enableErrorText);
}


