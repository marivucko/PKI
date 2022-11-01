import 'package:meta/meta.dart';

@immutable
abstract class CustomerHomeEvent {}

class ProfileCustomerHomeEvent extends CustomerHomeEvent {}

class NavigateCustomerHomeEvent extends CustomerHomeEvent {
  final String value;
  NavigateCustomerHomeEvent(this.value);
}

class BasketCustomerHomeEvent extends CustomerHomeEvent {}


