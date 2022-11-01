import 'package:meta/meta.dart';

@immutable
abstract class CustomerChangePasswordState {
  final bool enableErrorText;
  CustomerChangePasswordState(this.enableErrorText);
}

class InitialCustomerChangePasswordState extends CustomerChangePasswordState {
  InitialCustomerChangePasswordState(bool enableErrorText) : super(enableErrorText);
}

class ChangeOptionsCustomerChangePasswordState extends CustomerChangePasswordState {
  ChangeOptionsCustomerChangePasswordState(bool enableErrorText) : super(enableErrorText);
}


