import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/login/bloc.dart';
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

class LoginRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(context),
      child: _LoginStatefulWidget(),
    );
  }
}

class _LoginStatefulWidget extends StatefulWidget {
  _LoginStatefulWidgetState createState() => _LoginStatefulWidgetState();
}

class _LoginStatefulWidgetState extends State<_LoginStatefulWidget> {
  LoginBloc _loginBloc;
  int selectedRadio;
  String name = "";
  String surname = "";
  String address = "";
  String phone = "";
  String username = "";
  String password = "";

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
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
      bloc: _loginBloc,
      builder: (BuildContext context, LoginState state) {
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
                                _loginBloc.add(HomeLoginEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_my_account"),
                              icon: Icon(Icons.account_circle_sharp),
                              onPressed: () {
                                if (state is InitialLoginState) {
                                  _loginBloc.add(ProfileOptionsLoginEvent());
                                } else {
                                  _loginBloc.add(InitialOptionsLoginEvent());
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
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
                  child: CardContainer(
                    heightPercent: 0.28,
                    margin: EdgeInsets.only(bottom: margin),
                    padding: EdgeInsets.only(top: margin),
                    children: [
                      HexagonTextField(
                        icon: Icon(Icons.person),
                        hintText: AppLocalizations.of(context).translate("login_route_username"),
                        enableErrorText: state.enableErrorText,
                        errorText: AppLocalizations.of(context).translate("login_route_insert_username"),
                        text: username,
                        onChanged: (text) {
                          username = text;
                        },
                      ),
                      HexagonTextField(
                        icon: Icon(Icons.lock),
                        hintText: AppLocalizations.of(context).translate("login_route_password"),
                        enableErrorText: state.enableErrorText,
                        errorText: AppLocalizations.of(context).translate("login_route_insert_password"),
                        obscureText: true,
                        text: password,
                        onChanged: (text) {
                          password = text;
                        },
                      ),
                      HexagonButton(
                        text: AppLocalizations.of(context).translate("main_route_login_button"),
                        onPressed: () {
                          _loginBloc.add(LoginLoginEvent(username, password));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SideMenu(
                visible: state is ProfileOptionsLoginState,
                sideMenuButtons: <Widget>[
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_login"),
                    onTap: () {
                      _loginBloc.add(GoToLoginLoginEvent());
                    },
                  ),
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_register"),
                    onTap: () {
                      _loginBloc.add(GoToRegisterLoginEvent());
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
    _loginBloc.close();
    super.dispose();
  }
}
