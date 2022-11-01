import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/data/beans/product.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/resources/widgets/dialogs/loading_dialog.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/route_generator.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';

class CustomerAllProductsBloc extends Bloc<CustomerAllProductsEvent, CustomerAllProductsState> {

  final BuildContext context;
  bool enableErrorText = false;

  CustomerAllProductsBloc(this.context);

  List<Product> products = [];

  @override
  CustomerAllProductsState get initialState => InitialCustomerAllProductsState(products);

  @override
  Stream<CustomerAllProductsState> mapEventToState(CustomerAllProductsEvent event) async* {
    if (event is InitiateCustomerAllProductsEvent) {
      LoadingDialog.showLoading(context);
      products = await AllServices().databaseService.productDatabase.getAllProducts();
      yield InitialCustomerAllProductsState(products);
      LoadingDialog.close(context);
    }
    if (event is ViewOneProductCustomerAllProductsEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_ONE_PRODUCT_ROUTE, arguments: event.product);
    }
    if (event is BasketCustomerAllProductsEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_BASKET_ROUTE);
    }
    if (event is NavigateCustomerAllProductsEvent) {
      if (event.value == AppLocalizations.of(context).translate("menu_all_products")) {
        return;
      }
      if (event.value == AppLocalizations.of(context).translate("menu_view_profile")) {
        Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_PROFILE_ROUTE);
        return;
      }
      if (event.value == AppLocalizations.of(context).translate("menu_change_profile_data")) {
        Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_CHANGE_PROFILE_DATA_ROUTE);
        return;
      }
      if (event.value == AppLocalizations.of(context).translate("menu_change_password")) {
        Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_CHANGE_PASSWORD_ROUTE);
        return;
      }
      if (event.value == AppLocalizations.of(context).translate("menu_logout")) {
        Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.MAIN_ROUTE, (Route<dynamic> route) => false);
        return;
      }
    }
  }
}