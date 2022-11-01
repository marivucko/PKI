import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/data/user_database.dart';
import 'package:starter_pack/resources/widgets/dialogs/loading_dialog.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/route_generator.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  static const int RADIO_BUTTON_CUSTOMER_SELECTED = 0;
  static const int RADIO_BUTTON_VENDOR_SELECTED = 1;

  final BuildContext context;

  bool enableErrorText = false;
  RegisterBloc(this.context);

  @override
  RegisterState get initialState => InitialRegisterState(enableErrorText);

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterRegisterEvent) {
      enableErrorText = true;
      yield InitialRegisterState(enableErrorText);
      if (event.name.isNotEmpty && event.surname.isNotEmpty && event.address.isNotEmpty && event.phone.isNotEmpty && event.username.isNotEmpty && event.password.isNotEmpty) {
        LoadingDialog.showLoading(context);
        if (await AllServices().databaseService.userDatabase.getUserByUsername(event.username) != null) {
          LoadingDialog.close(context);
          MessageDialog.showClassic(context: context, message: AppLocalizations.of(context).translate("register_route_insert_username_already_exists"));
        } else {
          User user = User(name: event.name,
            surname: event.surname,
            address: event.address,
            phone: event.phone,
            username: event.username,
            password: event.password,
            type: RADIO_BUTTON_CUSTOMER_SELECTED,
          );
          await AllServices().databaseService.insertUserInfo(user);
          User user1 = await AllServices().databaseService.userDatabase.getUserByUsername(event.username);
          AllServices().databaseService.setUser(user1);
          AllServices().databaseService.clearBasket();
          LoadingDialog.close(context);
          Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_HOME_ROUTE);
        }
      }
    }
  }

}