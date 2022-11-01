import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/customer/customer_change_data/bloc.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/widgets/icon_text_field.dart';
import 'package:starter_pack/resources/widgets/buttons/side_menu_button.dart';
import 'package:starter_pack/resources/widgets/side_menu.dart';
import 'package:starter_pack/resources/widgets/card_container.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_text_field.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_radio_buttons.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_button.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/services/all_services.dart';

class CustomerChangeDataRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerChangeDataBloc(context),
      child: _CustomerChangeDataStatefulWidget(),
    );
  }
}

class _CustomerChangeDataStatefulWidget extends StatefulWidget {
  _CustomerChangeDataStatefulWidgetState createState() => _CustomerChangeDataStatefulWidgetState();
}

class _CustomerChangeDataStatefulWidgetState extends State<_CustomerChangeDataStatefulWidget> {
  CustomerChangeDataBloc _customerChangeDataBloc;
  String name = AllServices().databaseService.getUser().name != null ? AllServices().databaseService.getUser().name : "";
  String surname = AllServices().databaseService.getUser().surname != null ? AllServices().databaseService.getUser().surname : "";
  String address = AllServices().databaseService.getUser().address != null ? AllServices().databaseService.getUser().address : "";
  String phone = AllServices().databaseService.getUser().phone != null ? AllServices().databaseService.getUser().phone : "";

  @override
  void initState() {
    _customerChangeDataBloc = BlocProvider.of<CustomerChangeDataBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _customerChangeDataBloc,
      builder: (BuildContext context, CustomerChangeDataState state) {
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
                                _customerChangeDataBloc.add(ProductsCustomerChangeDataEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_basket"),
                              icon: Icon(Icons.shopping_basket),
                              padding: 35,
                              width: 80,
                              onPressed: () {
                                _customerChangeDataBloc.add(BasketCustomerChangeDataEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_change_data"),
                              icon: Icon(Icons.create_rounded),
                              width: 180,
                              onPressed: () {
                                if (state is InitialCustomerChangeDataState) {
                                  _customerChangeDataBloc.add(ChangeOptionsCustomerChangeDataEvent());
                                } else {
                                  _customerChangeDataBloc.add(InitialOptionsCustomerChangeDataEvent());
                                }
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_logout"),
                              icon: Icon(Icons.logout),
                              width: 120,
                              onPressed: () {
                                _customerChangeDataBloc.add(LogoutCustomerChangeDataEvent());
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
                    heightPercent: 0.45,
                    children: [
                      HexagonTextField(
                        margin: EdgeInsets.only(top: 10),
                        icon: Icon(Icons.portrait),
                        hintText: AppLocalizations.of(context).translate("register_route_name"),
                        enableErrorText: state.enableErrorText,
                        errorText: AppLocalizations.of(context).translate("register_route_insert_name"),
                        text: name,
                        onChanged: (text) {
                          name = text;
                        },
                      ),
                      HexagonTextField(
                        icon: Icon(Icons.account_box),
                        hintText: AppLocalizations.of(context).translate("register_route_surname"),
                        enableErrorText: state.enableErrorText,
                        errorText: AppLocalizations.of(context).translate("register_route_insert_surname"),
                        text: surname,
                        onChanged: (text) {
                          surname = text;
                        },
                      ),
                      HexagonTextField(
                        icon: Icon(Icons.location_on),
                        hintText: AppLocalizations.of(context).translate("register_route_address"),
                        enableErrorText: state.enableErrorText,
                        errorText: AppLocalizations.of(context).translate("register_route_insert_address"),
                        text: address,
                        onChanged: (text) {
                          address = text;
                        },
                      ),
                      HexagonTextField(
                        icon: Icon(Icons.phone),
                        hintText: AppLocalizations.of(context).translate("register_route_phone"),
                        enableErrorText: state.enableErrorText,
                        errorText: AppLocalizations.of(context).translate("register_route_insert_phone"),
                        text: phone,
                        onChanged: (text) {
                          phone = text;
                        },
                      ),
                      HexagonButton(
                        text: AppLocalizations.of(context).translate("customer_change_data_route_save_data"),
                        onPressed: () {
                          _customerChangeDataBloc.add(SaveCustomerChangeDataEvent(name, surname, address, phone));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SideMenu(
                marginRight: 240,
                visible: state is ChangeOptionsCustomerChangeDataState,
                sideMenuButtons: <Widget>[
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_personal_data"),
                    onTap: () {
                      _customerChangeDataBloc.add(GoToChangePersonalDataCustomerChangeDataEvent());
                    },
                  ),
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_password"),
                    onTap: () {
                      _customerChangeDataBloc.add(GoToChangePasswordCustomerChangeDataEvent());
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
    _customerChangeDataBloc.close();
    super.dispose();
  }
}
