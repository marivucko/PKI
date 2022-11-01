import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/resources/widgets/dialogs/loading_dialog.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';
import 'package:starter_pack/route_generator.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/app_localizations.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  static const int RADIO_BUTTON_CUSTOMER_SELECTED = 0;
  static const int RADIO_BUTTON_VENDOR_SELECTED = 1;

  final BuildContext context;
  int selectedRadio = RADIO_BUTTON_CUSTOMER_SELECTED;
  bool enableErrorText = false;

  RegisterBloc(this.context);

  @override
  RegisterState get initialState => InitialRegisterState(RADIO_BUTTON_CUSTOMER_SELECTED, enableErrorText);

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is HomeRegisterEvent) {
      Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.MAIN_ROUTE, (Route<dynamic> route) => false);
    }
    if (event is GoToLoginRegisterEvent) {
      yield InitialRegisterState(selectedRadio, enableErrorText);
      Navigator.of(context).popAndPushNamed(RouteGenerator.LOGIN_ROUTE);
    }
    if (event is GoToRegisterRegisterEvent) {
      yield InitialRegisterState(selectedRadio, enableErrorText);
    }
    if (event is ProfileOptionsRegisterEvent) {
      yield ProfileOptionsRegisterState(selectedRadio, enableErrorText);
    }
    if (event is InitialOptionsRegisterEvent) {
      yield InitialRegisterState(selectedRadio, enableErrorText);
    }
    if (event is SetCustomerRegisterEvent) {
      selectedRadio = RADIO_BUTTON_CUSTOMER_SELECTED;
      yield InitialRegisterState(selectedRadio, enableErrorText);
    }
    if (event is SetVendorRegisterEvent) {
      selectedRadio = RADIO_BUTTON_VENDOR_SELECTED;
      yield InitialRegisterState(selectedRadio, enableErrorText);
    }
    if (event is RegisterRegisterEvent) {
      enableErrorText = true;
      yield InitialRegisterState(selectedRadio, enableErrorText);
      if (event.name.isNotEmpty && event.surname.isNotEmpty && event.address.isNotEmpty && event.phone.isNotEmpty && event.username.isNotEmpty && event.password.isNotEmpty) {
        LoadingDialog.showLoading(context);
        if (await AllServices().databaseService.userDatabase.getUserByUsername(event.username) != null) {
          LoadingDialog.close(context);
          MessageDialog.showClassic(context: context, message: AppLocalizations.of(context).translate("register_route_insert_username_already_exists"));
        } else {
          User user = User(
            name: event.name,
            surname: event.surname,
            address: event.address,
            phone: event.phone,
            username: event.username,
            password: event.password,
            type: selectedRadio,
          );
          await AllServices().databaseService.userDatabase.insertUser(user);
          User user1 = await AllServices().databaseService.userDatabase.getUserByUsername(event.username);
          AllServices().databaseService.setUser(user1);
          AllServices().databaseService.clearBasket();
          LoadingDialog.close(context);
          if (selectedRadio == RADIO_BUTTON_CUSTOMER_SELECTED) {
            Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_HOME_ROUTE);
          } else {
            Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_HOME_ROUTE);
          }
        }
      }
    }
  }
}
