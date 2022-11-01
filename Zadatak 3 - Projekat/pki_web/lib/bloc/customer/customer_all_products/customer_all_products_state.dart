import 'package:meta/meta.dart';
import 'package:starter_pack/data/beans/product.dart';

@immutable
abstract class CustomerAllProductsState {
  final List<Product> products;
  CustomerAllProductsState(this.products);
}

class InitialCustomerAllProductsState extends CustomerAllProductsState {
  InitialCustomerAllProductsState(List<Product> products) : super(products);
}

class ChangeOptionsCustomerAllProductsState extends CustomerAllProductsState {
  ChangeOptionsCustomerAllProductsState(List<Product> products) : super(products);
}
