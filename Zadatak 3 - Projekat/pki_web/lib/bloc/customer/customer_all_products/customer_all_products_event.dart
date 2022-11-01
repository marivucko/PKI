import 'package:meta/meta.dart';
import 'package:starter_pack/data/beans/product.dart';

@immutable
abstract class CustomerAllProductsEvent {}

class InitiateCustomerAllProductsEvent extends CustomerAllProductsEvent {}

class ProductsCustomerAllProductsEvent extends CustomerAllProductsEvent {}

class BasketCustomerAllProductsEvent extends CustomerAllProductsEvent {}

class ChangeOptionsCustomerAllProductsEvent extends CustomerAllProductsEvent {}

class InitialOptionsCustomerAllProductsEvent extends CustomerAllProductsEvent {}

class GoToChangePersonalDataCustomerAllProductsEvent extends CustomerAllProductsEvent {}

class GoToChangePasswordCustomerAllProductsEvent extends CustomerAllProductsEvent {}

class LogoutCustomerAllProductsEvent extends CustomerAllProductsEvent {}

class ViewOneProductCustomerAllProductsEvent extends CustomerAllProductsEvent {
  final Product product;
  ViewOneProductCustomerAllProductsEvent(this.product);
}



