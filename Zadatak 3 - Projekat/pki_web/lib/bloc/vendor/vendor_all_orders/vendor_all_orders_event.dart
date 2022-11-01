import 'package:meta/meta.dart';
import 'package:starter_pack/data/beans/order.dart';

@immutable
abstract class VendorAllOrdersEvent {}

class InitializeVendorAllOrdersEvent extends VendorAllOrdersEvent {}

class AllOrdersVendorAllOrdersEvent extends VendorAllOrdersEvent {}

class AddProductVendorAllOrdersEvent extends VendorAllOrdersEvent {}

class ChangeOptionsVendorAllOrdersEvent extends VendorAllOrdersEvent {}

class InitialOptionsVendorAllOrdersEvent extends VendorAllOrdersEvent {}

class GoToChangePersonalDataVendorAllOrdersEvent extends VendorAllOrdersEvent {}

class GoToChangePasswordVendorAllOrdersEvent extends VendorAllOrdersEvent {}

class LogoutVendorAllOrdersEvent extends VendorAllOrdersEvent {}

class OpenDialogToAllowOrderVendorAllOrdersEvent extends VendorAllOrdersEvent {
  final Order order;
  OpenDialogToAllowOrderVendorAllOrdersEvent(this.order);
}

class AllowOrderVendorAllOrdersEvent extends VendorAllOrdersEvent {
  final Order order;
  AllowOrderVendorAllOrdersEvent(this.order);
}

class DeclineOrderAllOrdersEvent extends VendorAllOrdersEvent {
  final Order order;
  DeclineOrderAllOrdersEvent(this.order);
}