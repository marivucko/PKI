import 'package:meta/meta.dart';
import 'package:starter_pack/data/beans/order.dart';

@immutable
abstract class VendorAllOrdersState {
  final List<Order> orders;
  VendorAllOrdersState(this.orders);
}

class InitialVendorAllOrdersState extends VendorAllOrdersState {
  InitialVendorAllOrdersState(List<Order> orders) : super(orders);
}

class ChangeOptionsVendorAllOrdersState extends VendorAllOrdersState {
  ChangeOptionsVendorAllOrdersState(List<Order> orders) : super(orders);
}

class RefreshVendorAllOrdersState extends VendorAllOrdersState {
  RefreshVendorAllOrdersState(List<Order> orders) : super(orders);
}
