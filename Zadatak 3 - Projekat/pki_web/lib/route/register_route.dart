import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/register/bloc.dart';
import 'package:starter_pack/data/beans/user.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/widgets/buttons/main_route_button.dart';
import 'package:starter_pack/resources/widgets/icon_text_container.dart';
import 'package:starter_pack/resources/widgets/icon_text_field.dart';
import 'package:starter_pack/resources/widgets/buttons/side_menu_button.dart';
import 'package:starter_pack/resources/widgets/side_menu.dart';
import 'package:starter_pack/resources/widgets/card_container.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_text_field.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_radio_buttons.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_button.dart';
import 'package:starter_pack/resources/widgets/frame.dart';
import 'package:starter_pack/services/all_services.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(context),
      child: _RegisterStatefulWidget(),
    );
  }
}

class _RegisterStatefulWidget extends StatefulWidget {
  _RegisterStatefulWidgetState createState() => _RegisterStatefulWidgetState();
}

class _RegisterStatefulWidgetState extends State<_RegisterStatefulWidget> {
  RegisterBloc _registerBloc;
  int selectedRadio;
  String name = "";
  String surname = "";
  String address = "";
  String phone = "";
  String username = "";
  String password = "";

  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
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
      bloc: _registerBloc,
      builder: (BuildContext context, RegisterState state) {
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
                        width: 320,
                        child: Row(
                          children: [
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_home"),
                              icon: Icon(Icons.home),
                              onPressed: () {
                                _registerBloc.add(HomeRegisterEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_my_account"),
                              icon: Icon(Icons.account_circle_sharp),
                              onPressed: () {
                                if (state is InitialRegisterState) {
                                  _registerBloc.add(ProfileOptionsRegisterEvent());
                                } else {
                                  _registerBloc.add(InitialOptionsRegisterEvent());
                                }
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
                    margin: EdgeInsets.only(bottom: margin_xXlarge),
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
                      HexagonTextField(
                        icon: Icon(Icons.person),
                        hintText: AppLocalizations.of(context).translate("register_route_username"),
                        enableErrorText: state.enableErrorText,
                        errorText: AppLocalizations.of(context).translate("register_route_insert_username"),
                        text: username,
                        onChanged: (text) {
                          username = text;
                        },
                      ),
                      HexagonTextField(
                        icon: Icon(Icons.lock),
                        hintText: AppLocalizations.of(context).translate("register_route_password"),
                        enableErrorText: state.enableErrorText,
                        errorText: AppLocalizations.of(context).translate("register_route_insert_password"),
                        obscureText: true,
                        text: password,
                        onChanged: (text) {
                          password = text;
                        },
                      ),
                      HexagonRadioButtons(
                        groupValue: state.selectedRadio,
                        onChangedFirst: () {
                          _registerBloc.add(SetCustomerRegisterEvent());
                        },
                        onChangedSecond: () {
                          _registerBloc.add(SetVendorRegisterEvent());
                        },
                      ),
                      HexagonButton(
                        text: AppLocalizations.of(context).translate("register_route_register"),
                        onPressed: () {
                          _registerBloc.add(RegisterRegisterEvent(name, surname, address, phone, username, password));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SideMenu(
                visible: state is ProfileOptionsRegisterState,
                sideMenuButtons: <Widget>[
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_login"),
                    onTap: () {
                      _registerBloc.add(GoToLoginRegisterEvent());
                    },
                  ),
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_register"),
                    onTap: () {
                      _registerBloc.add(GoToRegisterRegisterEvent());
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
    _registerBloc.close();
    super.dispose();
  }
}
