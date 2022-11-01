import 'package:meta/meta.dart';

@immutable
abstract class CustomerChangePasswordEvent {}

class ProductsCustomerChangePasswordEvent extends CustomerChangePasswordEvent {}

class BasketCustomerChangePasswordEvent extends CustomerChangePasswordEvent {}

class ChangeOptionsCustomerChangePasswordEvent extends CustomerChangePasswordEvent {}

class InitialOptionsCustomerChangePasswordEvent extends CustomerChangePasswordEvent {}

class GoToChangeDataCustomerChangePasswordEvent extends CustomerChangePasswordEvent {}

class GoToChangePasswordCustomerChangePasswordEvent extends CustomerChangePasswordEvent {}

class LogoutCustomerChangePasswordEvent extends CustomerChangePasswordEvent {}

class SaveCustomerChangePasswordEvent extends CustomerChangePasswordEvent {
  final String password;
  SaveCustomerChangePasswordEvent(this.password);
}



