import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:starter_pack/route_generator.dart';
import 'package:starter_pack/services/all_services.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final BuildContext context;

  SplashBloc(this.context);

  @override
  SplashState get initialState => InitialSplashState();

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is InitialSplashEvent) {
      await AllServices().databaseService.initiate(context);
      Navigator.of(context).popAndPushNamed(RouteGenerator.MAIN_ROUTE);
    }
  }
}
