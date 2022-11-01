import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/data/beans/order_item.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/route_generator.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';

class CustomerOneProductBloc extends Bloc<CustomerOneProductEvent, CustomerOneProductState> {
  final BuildContext context;

  CustomerOneProductBloc(this.context);

  int quantity = 1;

  @override
  CustomerOneProductState get initialState => InitialCustomerOneProductState(quantity);

  @override
  Stream<CustomerOneProductState> mapEventToState(CustomerOneProductEvent event) async* {
    if (event is BasketCustomerOneProductEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_BASKET_ROUTE);
    }
    if (event is NavigateCustomerOneProductEvent) {
      if (event.value == AppLocalizations.of(context).translate("menu_all_products")) {
        Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_ALL_PRODUCTS_ROUTE);
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
    if (event is IncrementQuantityCustomerOneProductEvent) {
      quantity = quantity + 1;
      yield InitialCustomerOneProductState(quantity);
    }
    if (event is DecrementQuantityCustomerOneProductEvent) {
      if (quantity > 1) {
        quantity = quantity - 1;
      }
      yield InitialCustomerOneProductState(quantity);
    }
    if (event is AddToBasketCustomerOneProductEvent) {
      AllServices().databaseService.basket.addOrderItem(OrderItem(event.product, event.quantity));
      MessageDialog.showClassic(context: context, message: AppLocalizations.of(context).translate("customer_one_product_added_to_basket"));
    }
  }
}
