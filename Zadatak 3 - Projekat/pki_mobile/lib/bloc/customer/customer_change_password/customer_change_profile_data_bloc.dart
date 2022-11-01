import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/route_generator.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';

class CustomerChangePasswordBloc extends Bloc<CustomerChangePasswordEvent, CustomerChangePasswordState> {

  final BuildContext context;
  bool enableErrorText = false;

  CustomerChangePasswordBloc(this.context);

  @override
  CustomerChangePasswordState get initialState => InitialCustomerChangePasswordState(enableErrorText);

  @override
  Stream<CustomerChangePasswordState> mapEventToState(CustomerChangePasswordEvent event) async* {
    if (event is BasketCustomerChangePasswordEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_BASKET_ROUTE);
    }
    if (event is NavigateCustomerChangePasswordEvent) {
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
        return;
      }
      if (event.value == AppLocalizations.of(context).translate("menu_logout")) {
        Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.MAIN_ROUTE, (Route<dynamic> route) => false);
        return;
      }
    }
    if (event is SaveCustomerChangePasswordEvent) {
      enableErrorText = true;
      yield InitialCustomerChangePasswordState(enableErrorText);
      if (event.password.isNotEmpty) {
        User user = User(
          id: AllServices().databaseService.getUser().id,
          name: AllServices().databaseService.getUser().name,
          surname: AllServices().databaseService.getUser().surname,
          address: AllServices().databaseService.getUser().address,
          phone: AllServices().databaseService.getUser().phone,
          username: AllServices().databaseService.getUser().username,
          password: event.password,
          type: AllServices().databaseService.getUser().type,
        );
        AllServices().databaseService.setUser(user);
        AllServices().databaseService.userDatabase.updateUser(user);
        MessageDialog.showClassic(
          context: context,
          message: AppLocalizations.of(context).translate("customer_change_password_route_saved_data"),
          onClose: () {
            Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_PROFILE_ROUTE);
          },
        );
      }
    }
  }
}