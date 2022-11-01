import 'package:meta/meta.dart';

@immutable
abstract class CustomerChangeDataEvent {}

class ProductsCustomerChangeDataEvent extends CustomerChangeDataEvent {}

class BasketCustomerChangeDataEvent extends CustomerChangeDataEvent {}

class ChangeOptionsCustomerChangeDataEvent extends CustomerChangeDataEvent {}

class InitialOptionsCustomerChangeDataEvent extends CustomerChangeDataEvent {}

class GoToChangePersonalDataCustomerChangeDataEvent extends CustomerChangeDataEvent {}

class GoToChangePasswordCustomerChangeDataEvent extends CustomerChangeDataEvent {}

class LogoutCustomerChangeDataEvent extends CustomerChangeDataEvent {}

class SaveCustomerChangeDataEvent extends CustomerChangeDataEvent {
  final String name;
  final String surname;
  final String address;
  final String phone;
  SaveCustomerChangeDataEvent(this.name, this.surname, this.address, this.phone);
}



