import 'package:meta/meta.dart';

@immutable
abstract class CustomerChangeDataState {
  final bool enableErrorText;
  CustomerChangeDataState(this.enableErrorText);
}

class InitialCustomerChangeDataState extends CustomerChangeDataState {
  InitialCustomerChangeDataState(bool enableErrorText) : super(enableErrorText);
}

class ChangeOptionsCustomerChangeDataState extends CustomerChangeDataState {
  ChangeOptionsCustomerChangeDataState(bool enableErrorText) : super(enableErrorText);
}


