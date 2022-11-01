import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:starter_pack/data/beans/order.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/resources/widgets/dialogs/allow_order_dialog.dart';
import 'package:starter_pack/resources/widgets/dialogs/loading_dialog.dart';
import 'package:starter_pack/services/all_services.dart';
import './bloc.dart';
import 'package:starter_pack/route_generator.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/app_localizations.dart';

class VendorAllOrdersBloc extends Bloc<VendorAllOrdersEvent, VendorAllOrdersState> {
  final BuildContext context;

  List<Order> orders = [];

  VendorAllOrdersBloc(this.context);

  @override
  VendorAllOrdersState get initialState => InitialVendorAllOrdersState(orders);

  @override
  Stream<VendorAllOrdersState> mapEventToState(VendorAllOrdersEvent event) async* {
    if (event is InitializeVendorAllOrdersEvent) {
      LoadingDialog.showLoading(context);
      orders = await AllServices().databaseService.orderDatabase.getAllOrders();
      LoadingDialog.close(context);
      yield InitialVendorAllOrdersState(orders);
    }
    if (event is AllOrdersVendorAllOrdersEvent) {
      yield InitialVendorAllOrdersState(orders);
    }
    if (event is AddProductVendorAllOrdersEvent) {
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_ADD_PRODUCT_ROUTE);
    }
    if (event is ChangeOptionsVendorAllOrdersEvent) {
      yield ChangeOptionsVendorAllOrdersState(orders);
    }
    if (event is InitialOptionsVendorAllOrdersEvent) {
      yield InitialVendorAllOrdersState(orders);
    }
    if (event is GoToChangePersonalDataVendorAllOrdersEvent) {
      yield InitialVendorAllOrdersState(orders);
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_CHANGE_PROFILE_DATA_ROUTE);
    }
    if (event is GoToChangePasswordVendorAllOrdersEvent) {
      yield InitialVendorAllOrdersState(orders);
      Navigator.of(context).popAndPushNamed(RouteGenerator.VENDOR_CHANGE_PASSWORD_ROUTE);
    }
    if (event is LogoutVendorAllOrdersEvent) {
      Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.MAIN_ROUTE, (Route<dynamic> route) => false);
    }
    if (event is OpenDialogToAllowOrderVendorAllOrdersEvent) {
      AllowOrderDialog.showClassic(
        context: context,
        message: '',
        allowFunction: () {
          this.add(AllowOrderVendorAllOrdersEvent(event.order));
        },
      );
    }
    if (event is AllowOrderVendorAllOrdersEvent) {
      Order order = new Order(
        id: event.order.id,
        username: event.order.username,
        price: event.order.price,
        status: Order.ORDER_ALLOWED,
      );
      yield RefreshVendorAllOrdersState([]);
      LoadingDialog.showLoading(context);
      await AllServices().databaseService.orderDatabase.updateOrder(order);
      orders = await AllServices().databaseService.orderDatabase.getAllOrders();
      LoadingDialog.close(context);
      yield InitialVendorAllOrdersState(orders);
    }
    if (event is DeclineOrderAllOrdersEvent) {
      Order order = new Order(
        id: event.order.id,
        username: event.order.username,
        price: event.order.price,
        status: Order.ORDER_NOT_ALLOWED,
      );
      yield RefreshVendorAllOrdersState([]);
      LoadingDialog.showLoading(context);
      await AllServices().databaseService.orderDatabase.updateOrder(order);
      orders = await AllServices().databaseService.orderDatabase.getAllOrders();
      LoadingDialog.close(context);
      yield InitialVendorAllOrdersState(orders);
    }
  }
}
