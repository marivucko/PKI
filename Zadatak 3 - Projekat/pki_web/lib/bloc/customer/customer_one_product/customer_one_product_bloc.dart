import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:starter_pack/data/beans/order_item.dart';
import 'package:starter_pack/data/beans/product.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';
import 'package:starter_pack/route_generator.dart';

class CustomerOneProductBloc extends Bloc<CustomerOneProductEvent, CustomerOneProductState> {

  final BuildContext context;
  CustomerOneProductBloc(this.context);

  int quantity = 1;

  @override
  CustomerOneProductState get initialState => InitialCustomerOneProductState(quantity);

  @override
  Stream<CustomerOneProductState> mapEventToState(CustomerOneProductEvent event) async* {
    if (event is ProductCustomerOneProductEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_ALL_PRODUCTS_ROUTE);
      yield InitialCustomerOneProductState(quantity);
    }
    if (event is BasketCustomerOneProductEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_BASKET_ROUTE);
    }
    if (event is ChangeOptionsCustomerOneProductEvent) {
      yield ChangeOptionsCustomerOneProductState(quantity);
    }
    if (event is InitialOptionsCustomerOneProductEvent) {
      yield InitialCustomerOneProductState(quantity);
    }
    if (event is GoToChangePersonalDataCustomerOneProductEvent) {
      yield InitialCustomerOneProductState(quantity);
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_CHANGE_PROFILE_DATA_ROUTE);
    }
    if (event is GoToChangePasswordCustomerOneProductEvent) {
      yield InitialCustomerOneProductState(quantity);
      Navigator.of(context).popAndPushNamed(RouteGenerator.CUSTOMER_CHANGE_PASSWORD_ROUTE);
    }
    if (event is LogoutCustomerOneProductEvent) {
      Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.MAIN_ROUTE, (Route<dynamic> route) => false);
    }
    if (event is IncrementQuantityCustomerOneProductEvent) {
      quantity = quantity + 1;
      yield InitialCustomerOneProductState(quantity);
    }
    if (event is DecrementQuantityCustomerOneProductEvent) {
      if (quantity > 1) {
        quantity = quantity - 1;
      }
      yield InitialCustomerOneProductState(quantity);
    }
    if (event is AddToBasketCustomerOneProductEvent) {
      AllServices().databaseService.basket.addOrderItem(OrderItem(event.product, event.quantity));
      MessageDialog.showClassic(context: context, message: "Proizvod je uspešno dodat u korpu.");
    }
  }

}