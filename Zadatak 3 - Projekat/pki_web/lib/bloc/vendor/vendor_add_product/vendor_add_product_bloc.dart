import 'dart:html';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:starter_pack/data/beans/order.dart';
import 'package:starter_pack/data/beans/product.dart';
import 'package:starter_pack/resources/widgets/dialogs/loading_dialog.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';
import 'package:starter_pack/route_generator.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui';

class VendorAddProductBloc extends Bloc<VendorAddProductEvent, VendorAddProductState> {
  final BuildContext context;
  bool enableErrorText = false;

  VendorAddProductBloc(this.context);

  Image image;
  String base64Image;
  bool insertedImage = false;

  @override
  VendorAddProductState get initialState => InitialVendorAddProductState(enableErrorText, insertedImage);

  @override
  Stream<VendorAddProductState> mapEventToState(VendorAddProductEvent event) async* {
    if (event is AllOrdersVendorAddProductEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_ALL_ORDERS_ROUTE);
    }
    if (event is AddProductVendorAddProductEvent) {
      yield InitialVendorAddProductState(enableErrorText, insertedImage);
    }
    if (event is ChangeOptionsVendorAddProductEvent) {
      yield ChangeOptionsVendorAddProductState(enableErrorText, insertedImage);
    }
    if (event is InitialOptionsVendorAddProductEvent) {
      yield InitialVendorAddProductState(enableErrorText, insertedImage);
    }
    if (event is GoToChangePersonalDataVendorAddProductEvent) {
      yield InitialVendorAddProductState(enableErrorText, insertedImage);
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_CHANGE_PROFILE_DATA_ROUTE);
    }
    if (event is GoToChangePasswordVendorAddProductEvent) {
      yield InitialVendorAddProductState(enableErrorText, insertedImage);
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_CHANGE_PASSWORD_ROUTE);
    }
    if (event is LogoutVendorAddProductEvent) {
      Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.MAIN_ROUTE, (Route<dynamic> route) => false);
    }
    if (event is PickImageVendorAddProductEvent) {
      var picked = await FilePicker.platform.pickFiles();
      if (picked != null) {
        print(picked.files.first.name);
        base64Image = base64Encode(picked.files.first.bytes);
        insertedImage = true;
        yield InitialVendorAddProductState(enableErrorText, insertedImage);
      }
    }
    if (event is SaveVendorAddProductEvent) {
      enableErrorText = true;
      yield InitialVendorAddProductState(enableErrorText, insertedImage);
      if (!insertedImage) {
        MessageDialog.showClassic(context: context, message: "Molimo dodajte sliku proizvoda.");
        return;
      }
      if (event.name.isNotEmpty && double.parse(event.price) > 0 && event.description.isNotEmpty && event.manual.isNotEmpty) {
        Product product = new Product(
          image: base64Image,
          name: event.name,
          price: double.parse(event.price),
          description: event.description,
          manual: event.manual,
        );
        LoadingDialog.showLoading(context);
        bool productAdded = await AllServices().databaseService.productDatabase.insertProduct(product);
        if (productAdded) {
          LoadingDialog.close(context);
          MessageDialog.showClassic(context: context, message: "Proizvod je uspešno dodat.");
        }
        else {
          LoadingDialog.close(context);
          MessageDialog.showClassic(context: context, message: "Proizvod nije dodat.");
        }
      }
    }
  }
}
