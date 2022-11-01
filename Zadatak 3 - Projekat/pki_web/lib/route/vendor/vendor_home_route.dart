import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/vendor/vendor_home/bloc.dart';
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

class VendorHomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VendorHomeBloc(context),
      child: _VendorHomeStatefulWidget(),
    );
  }
}

class _VendorHomeStatefulWidget extends StatefulWidget {
  _VendorHomeStatefulWidgetState createState() => _VendorHomeStatefulWidgetState();
}

class _VendorHomeStatefulWidgetState extends State<_VendorHomeStatefulWidget> {
  VendorHomeBloc _VendorHomeBloc;
  int selectedRadio;
  String name = "";
  String surname = "";
  String address = "";
  String phone = "";
  String username = "";
  String password = "";

  @override
  void initState() {
    _VendorHomeBloc = BlocProvider.of<VendorHomeBloc>(context);
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
      bloc: _VendorHomeBloc,
      builder: (BuildContext context, VendorHomeState state) {
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
                              text: AppLocalizations.of(context).translate("app_bar_orders"),
                              icon: Icon(Icons.list),
                              width: 100,
                              onPressed: () {
                                _VendorHomeBloc.add(AllOrdersVendorHomeEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_add_product"),
                              icon: Icon(Icons.add_circle),
                              padding: 35,
                              width: 80,
                              onPressed: () {
                                _VendorHomeBloc.add(AddProductVendorHomeEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_change_data"),
                              icon: Icon(Icons.create_rounded),
                              width: 180,
                              onPressed: () {
                                if (state is InitialVendorHomeState) {
                                  _VendorHomeBloc.add(ChangeOptionsVendorHomeEvent());
                                } else {
                                  _VendorHomeBloc.add(InitialOptionsVendorHomeEvent());
                                }
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_logout"),
                              icon: Icon(Icons.logout),
                              width: 120,
                              onPressed: () {
                                _VendorHomeBloc.add(LogoutVendorHomeEvent());
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
                visible: state is ChangeOptionsVendorHomeState,
                sideMenuButtons: <Widget>[
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_personal_data"),
                    onTap: () {
                      _VendorHomeBloc.add(GoToChangePersonalDataVendorHomeEvent());
                    },
                  ),
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_password"),
                    onTap: () {
                      _VendorHomeBloc.add(GoToChangePasswordVendorHomeEvent());
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
    _VendorHomeBloc.close();
    super.dispose();
  }
}
