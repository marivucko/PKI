import 'package:meta/meta.dart';

@immutable
abstract class CustomerBasketState {}

class InitialCustomerBasketState extends CustomerBasketState {}

class ChangeOptionsCustomerBasketState extends CustomerBasketState {}
