import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/route_generator.dart';
import './bloc.dart';

class CustomerHomeBloc extends Bloc<CustomerHomeEvent, CustomerHomeState> {

  final BuildContext context;

  CustomerHomeBloc(this.context);

  @override
  CustomerHomeState get initialState => InitialCustomerHomeState();

  @override
  Stream<CustomerHomeState> mapEventToState(CustomerHomeEvent event) async* {
    if (event is ProfileCustomerHomeEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_PROFILE_ROUTE);
    }
    if (event is BasketCustomerHomeEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_BASKET_ROUTE);
    }
    if (event is NavigateCustomerHomeEvent) {
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
  }

}