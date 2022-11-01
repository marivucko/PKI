import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/customer/customer_one_product/bloc.dart';
import 'package:starter_pack/data/beans/product.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/widgets/card_container_for_list_view.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_incrementer/hexagon_incrementer.dart';
import 'package:starter_pack/resources/widgets/icon_text_field.dart';
import 'package:starter_pack/resources/widgets/buttons/side_menu_button.dart';
import 'package:starter_pack/resources/widgets/product/product_card.dart';
import 'package:starter_pack/resources/widgets/product/small_product_card.dart';
import 'package:starter_pack/resources/widgets/side_menu.dart';
import 'package:starter_pack/resources/widgets/card_container.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_text_field.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_radio_buttons.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_button.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/services/all_services.dart';

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
    _customerOneProductBloc.add(InitiateCustomerOneProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _customerOneProductBloc,
      builder: (BuildContext context, CustomerOneProductState state) {
        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: color_orange_card_container,
                    height: app_bar_height / 2,
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 100,
                        width: 780,
                        child: Row(
                          children: [
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_products_list"),
                              icon: Icon(Icons.list),
                              onPressed: () {
                                print('f22');
                                _customerOneProductBloc.add(ProductCustomerOneProductEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_basket"),
                              icon: Icon(Icons.shopping_basket),
                              padding: 35,
                              width: 80,
                              onPressed: () {
                                _customerOneProductBloc.add(BasketCustomerOneProductEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_change_data"),
                              icon: Icon(Icons.create_rounded),
                              width: 180,
                              onPressed: () {
                                if (state is InitialCustomerOneProductState) {
                                  _customerOneProductBloc.add(ChangeOptionsCustomerOneProductEvent());
                                } else {
                                  _customerOneProductBloc.add(InitialOptionsCustomerOneProductEvent());
                                }
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_logout"),
                              icon: Icon(Icons.logout),
                              width: 120,
                              onPressed: () {
                                _customerOneProductBloc.add(LogoutCustomerOneProductEvent());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(
                  left: margin_larger,
                ),
                height: 130,
                width: logo_width,
                child: Center(
                  child: FittedBox(
                    child: Image.asset('assets/images/logo.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.center,
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
                  child: CardContainer(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    heightPercent: 0.65,
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
                          print("ovdeovde ${HexagonIncrementer.getQuantity()}");
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SideMenu(
                marginRight: 240,
                visible: state is ChangeOptionsCustomerOneProductState,
                sideMenuButtons: <Widget>[
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_personal_data"),
                    onTap: () {
                      _customerOneProductBloc.add(GoToChangePersonalDataCustomerOneProductEvent());
                    },
                  ),
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_password"),
                    onTap: () {
                      _customerOneProductBloc.add(GoToChangePasswordCustomerOneProductEvent());
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _customerOneProductBloc.close();
    super.dispose();
  }
}
