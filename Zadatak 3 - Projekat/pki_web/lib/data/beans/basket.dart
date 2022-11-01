import 'package:starter_pack/data/beans/order_item.dart';

class Basket {
  List<OrderItem> orderItemList = [];
  double totalPrice = 0;

  void addOrderItem(OrderItem orderItem) {
    bool exists = false;
    for (int i = 0; i < orderItemList.length; i++) {
      if (orderItemList[i].product.id == orderItem.product.id) {
        orderItemList[i].quantity += orderItem.quantity;
        exists = true;
        break;
      }
    }
    if (!exists) {
      orderItemList.add(orderItem);
    }
    totalPrice = totalPrice + orderItem.product.price * orderItem.quantity;
  }
}