import 'package:meta/meta.dart';

@immutable
abstract class VendorChangeDataState {
  final bool enableErrorText;
  VendorChangeDataState(this.enableErrorText);
}

class InitialVendorChangeDataState extends VendorChangeDataState {
  InitialVendorChangeDataState(bool enableErrorText) : super(enableErrorText);
}

class ChangeOptionsVendorChangeDataState extends VendorChangeDataState {
  ChangeOptionsVendorChangeDataState(bool enableErrorText) : super(enableErrorText);
}
