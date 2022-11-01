import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';
import 'package:starter_pack/route_generator.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/app_localizations.dart';

class CustomerChangePasswordBloc extends Bloc<CustomerChangePasswordEvent, CustomerChangePasswordState> {
  final BuildContext context;
  bool enableErrorText = false;

  CustomerChangePasswordBloc(this.context);

  @override
  CustomerChangePasswordState get initialState => InitialCustomerChangePasswordState(enableErrorText);

  @override
  Stream<CustomerChangePasswordState> mapEventToState(CustomerChangePasswordEvent event) async* {
    if (event is ProductsCustomerChangePasswordEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_ALL_PRODUCTS_ROUTE);
    }
    if (event is BasketCustomerChangePasswordEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_BASKET_ROUTE);
    }
    if (event is ChangeOptionsCustomerChangePasswordEvent) {
      yield ChangeOptionsCustomerChangePasswordState(enableErrorText);
    }
    if (event is InitialOptionsCustomerChangePasswordEvent) {
      yield InitialCustomerChangePasswordState(enableErrorText);
    }
    if (event is GoToChangeDataCustomerChangePasswordEvent) {
      yield InitialCustomerChangePasswordState(enableErrorText);
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_CHANGE_PROFILE_DATA_ROUTE);
    }
    if (event is GoToChangePasswordCustomerChangePasswordEvent) {
      yield InitialCustomerChangePasswordState(enableErrorText);
    }
    if (event is LogoutCustomerChangePasswordEvent) {
      Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.MAIN_ROUTE, (Route<dynamic> route) => false);
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
          message: "Lozinka je uspešno promenjena.",
          onClose: () {
            Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_HOME_ROUTE);
          },
        );
      }
    }
  }
}
