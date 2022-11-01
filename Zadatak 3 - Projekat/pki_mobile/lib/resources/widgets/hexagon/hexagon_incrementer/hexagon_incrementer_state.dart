import 'package:meta/meta.dart';
import 'package:starter_pack/data/beans/product.dart';

@immutable
abstract class HexagonIncrementerState {
  final int quantity;
  HexagonIncrementerState(this.quantity);
}

class InitialHexagonIncrementerState extends HexagonIncrementerState {
  InitialHexagonIncrementerState(int quantity) : super(quantity);
}