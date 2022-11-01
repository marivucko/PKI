import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './bloc.dart';

class HexagonIncrementerBloc extends Bloc<HexagonIncrementerEvent, HexagonIncrementerState> {

  final BuildContext context;
  HexagonIncrementerBloc(this.context);

   int quantity = 1;

  @override
  HexagonIncrementerState get initialState => InitialHexagonIncrementerState(quantity);

  @override
  Stream<HexagonIncrementerState> mapEventToState(HexagonIncrementerEvent event) async* {
    if (event is IncHexagonIncrementerEvent) {
      quantity = quantity + 1;
      yield InitialHexagonIncrementerState(quantity);
    }
    if (event is DecHexagonIncrementerEvent) {
      if (quantity > 1) {
        quantity = quantity - 1;
      }
      yield InitialHexagonIncrementerState(quantity);
    }
  }

}