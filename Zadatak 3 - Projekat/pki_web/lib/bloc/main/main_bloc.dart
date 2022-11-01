import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:starter_pack/route_generator.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {

  final BuildContext context;

  MainBloc(this.context);

  @override
  MainState get initialState => InitialMainState();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is LoginMainEvent) {
      yield InitialMainState();
      Navigator.of(context).pushNamed(RouteGenerator.LOGIN_ROUTE);
    }
    if (event is RegisterMainEvent) {
      yield InitialMainState();
      Navigator.of(context).pushNamed(RouteGenerator.REGISTER_ROUTE);
    }
    if (event is ProfileOptionsMainEvent) {
      yield ProfileOptionsMainState();
    }
    if (event is InitialOptionsMainEvent) {
      yield InitialMainState();
    }
  }

}
