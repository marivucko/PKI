import 'package:meta/meta.dart';
import 'package:starter_pack/data/beans/product.dart';

@immutable
abstract class CustomerOneProductEvent {}

class InitiateCustomerOneProductEvent extends CustomerOneProductEvent {}

class NavigateCustomerOneProductEvent extends CustomerOneProductEvent {
  final String value;
  NavigateCustomerOneProductEvent(this.value);
}

class BasketCustomerOneProductEvent extends CustomerOneProductEvent {}

class IncrementQuantityCustomerOneProductEvent extends CustomerOneProductEvent {}

class DecrementQuantityCustomerOneProductEvent extends CustomerOneProductEvent {}

class AddToBasketCustomerOneProductEvent extends CustomerOneProductEvent {
  final Product product;
  final int quantity;
  AddToBasketCustomerOneProductEvent(this.product, this.quantity);
}
