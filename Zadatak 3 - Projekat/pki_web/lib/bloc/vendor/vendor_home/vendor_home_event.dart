import 'package:meta/meta.dart';

@immutable
abstract class VendorHomeEvent {}

class AllOrdersVendorHomeEvent extends VendorHomeEvent {}

class AddProductVendorHomeEvent extends VendorHomeEvent {}

class ChangeOptionsVendorHomeEvent extends VendorHomeEvent {}

class InitialOptionsVendorHomeEvent extends VendorHomeEvent {}

class GoToChangePersonalDataVendorHomeEvent extends VendorHomeEvent {}

class GoToChangePasswordVendorHomeEvent extends VendorHomeEvent {}

class LogoutVendorHomeEvent extends VendorHomeEvent {}