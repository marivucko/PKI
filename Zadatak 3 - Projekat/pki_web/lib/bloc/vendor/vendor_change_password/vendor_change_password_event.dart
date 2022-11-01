import 'package:meta/meta.dart';

@immutable
abstract class VendorChangePasswordEvent {}

class AllOrdersVendorChangePasswordEvent extends VendorChangePasswordEvent {}

class AddProductVendorChangePasswordEvent extends VendorChangePasswordEvent {}

class ChangeOptionsVendorChangePasswordEvent extends VendorChangePasswordEvent {}

class InitialOptionsVendorChangePasswordEvent extends VendorChangePasswordEvent {}

class GoToChangePersonalDataVendorChangePasswordEvent extends VendorChangePasswordEvent {}

class GoToChangePasswordVendorChangePasswordEvent extends VendorChangePasswordEvent {}

class LogoutVendorChangePasswordEvent extends VendorChangePasswordEvent {}

class SaveVendorChangePasswordEvent extends VendorChangePasswordEvent {
  final String password;
  SaveVendorChangePasswordEvent(this.password);
}