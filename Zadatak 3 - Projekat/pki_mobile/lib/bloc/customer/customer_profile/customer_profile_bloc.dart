import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/route_generator.dart';
import './bloc.dart';

class CustomerProfileBloc extends Bloc<CustomerProfileEvent, CustomerProfileState> {

  final BuildContext context;

  CustomerProfileBloc(this.context);

  @override
  CustomerProfileState get initialState => InitialCustomerProfileState();

  @override
  Stream<CustomerProfileState> mapEventToState(CustomerProfileEvent event) async* {
    if (event is ProfileCustomerProfileEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_PROFILE_ROUTE);
    }
    if (event is BasketCustomerProfileEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_BASKET_ROUTE);
    }
    if (event is NavigateCustomerProfileEvent) {
      if (event.value == AppLocalizations.of(context).translate("menu_all_products")) {
        Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_ALL_PRODUCTS_ROUTE);
        return;
      }
      if (event.value == AppLocalizations.of(context).translate("menu_view_profile")) {
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