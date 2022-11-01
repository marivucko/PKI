import 'package:meta/meta.dart';

@immutable
abstract class CustomerHomeState {}

class InitialCustomerHomeState extends CustomerHomeState {}

class ChangeOptionsCustomerHomeState extends CustomerHomeState {}
