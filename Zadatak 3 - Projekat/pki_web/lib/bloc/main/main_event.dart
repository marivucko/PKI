part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class LoginMainEvent extends MainEvent {}

class RegisterMainEvent extends MainEvent {}

class ProfileOptionsMainEvent extends MainEvent {}

class InitialOptionsMainEvent extends MainEvent {}
