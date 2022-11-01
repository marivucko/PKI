import 'package:meta/meta.dart';
import 'package:starter_pack/data/beans/product.dart';

@immutable
abstract class CustomerOneProductEvent {}

class InitiateCustomerOneProductEvent extends CustomerOneProductEvent {}

class ProductCustomerOneProductEvent extends CustomerOneProductEvent {}

class BasketCustomerOneProductEvent extends CustomerOneProductEvent {}

class ChangeOptionsCustomerOneProductEvent extends CustomerOneProductEvent {}

class InitialOptionsCustomerOneProductEvent extends CustomerOneProductEvent {}

class GoToChangePersonalDataCustomerOneProductEvent extends CustomerOneProductEvent {}

class GoToChangePasswordCustomerOneProductEvent extends CustomerOneProductEvent {}

class LogoutCustomerOneProductEvent extends CustomerOneProductEvent {}

class IncrementQuantityCustomerOneProductEvent extends CustomerOneProductEvent {}

class DecrementQuantityCustomerOneProductEvent extends CustomerOneProductEvent {}

class AddToBasketCustomerOneProductEvent extends CustomerOneProductEvent {
  final Product product;
  final int quantity;
  AddToBasketCustomerOneProductEvent(this.product, this.quantity);
}



