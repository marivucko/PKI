import 'package:meta/meta.dart';

@immutable
abstract class VendorChangePasswordState {
  final bool enableErrorText;
  VendorChangePasswordState(this.enableErrorText);
}

class InitialVendorChangePasswordState extends VendorChangePasswordState {
  InitialVendorChangePasswordState(bool enableErrorText) : super(enableErrorText);
}

class ChangeOptionsVendorChangePasswordState extends VendorChangePasswordState {
  ChangeOptionsVendorChangePasswordState(bool enableErrorText) : super(enableErrorText);
}
