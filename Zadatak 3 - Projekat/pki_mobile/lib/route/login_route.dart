import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/login/bloc.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/widgets/app_bar_back.dart';
import 'package:starter_pack/resources/widgets/background_widget.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_button.dart';
import 'package:starter_pack/resources/widgets/card_container.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_text_field.dart';
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

  String username = "";
  String password = "";

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AllServices().designService.setTransparentStatusAndNavigationBar();
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
              title: AppBarBack(),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SafeArea(
              child: BlocBuilder(
                bloc: _loginBloc,
                builder: (BuildContext context, LoginState state) {
                  return Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: CardContainer(
                          heightPerCent: 0.4,
                          setHeight: true,
                          height: 340,
                          children: [
                            HexagonTextField(
                              margin: EdgeInsets.only(top: 15),
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
                              margin: EdgeInsets.only(top: 10, bottom: 10),
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
                            HexagonButton(
                              text: AppLocalizations.of(context).translate("main_route_login_button"),
                              onPressed: () {
                                _loginBloc.add(LoginLoginEvent(username, password));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
//                  )]);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }
}
