import 'package:meta/meta.dart';

@immutable
abstract class CustomerChangeProfileDataState {
  final bool enableErrorText;
  CustomerChangeProfileDataState(this.enableErrorText);
}

class InitialCustomerChangeProfileDataState extends CustomerChangeProfileDataState {
  InitialCustomerChangeProfileDataState(bool enableErrorText) : super(enableErrorText);
}
