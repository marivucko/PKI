import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VendorAddProductState {
  final bool enableErrorText;
  final bool insertedImage;
  VendorAddProductState(this.enableErrorText, this.insertedImage);
}

class InitialVendorAddProductState extends VendorAddProductState {
  InitialVendorAddProductState(bool enableErrorText, bool insertedImage) : super(enableErrorText, insertedImage);
}

class ChangeOptionsVendorAddProductState extends VendorAddProductState {
  ChangeOptionsVendorAddProductState(bool enableErrorText, bool insertedImage) : super(enableErrorText, insertedImage);
}
