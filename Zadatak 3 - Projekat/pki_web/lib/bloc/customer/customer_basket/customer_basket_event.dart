import 'package:meta/meta.dart';

@immutable
abstract class CustomerBasketEvent {}

class ProductsCustomerBasketEvent extends CustomerBasketEvent {}

class BasketCustomerBasketEvent extends CustomerBasketEvent {}

class ChangeOptionsCustomerBasketEvent extends CustomerBasketEvent {}

class InitialOptionsCustomerBasketEvent extends CustomerBasketEvent {}

class GoToChangePersonalDataCustomerBasketEvent extends CustomerBasketEvent {}

class GoToChangePasswordCustomerBasketEvent extends CustomerBasketEvent {}

class LogoutCustomerBasketEvent extends CustomerBasketEvent {}

class OrderCustomerBasketEvent extends CustomerBasketEvent {}



