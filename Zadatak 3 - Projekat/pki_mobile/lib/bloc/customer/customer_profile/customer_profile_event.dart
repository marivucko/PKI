import 'package:meta/meta.dart';

@immutable
abstract class CustomerProfileEvent {}

class ProfileCustomerProfileEvent extends CustomerProfileEvent {}

class NavigateCustomerProfileEvent extends CustomerProfileEvent {
  final String value;
  NavigateCustomerProfileEvent(this.value);
}

class BasketCustomerProfileEvent extends CustomerProfileEvent {}


