import 'package:meta/meta.dart';

@immutable
abstract class CustomerBasketEvent {}

class NavigateCustomerBasketEvent extends CustomerBasketEvent {
  final String value;
  NavigateCustomerBasketEvent(this.value);
}

class BasketCustomerBasketEvent extends CustomerBasketEvent {}

class OrderCustomerBasketEvent extends CustomerBasketEvent {}


