import 'package:meta/meta.dart';

@immutable
abstract class CustomerHomeEvent {}

class ProductsCustomerHomeEvent extends CustomerHomeEvent {}

class BasketCustomerHomeEvent extends CustomerHomeEvent {}

class ChangeOptionsCustomerHomeEvent extends CustomerHomeEvent {}

class InitialOptionsCustomerHomeEvent extends CustomerHomeEvent {}

class GoToChangePersonalDataCustomerHomeEvent extends CustomerHomeEvent {}

class GoToChangePasswordCustomerHomeEvent extends CustomerHomeEvent {}

class LogoutCustomerHomeEvent extends CustomerHomeEvent {}



