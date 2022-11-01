import 'package:meta/meta.dart';

@immutable
abstract class CustomerChangeProfileDataEvent {}

class NavigateCustomerChangeProfileDataEvent extends CustomerChangeProfileDataEvent {
  final String value;
  NavigateCustomerChangeProfileDataEvent(this.value);
}

class BasketCustomerChangeProfileDataEvent extends CustomerChangeProfileDataEvent {}

class SaveCustomerChangeProfileDataEvent extends CustomerChangeProfileDataEvent {
  final String name;
  final String surname;
  final String address;
  final String phone;
  SaveCustomerChangeProfileDataEvent(this.name, this.surname, this.address, this.phone);
}
