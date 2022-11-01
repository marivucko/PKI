import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/data/beans/order.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/route_generator.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';

class CustomerBasketBloc extends Bloc<CustomerBasketEvent, CustomerBasketState> {
  final BuildContext context;

  CustomerBasketBloc(this.context);

  @override
  CustomerBasketState get initialState => InitialCustomerBasketState();

  @override
  Stream<CustomerBasketState> mapEventToState(CustomerBasketEvent event) async* {
    if (event is BasketCustomerBasketEvent) {
      yield InitialCustomerBasketState();
    }
    if (event is NavigateCustomerBasketEvent) {
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
    if (event is OrderCustomerBasketEvent) {
      await AllServices().databaseService.orderDatabase.insertOrder(
        Order(
          username: AllServices().databaseService.user.username,
          price: AllServices().databaseService.basket.totalPrice,
          status: Order.ORDER_NOT_PROCESSED,
        ),
      );
      MessageDialog.showClassic(
          context: context,
          message: "Sadržaj iz korpe je naručen!",
          onClose: () {
            Navigator.of(context).pop();
            this.add(BasketCustomerBasketEvent());
          });
      AllServices().databaseService.clearBasket();
    }
  }
}
