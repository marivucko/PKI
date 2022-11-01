import 'package:meta/meta.dart';

@immutable
abstract class VendorChangeDataEvent {}

class AllOrdersVendorChangeDataEvent extends VendorChangeDataEvent {}

class AddProductVendorChangeDataEvent extends VendorChangeDataEvent {}

class ChangeOptionsVendorChangeDataEvent extends VendorChangeDataEvent {}

class InitialOptionsVendorChangeDataEvent extends VendorChangeDataEvent {}

class GoToChangePersonalDataVendorChangeDataEvent extends VendorChangeDataEvent {}

class GoToChangePasswordVendorChangeDataEvent extends VendorChangeDataEvent {}

class LogoutVendorChangeDataEvent extends VendorChangeDataEvent {}

class SaveVendorChangeDataEvent extends VendorChangeDataEvent {
  final String name;
  final String surname;
  final String address;
  final String phone;
  SaveVendorChangeDataEvent(this.name, this.surname, this.address, this.phone);
}