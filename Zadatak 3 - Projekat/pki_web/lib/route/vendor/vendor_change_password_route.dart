import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/vendor/vendor_change_password/bloc.dart';
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

class VendorChangePasswordRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VendorChangePasswordBloc(context),
      child: _VendorChangePasswordStatefulWidget(),
    );
  }
}

class _VendorChangePasswordStatefulWidget extends StatefulWidget {
  _VendorChangePasswordStatefulWidgetState createState() => _VendorChangePasswordStatefulWidgetState();
}

class _VendorChangePasswordStatefulWidgetState extends State<_VendorChangePasswordStatefulWidget> {
  VendorChangePasswordBloc _vendorChangePasswordBloc;
  String password = "";


  @override
  void initState() {
    _vendorChangePasswordBloc = BlocProvider.of<VendorChangePasswordBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _vendorChangePasswordBloc,
      builder: (BuildContext context, VendorChangePasswordState state) {
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
                                _vendorChangePasswordBloc.add(AllOrdersVendorChangePasswordEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_add_product"),
                              icon: Icon(Icons.add_circle),
                              padding: 35,
                              width: 80,
                              onPressed: () {
                                _vendorChangePasswordBloc.add(AddProductVendorChangePasswordEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_change_data"),
                              icon: Icon(Icons.create_rounded),
                              width: 180,
                              onPressed: () {
                                if (state is InitialVendorChangePasswordState) {
                                  _vendorChangePasswordBloc.add(ChangeOptionsVendorChangePasswordEvent());
                                } else {
                                  _vendorChangePasswordBloc.add(InitialOptionsVendorChangePasswordEvent());
                                }
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_logout"),
                              icon: Icon(Icons.logout),
                              width: 120,
                              onPressed: () {
                                _vendorChangePasswordBloc.add(LogoutVendorChangePasswordEvent());
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
                    margin: EdgeInsets.only(bottom: margin),
                    padding: EdgeInsets.only(top: margin_larger),
                    heightPercent: 0.25,
                    children: [
                      HexagonTextField(
                        icon: Icon(Icons.lock),
                        hintText: "Unesite novu lozinku",
//                        hintText: AppLocalizations.of(context).translate("customer_change_password_route_enter_new_password"),
                        enableErrorText: state.enableErrorText,
                        errorText: AppLocalizations.of(context).translate("register_route_insert_password"),
                        text: password,
                        obscureText: true,
                        onChanged: (text) {
                          password = text;
                        },
                      ),
                      HexagonButton(
                        text: AppLocalizations.of(context).translate("customer_change_data_route_save_data"),
                        onPressed: () {
                          _vendorChangePasswordBloc.add(SaveVendorChangePasswordEvent(password));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SideMenu(
                marginRight: 240,
                visible: state is ChangeOptionsVendorChangePasswordState,
                sideMenuButtons: <Widget>[
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_personal_data"),
                    onTap: () {
                      _vendorChangePasswordBloc.add(GoToChangePersonalDataVendorChangePasswordEvent());
                    },
                  ),
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_password"),
                    onTap: () {
                      _vendorChangePasswordBloc.add(GoToChangePasswordVendorChangePasswordEvent());
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
    _vendorChangePasswordBloc.close();
    super.dispose();
  }
}
