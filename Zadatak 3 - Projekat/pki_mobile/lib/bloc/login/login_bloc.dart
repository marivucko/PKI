import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/register/register_bloc.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/resources/widgets/dialogs/loading_dialog.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/route_generator.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final BuildContext context;
  bool enableErrorText = false;

  LoginBloc(this.context);

  @override
  LoginState get initialState => InitialLoginState(enableErrorText);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginLoginEvent) {
      enableErrorText = true;
      yield InitialLoginState(enableErrorText);
      if (event.username.isNotEmpty && event.password.isNotEmpty) {
        LoadingDialog.showLoading(context);
        User user = await AllServices().databaseService.userDatabase.getUserByUsername(event.username);
        LoadingDialog.close(context);
        if (user == null) {
          MessageDialog.showClassic(context: context, message: AppLocalizations.of(context).translate("login_route_username_does_not_exist"));
        } else {
          if (event.password != user.password) {
            MessageDialog.showClassic(context: context, message: AppLocalizations.of(context).translate("login_route_wrong_password"));
          } else {
            AllServices().databaseService.setUser(user);
            AllServices().databaseService.clearBasket();
            if (user.type == RegisterBloc.RADIO_BUTTON_CUSTOMER_SELECTED) {
              Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_HOME_ROUTE);
            } else {
              MessageDialog.showClassic(context: context, message: AppLocalizations.of(context).translate("login_route_username_is_vendor"));
            }
          }
        }
      }
    }
  }

}