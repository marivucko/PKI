import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';
import 'package:starter_pack/route_generator.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/app_localizations.dart';

class VendorChangeDataBloc extends Bloc<VendorChangeDataEvent, VendorChangeDataState> {
  final BuildContext context;
  bool enableErrorText = false;

  VendorChangeDataBloc(this.context);

  @override
  VendorChangeDataState get initialState => InitialVendorChangeDataState(enableErrorText);

  @override
  Stream<VendorChangeDataState> mapEventToState(VendorChangeDataEvent event) async* {
    if (event is AllOrdersVendorChangeDataEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_ALL_ORDERS_ROUTE);
    }
    if (event is AddProductVendorChangeDataEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_ADD_PRODUCT_ROUTE);
    }
    if (event is ChangeOptionsVendorChangeDataEvent) {
      yield ChangeOptionsVendorChangeDataState(enableErrorText);
    }
    if (event is InitialOptionsVendorChangeDataEvent) {
      yield InitialVendorChangeDataState(enableErrorText);
    }
    if (event is GoToChangePersonalDataVendorChangeDataEvent) {
      yield InitialVendorChangeDataState(enableErrorText);
    }
    if (event is GoToChangePasswordVendorChangeDataEvent) {
      yield InitialVendorChangeDataState(enableErrorText);
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_CHANGE_PASSWORD_ROUTE);
    }
    if (event is LogoutVendorChangeDataEvent) {
      Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.MAIN_ROUTE, (Route<dynamic> route) => false);
    }
    if (event is SaveVendorChangeDataEvent) {
      enableErrorText = true;
      yield InitialVendorChangeDataState(enableErrorText);
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
            Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_HOME_ROUTE);
          },
        );
      }
    }
  }
}
