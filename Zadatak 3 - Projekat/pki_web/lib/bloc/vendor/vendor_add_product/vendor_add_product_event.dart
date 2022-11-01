import 'package:meta/meta.dart';

@immutable
abstract class VendorAddProductEvent {}

class AllOrdersVendorAddProductEvent extends VendorAddProductEvent {}

class AddProductVendorAddProductEvent extends VendorAddProductEvent {}

class ChangeOptionsVendorAddProductEvent extends VendorAddProductEvent {}

class InitialOptionsVendorAddProductEvent extends VendorAddProductEvent {}

class GoToChangePersonalDataVendorAddProductEvent extends VendorAddProductEvent {}

class GoToChangePasswordVendorAddProductEvent extends VendorAddProductEvent {}

class LogoutVendorAddProductEvent extends VendorAddProductEvent {}

class SaveVendorAddProductEvent extends VendorAddProductEvent {
  final String name;
  final String price;
  final String description;
  final String manual;
  SaveVendorAddProductEvent(this.name, this.price, this.description, this.manual);
}

class PickImageVendorAddProductEvent extends VendorAddProductEvent {}