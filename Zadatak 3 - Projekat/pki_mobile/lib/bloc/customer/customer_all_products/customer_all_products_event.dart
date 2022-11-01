import 'package:meta/meta.dart';
import 'package:starter_pack/data/beans/product.dart';

@immutable
abstract class CustomerAllProductsEvent {}

class InitiateCustomerAllProductsEvent extends CustomerAllProductsEvent {}

class NavigateCustomerAllProductsEvent extends CustomerAllProductsEvent {
  final String value;
  NavigateCustomerAllProductsEvent(this.value);
}

class BasketCustomerAllProductsEvent extends CustomerAllProductsEvent {}

class ViewOneProductCustomerAllProductsEvent extends CustomerAllProductsEvent {
  final Product product;
  ViewOneProductCustomerAllProductsEvent(this.product);
}
