import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:starter_pack/data/beans/order.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';
import 'package:starter_pack/route_generator.dart';

class CustomerBasketBloc extends Bloc<CustomerBasketEvent, CustomerBasketState> {
  final BuildContext context;

  CustomerBasketBloc(this.context);

  @override
  CustomerBasketState get initialState => InitialCustomerBasketState();

  @override
  Stream<CustomerBasketState> mapEventToState(CustomerBasketEvent event) async* {
    if (event is ProductsCustomerBasketEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_ALL_PRODUCTS_ROUTE);
    }
    if (event is BasketCustomerBasketEvent) {
      yield InitialCustomerBasketState();
    }
    if (event is ChangeOptionsCustomerBasketEvent) {
      yield ChangeOptionsCustomerBasketState();
    }
    if (event is InitialOptionsCustomerBasketEvent) {
      yield InitialCustomerBasketState();
    }
    if (event is GoToChangePersonalDataCustomerBasketEvent) {
      yield InitialCustomerBasketState();
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_CHANGE_PROFILE_DATA_ROUTE);
    }
    if (event is GoToChangePasswordCustomerBasketEvent) {
      yield InitialCustomerBasketState();
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_CHANGE_PASSWORD_ROUTE);
    }
    if (event is LogoutCustomerBasketEvent) {
      Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.MAIN_ROUTE, (Route<dynamic> route) => false);
    }
    if (event is OrderCustomerBasketEvent) {
      await AllServices().databaseService.orderDatabase.insertOrder(
        Order(
          username: AllServices().databaseService.user.username,
          price: AllServices().databaseService.basket.totalPrice,
          status: Order.ORDER_NOT_PROCESSED,
        ),
      );
      MessageDialog.showClassic(
        context: context,
        message: "Sadržaj iz korpe je naručen!",
        onClose: () {
          Navigator.of(context).pop();
          this.add(BasketCustomerBasketEvent());
        });
      AllServices().databaseService.clearBasket();
    }
  }
}
