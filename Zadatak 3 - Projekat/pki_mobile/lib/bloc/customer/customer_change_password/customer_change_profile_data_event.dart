import 'package:meta/meta.dart';

@immutable
abstract class CustomerChangePasswordEvent {}

class NavigateCustomerChangePasswordEvent extends CustomerChangePasswordEvent {
  final String value;
  NavigateCustomerChangePasswordEvent(this.value);
}

class BasketCustomerChangePasswordEvent extends CustomerChangePasswordEvent {}

class SaveCustomerChangePasswordEvent extends CustomerChangePasswordEvent {
  final String password;
  SaveCustomerChangePasswordEvent(this.password);
}

