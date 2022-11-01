import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';
import 'package:starter_pack/route_generator.dart';

class VendorHomeBloc extends Bloc<VendorHomeEvent, VendorHomeState> {

  final BuildContext context;
  VendorHomeBloc(this.context);

  @override
  VendorHomeState get initialState => InitialVendorHomeState();

  @override
  Stream<VendorHomeState> mapEventToState(VendorHomeEvent event) async* {
    if (event is AllOrdersVendorHomeEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_ALL_ORDERS_ROUTE);
    }
    if (event is AddProductVendorHomeEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_ADD_PRODUCT_ROUTE);
    }
    if (event is ChangeOptionsVendorHomeEvent) {
      yield ChangeOptionsVendorHomeState();
    }
    if (event is InitialOptionsVendorHomeEvent) {
      yield InitialVendorHomeState();
    }
    if (event is GoToChangePersonalDataVendorHomeEvent) {
      yield InitialVendorHomeState();
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_CHANGE_PROFILE_DATA_ROUTE);
    }
    if (event is GoToChangePasswordVendorHomeEvent) {
      yield InitialVendorHomeState();
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_CHANGE_PASSWORD_ROUTE);
    }
    if (event is LogoutVendorHomeEvent) {
      Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.MAIN_ROUTE, (Route<dynamic> route) => false);
    }
  }

}