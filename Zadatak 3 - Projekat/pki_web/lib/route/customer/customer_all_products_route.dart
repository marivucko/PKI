import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/customer/customer_all_products/bloc.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/widgets/card_container_for_list_view.dart';
import 'package:starter_pack/resources/widgets/icon_text_field.dart';
import 'package:starter_pack/resources/widgets/buttons/side_menu_button.dart';
import 'package:starter_pack/resources/widgets/product/small_product_card.dart';
import 'package:starter_pack/resources/widgets/side_menu.dart';
import 'package:starter_pack/resources/widgets/card_container.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_text_field.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_radio_buttons.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_button.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/services/all_services.dart';

class CustomerAllProductsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerAllProductsBloc(context),
      child: _CustomerAllProductsStatefulWidget(),
    );
  }
}

class _CustomerAllProductsStatefulWidget extends StatefulWidget {
  _CustomerAllProductsStatefulWidgetState createState() => _CustomerAllProductsStatefulWidgetState();
}

class _CustomerAllProductsStatefulWidgetState extends State<_CustomerAllProductsStatefulWidget> {
  CustomerAllProductsBloc _customerAllProductsBloc;

  @override
  void initState() {
    _customerAllProductsBloc = BlocProvider.of<CustomerAllProductsBloc>(context);
    _customerAllProductsBloc.add(InitiateCustomerAllProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _customerAllProductsBloc,
      builder: (BuildContext context, CustomerAllProductsState state) {
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
                                _customerAllProductsBloc.add(ProductsCustomerAllProductsEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_basket"),
                              icon: Icon(Icons.shopping_basket),
                              padding: 35,
                              width: 80,
                              onPressed: () {
                                _customerAllProductsBloc.add(BasketCustomerAllProductsEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_change_data"),
                              icon: Icon(Icons.create_rounded),
                              width: 180,
                              onPressed: () {
                                if (state is InitialCustomerAllProductsState) {
                                  _customerAllProductsBloc.add(ChangeOptionsCustomerAllProductsEvent());
                                } else {
                                  _customerAllProductsBloc.add(InitialOptionsCustomerAllProductsEvent());
                                }
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_logout"),
                              icon: Icon(Icons.logout),
                              width: 120,
                              onPressed: () {
                                _customerAllProductsBloc.add(LogoutCustomerAllProductsEvent());
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
                  child: CardContainerForListView(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    heightPercent: 0.70,
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SmallProductCard(
                          product: state.products[index],
                          onTap: () {
                            _customerAllProductsBloc.add(ViewOneProductCustomerAllProductsEvent(state.products[index]));
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              SideMenu(
                marginRight: 240,
                visible: state is ChangeOptionsCustomerAllProductsState,
                sideMenuButtons: <Widget>[
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_personal_data"),
                    onTap: () {
                      _customerAllProductsBloc.add(GoToChangePersonalDataCustomerAllProductsEvent());
                    },
                  ),
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_password"),
                    onTap: () {
                      _customerAllProductsBloc.add(GoToChangePasswordCustomerAllProductsEvent());
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
    _customerAllProductsBloc.close();
    super.dispose();
  }
}
