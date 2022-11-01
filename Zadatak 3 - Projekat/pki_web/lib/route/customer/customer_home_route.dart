import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/customer/customer_home/bloc.dart';
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

class CustomerHomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerHomeBloc(context),
      child: _CustomerHomeStatefulWidget(),
    );
  }
}

class _CustomerHomeStatefulWidget extends StatefulWidget {
  _CustomerHomeStatefulWidgetState createState() => _CustomerHomeStatefulWidgetState();
}

class _CustomerHomeStatefulWidgetState extends State<_CustomerHomeStatefulWidget> {
  CustomerHomeBloc _customerHomeBloc;
  int selectedRadio;
  String name = "";
  String surname = "";
  String address = "";
  String phone = "";
  String username = "";
  String password = "";

  @override
  void initState() {
    _customerHomeBloc = BlocProvider.of<CustomerHomeBloc>(context);
    selectedRadio = 0;
    super.initState();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _customerHomeBloc,
      builder: (BuildContext context, CustomerHomeState state) {
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
                                _customerHomeBloc.add(ProductsCustomerHomeEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_basket"),
                              icon: Icon(Icons.shopping_basket),
                              padding: 35,
                              width: 80,
                              onPressed: () {
                                _customerHomeBloc.add(BasketCustomerHomeEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_change_data"),
                              icon: Icon(Icons.create_rounded),
                              width: 180,
                              onPressed: () {
                                if (state is InitialCustomerHomeState) {
                                  _customerHomeBloc.add(ChangeOptionsCustomerHomeEvent());
                                } else {
                                  _customerHomeBloc.add(InitialOptionsCustomerHomeEvent());
                                }
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_logout"),
                              icon: Icon(Icons.logout),
                              width: 120,
                              onPressed: () {
                                _customerHomeBloc.add(LogoutCustomerHomeEvent());
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
                    heightPercent: 0.50,
                    margin: EdgeInsets.only(bottom: margin, left: margin_small, right: margin_small),
                    children: [
                      HexagonTextField(
                        margin: EdgeInsets.only(top: 10),
                        icon: Icon(Icons.portrait),
                        hintText: AllServices().databaseService.getUser().name != null ? AllServices().databaseService.getUser().name : "",
                        errorText: null,
                        enableErrorText: true,
                        readOnly: true,
                        text: '',
                      ),
                      HexagonTextField(
                        margin: EdgeInsets.only(top: 10),
                        icon: Icon(Icons.account_box),
                        hintText: AllServices().databaseService.getUser().surname != null ? AllServices().databaseService.getUser().surname : "",
                        errorText: null,
                        enableErrorText: true,
                        readOnly: true,
                        text: '',
                      ),
                      HexagonTextField(
                        margin: EdgeInsets.only(top: 10),
                        icon: Icon(Icons.location_on),
                        hintText: AllServices().databaseService.getUser().address != null ? AllServices().databaseService.getUser().address : "",
                        errorText: null,
                        enableErrorText: true,
                        readOnly: true,
                        text: '',
                      ),
                      HexagonTextField(
                        margin: EdgeInsets.only(top: 10),
                        icon: Icon(Icons.phone),
                        hintText: AllServices().databaseService.getUser().phone != null ? AllServices().databaseService.getUser().phone : "",
                        errorText: null,
                        enableErrorText: true,
                        readOnly: true,
                        text: '',
                      ),
                      HexagonTextField(
                        margin: EdgeInsets.only(top: 10),
                        icon: Icon(Icons.person),
                        hintText: AllServices().databaseService.getUser().username != null ? AllServices().databaseService.getUser().username : "",
                        errorText: null,
                        enableErrorText: true,
                        readOnly: true,
                        text: '',
                      ),
                    ],
                  ),
                ),
              ),
              SideMenu(
                marginRight: 240,
                visible: state is ChangeOptionsCustomerHomeState,
                sideMenuButtons: <Widget>[
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_personal_data"),
                    onTap: () {
                      _customerHomeBloc.add(GoToChangePersonalDataCustomerHomeEvent());
                    },
                  ),
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_password"),
                    onTap: () {
                      _customerHomeBloc.add(GoToChangePasswordCustomerHomeEvent());
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
    _customerHomeBloc.close();
    super.dispose();
  }
}
