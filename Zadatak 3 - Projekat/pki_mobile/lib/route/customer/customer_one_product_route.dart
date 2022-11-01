import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/customer/customer_one_product/bloc.dart';
import 'package:starter_pack/data/beans/product.dart';
import 'package:starter_pack/resources/widgets/background_widget.dart';
import 'package:starter_pack/resources/widgets/card_container.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_incrementer/hexagon_incrementer.dart';
import 'package:starter_pack/resources/widgets/product/product_card.dart';
import 'package:starter_pack/services/all_services.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/widgets/product/small_product_card.dart';

class CustomerOneProductRoute extends StatelessWidget {
  final Product product;

  const CustomerOneProductRoute({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerOneProductBloc(context),
      child: _CustomerOneProductStatefulWidget(product: product),
    );
  }
}

class _CustomerOneProductStatefulWidget extends StatefulWidget {
  final Product product;

  const _CustomerOneProductStatefulWidget({Key key, this.product}) : super(key: key);

  _CustomerOneProductStatefulWidgetState createState() => _CustomerOneProductStatefulWidgetState(product);
}

class _CustomerOneProductStatefulWidgetState extends State<_CustomerOneProductStatefulWidget> {
  CustomerOneProductBloc _customerOneProductBloc;

  final Product product;

  _CustomerOneProductStatefulWidgetState(this.product);

  @override
  void initState() {
    _customerOneProductBloc = BlocProvider.of<CustomerOneProductBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AllServices().designService.setTransparentStatusAndNavigationBar();

    List<String> choices = <String>[
      AppLocalizations.of(context).translate("menu_all_products"),
      AppLocalizations.of(context).translate("menu_view_profile"),
      AppLocalizations.of(context).translate("menu_change_profile_data"),
      AppLocalizations.of(context).translate("menu_change_password"),
      AppLocalizations.of(context).translate("menu_logout"),
    ];

    return new WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: BackgroundWidget(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                PopupMenuButton(
                  onSelected: (String value) {
                    _customerOneProductBloc.add(NavigateCustomerOneProductEvent(value));
                  },
                  icon: Icon(
                    Icons.menu,
                    color: color_black,
                    size: 36,
                  ),
                  color: color_black,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context) {
                    return choices.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Container(
                          margin: EdgeInsets.only(top: 4),
                          padding: EdgeInsets.only(bottom: 4),
                          width: MediaQuery.of(context).size.width,
                          child: AutoSizeText(
                            choice.toUpperCase(),
                            style: TextStyle(
                              color: color_dots,
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: color_dots,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList();
                  },
                )
              ],
            ),
            body: SafeArea(
              child: BlocBuilder(
                bloc: _customerOneProductBloc,
                builder: (BuildContext context, CustomerOneProductState state) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        child: CardContainer(
                          margin: EdgeInsets.all(10),
                          children: [
                            ProductCard(
                              product: product,
                              quantity: state.quantity,
                              onTap: () {},
                              onPressedUp: () {
                                _customerOneProductBloc.add(IncrementQuantityCustomerOneProductEvent());
                              },
                              onPressedDown: () {
                                _customerOneProductBloc.add(DecrementQuantityCustomerOneProductEvent());
                              },
                              addInBasket: () {
                                _customerOneProductBloc.add(AddToBasketCustomerOneProductEvent(product, HexagonIncrementer.getQuantity()));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            floatingActionButton: new FloatingActionButton(
              elevation: 0.0,
              child: new Icon(Icons.shopping_basket),
              backgroundColor: color_floating_action_bar_color,
              onPressed: () {
                _customerOneProductBloc.add(BasketCustomerOneProductEvent());
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _customerOneProductBloc.close();
    super.dispose();
  }
}
