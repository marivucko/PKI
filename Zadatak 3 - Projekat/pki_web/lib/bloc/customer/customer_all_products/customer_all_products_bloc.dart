import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:starter_pack/data/beans/product.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/resources/widgets/dialogs/loading_dialog.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';
import 'package:starter_pack/route_generator.dart';

class CustomerAllProductsBloc extends Bloc<CustomerAllProductsEvent, CustomerAllProductsState> {

  final BuildContext context;
  CustomerAllProductsBloc(this.context);

   List<Product> products = [];

  @override
  CustomerAllProductsState get initialState => InitialCustomerAllProductsState(products);

  @override
  Stream<CustomerAllProductsState> mapEventToState(CustomerAllProductsEvent event) async* {
    if (event is InitiateCustomerAllProductsEvent) {
      LoadingDialog.showLoading(context);
      products = await AllServices().databaseService.productDatabase.getAllProducts();
      LoadingDialog.close(context);
      yield InitialCustomerAllProductsState(products);
    }
    if (event is ViewOneProductCustomerAllProductsEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_ONE_PRODUCT_ROUTE, arguments: event.product);
    }
    if (event is ProductsCustomerAllProductsEvent) {
      yield InitialCustomerAllProductsState(products);
    }
    if (event is BasketCustomerAllProductsEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_BASKET_ROUTE);
    }
    if (event is ChangeOptionsCustomerAllProductsEvent) {
      yield ChangeOptionsCustomerAllProductsState(products);
    }
    if (event is InitialOptionsCustomerAllProductsEvent) {
      yield InitialCustomerAllProductsState(products);
    }
    if (event is GoToChangePersonalDataCustomerAllProductsEvent) {
      yield InitialCustomerAllProductsState(products);
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_CHANGE_PROFILE_DATA_ROUTE);
    }
    if (event is GoToChangePasswordCustomerAllProductsEvent) {
      yield InitialCustomerAllProductsState(products);
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_CHANGE_PASSWORD_ROUTE);
    }
    if (event is LogoutCustomerAllProductsEvent) {
      Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.MAIN_ROUTE, (Route<dynamic> route) => false);
    }
  }

}