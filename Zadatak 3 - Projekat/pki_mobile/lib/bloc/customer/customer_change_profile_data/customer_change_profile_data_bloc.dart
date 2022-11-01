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

class CustomerChangeProfileDataBloc extends Bloc<CustomerChangeProfileDataEvent, CustomerChangeProfileDataState> {

  final BuildContext context;
  bool enableErrorText = false;

  CustomerChangeProfileDataBloc(this.context);

  @override
  CustomerChangeProfileDataState get initialState => InitialCustomerChangeProfileDataState(enableErrorText);

  @override
  Stream<CustomerChangeProfileDataState> mapEventToState(CustomerChangeProfileDataEvent event) async* {
    if (event is BasketCustomerChangeProfileDataEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_BASKET_ROUTE);
    }
    if (event is NavigateCustomerChangeProfileDataEvent) {
      if (event.value == AppLocalizations.of(context).translate("menu_all_products")) {
        Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_ALL_PRODUCTS_ROUTE);
        return;
      }
      if (event.value == AppLocalizations.of(context).translate("menu_view_profile")) {
        Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_PROFILE_ROUTE);
        return;
      }
      if (event.value == AppLocalizations.of(context).translate("menu_change_profile_data")) {
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
    if (event is SaveCustomerChangeProfileDataEvent) {
      enableErrorText = true;
      yield InitialCustomerChangeProfileDataState(enableErrorText);
      if (event.name.isNotEmpty && event.surname.isNotEmpty && event.address.isNotEmpty && event.phone.isNotEmpty) {
        User user = User(
          id: AllServices().databaseService.getUser().id,
          name: event.name,
          surname: event.surname,
          address: event.address,
          phone: event.phone,
          username: AllServices().databaseService.getUser().username,
          password: AllServices().databaseService.getUser().password,
          type: AllServices().databaseService.getUser().type,
        );
        AllServices().databaseService.setUser(user);
        AllServices().databaseService.userDatabase.updateUser(user);
        MessageDialog.showClassic(
          context: context,
          message: AppLocalizations.of(context).translate("customer_change_data_route_saved_data"),
          onClose: () {
            Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_PROFILE_ROUTE);
          },
        );
      }
    }
  }
}