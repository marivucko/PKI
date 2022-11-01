import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/register/bloc.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/widgets/app_bar_back.dart';
import 'package:starter_pack/resources/widgets/background_widget.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_button.dart';
import 'package:starter_pack/resources/widgets/card_container.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_text_field.dart';
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

  String name = "";
  String surname = "";
  String address = "";
  String phone = "";
  String username = "";
  String password = "";

  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
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
                bloc: _registerBloc,
                builder: (BuildContext context, RegisterState state) {
                  return Stack(
                    children: <Widget>[
                      CardContainer(
                        borderRadius: 15,
                        children: [
                          HexagonTextField(
                            margin: EdgeInsets.only(top: 15),
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
                            margin: EdgeInsets.only(top: 15),
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
                            margin: EdgeInsets.only(top: 15),
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
                            margin: EdgeInsets.only(top: 15),
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
                            margin: EdgeInsets.only(top: 15, bottom: 15),
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
                            text: AppLocalizations.of(context).translate("register_route_register"),
                            onPressed: () {
                              _registerBloc.add(RegisterRegisterEvent(name, surname, address, phone, username, password));
                            },
                          ),
                        ],
                      ),
                    ],
                  );
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
    _registerBloc.close();
    super.dispose();
  }
}
