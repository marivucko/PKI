import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';
import 'package:starter_pack/route_generator.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/app_localizations.dart';

class CustomerChangeDataBloc extends Bloc<CustomerChangeDataEvent, CustomerChangeDataState> {
  final BuildContext context;
  bool enableErrorText = false;

  CustomerChangeDataBloc(this.context);

  @override
  CustomerChangeDataState get initialState => InitialCustomerChangeDataState(enableErrorText);

  @override
  Stream<CustomerChangeDataState> mapEventToState(CustomerChangeDataEvent event) async* {
    if (event is ProductsCustomerChangeDataEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_ALL_PRODUCTS_ROUTE);
    }
    if (event is BasketCustomerChangeDataEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_BASKET_ROUTE);
    }
    if (event is ChangeOptionsCustomerChangeDataEvent) {
      yield ChangeOptionsCustomerChangeDataState(enableErrorText);
    }
    if (event is InitialOptionsCustomerChangeDataEvent) {
      yield InitialCustomerChangeDataState(enableErrorText);
    }
    if (event is GoToChangePersonalDataCustomerChangeDataEvent) {
      yield InitialCustomerChangeDataState(enableErrorText);
    }
    if (event is GoToChangePasswordCustomerChangeDataEvent) {
      yield InitialCustomerChangeDataState(enableErrorText);
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_CHANGE_PASSWORD_ROUTE);
    }
    if (event is LogoutCustomerChangeDataEvent) {
      Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.MAIN_ROUTE, (Route<dynamic> route) => false);
    }
    if (event is SaveCustomerChangeDataEvent) {
      enableErrorText = true;
      yield InitialCustomerChangeDataState(enableErrorText);
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
            Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_HOME_ROUTE);
          },
        );
      }
    }
  }
}
