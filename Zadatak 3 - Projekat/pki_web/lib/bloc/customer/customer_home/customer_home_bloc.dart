import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';
import 'package:starter_pack/route_generator.dart';

class CustomerHomeBloc extends Bloc<CustomerHomeEvent, CustomerHomeState> {


  final BuildContext context;
  CustomerHomeBloc(this.context);

  @override
  CustomerHomeState get initialState => InitialCustomerHomeState();

  @override
  Stream<CustomerHomeState> mapEventToState(CustomerHomeEvent event) async* {
    if (event is ProductsCustomerHomeEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_ALL_PRODUCTS_ROUTE);
    }
    if (event is BasketCustomerHomeEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_BASKET_ROUTE);
    }
    if (event is ChangeOptionsCustomerHomeEvent) {
      yield ChangeOptionsCustomerHomeState();
    }
    if (event is InitialOptionsCustomerHomeEvent) {
      yield InitialCustomerHomeState();
    }
    if (event is GoToChangePersonalDataCustomerHomeEvent) {
      yield InitialCustomerHomeState();
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_CHANGE_PROFILE_DATA_ROUTE);
    }
    if (event is GoToChangePasswordCustomerHomeEvent) {
      yield InitialCustomerHomeState();
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_CHANGE_PASSWORD_ROUTE);
    }
    if (event is LogoutCustomerHomeEvent) {
      Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.MAIN_ROUTE, (Route<dynamic> route) => false);
    }
  }

}