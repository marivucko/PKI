import 'package:meta/meta.dart';
import 'package:starter_pack/data/beans/product.dart';

@immutable
abstract class CustomerOneProductState {
  final int quantity;
  CustomerOneProductState(this.quantity);
}

class InitialCustomerOneProductState extends CustomerOneProductState {
  InitialCustomerOneProductState(int quantity) : super(quantity);
}

class ChangeOptionsCustomerOneProductState extends CustomerOneProductState {
  ChangeOptionsCustomerOneProductState(int quantity) : super(quantity);
}
