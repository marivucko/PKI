import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';
import 'package:starter_pack/route_generator.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/app_localizations.dart';

class VendorChangePasswordBloc extends Bloc<VendorChangePasswordEvent, VendorChangePasswordState> {
  final BuildContext context;
  bool enableErrorText = false;

  VendorChangePasswordBloc(this.context);

  @override
  VendorChangePasswordState get initialState => InitialVendorChangePasswordState(enableErrorText);

  @override
  Stream<VendorChangePasswordState> mapEventToState(VendorChangePasswordEvent event) async* {
    if (event is AllOrdersVendorChangePasswordEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_ALL_ORDERS_ROUTE);
    }
    if (event is AddProductVendorChangePasswordEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_ADD_PRODUCT_ROUTE);
    }
    if (event is ChangeOptionsVendorChangePasswordEvent) {
      yield ChangeOptionsVendorChangePasswordState(enableErrorText);
    }
    if (event is InitialOptionsVendorChangePasswordEvent) {
      yield InitialVendorChangePasswordState(enableErrorText);
    }
    if (event is GoToChangePersonalDataVendorChangePasswordEvent) {
      yield InitialVendorChangePasswordState(enableErrorText);
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_CHANGE_PROFILE_DATA_ROUTE);
    }
    if (event is GoToChangePasswordVendorChangePasswordEvent) {
      yield InitialVendorChangePasswordState(enableErrorText);
    }
    if (event is LogoutVendorChangePasswordEvent) {
      Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.MAIN_ROUTE, (Route<dynamic> route) => false);
    }
    if (event is SaveVendorChangePasswordEvent) {
      enableErrorText = true;
      yield InitialVendorChangePasswordState(enableErrorText);
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
            Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_HOME_ROUTE);
          },
        );
      }
    }
  }
}
