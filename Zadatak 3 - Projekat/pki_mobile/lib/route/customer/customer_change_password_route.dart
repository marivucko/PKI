import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/customer/customer_change_password/bloc.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/widgets/background_widget.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_button.dart';
import 'package:starter_pack/resources/widgets/card_container.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_read_only_text_field.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_text_field.dart';
import 'package:starter_pack/services/all_services.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerChangePasswordRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerChangePasswordBloc(context),
      child: _CustomerChangePasswordStatefulWidget(),
    );
  }
}

class _CustomerChangePasswordStatefulWidget extends StatefulWidget {
  _CustomerChangePasswordStatefulWidgetState createState() => _CustomerChangePasswordStatefulWidgetState();
}

class _CustomerChangePasswordStatefulWidgetState extends State<_CustomerChangePasswordStatefulWidget> {
  CustomerChangePasswordBloc _customerChangePasswordBloc;

  String password = "";

  @override
  void initState() {
    _customerChangePasswordBloc = BlocProvider.of<CustomerChangePasswordBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AllServices().designService.setTransparentStatusAndNavigationBar();

    List<String> choices = <String>[
      AppLocalizations.of(context).translate("menu_all_products"),
      AppLocalizations.of(context).translate("menu_view_profile"),
      AppLocalizations.of(context).translate("menu_change_profile_data"),
      AppLocalizations.of(context).translate("menu_change_password"),
      AppLocalizations.of(context).translate("menu_logout"),
    ];

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
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                PopupMenuButton(
                  onSelected: (String value) {
                    _customerChangePasswordBloc.add(NavigateCustomerChangePasswordEvent(value));
                  },
                  icon: Icon(
                    Icons.menu,
                    color: color_black,
                    size: 36,
                  ),
                  color: color_black,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context) {
                    return choices.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Container(
                          margin: EdgeInsets.only(top: 4),
                          padding: EdgeInsets.only(bottom: 4),
                          width: MediaQuery.of(context).size.width,
                          child: AutoSizeText(
                            choice.toUpperCase(),
                            style: TextStyle(
                              color: color_dots,
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: color_dots,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList();
                  },
                )
              ],
            ),
            body: SafeArea(
              child: BlocBuilder(
                bloc: _customerChangePasswordBloc,
                builder: (BuildContext context, CustomerChangePasswordState state) {
                  return Stack(
                    children: <Widget>[
                      CardContainer(
                        heightPerCent: 0.56,
                        setHeight: true,
                        height: 440,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              bottom: margin_xXlarge,
                            ),
                            padding: EdgeInsets.only(
                              left: main_route_left_right_padding,
                              right: main_route_left_right_padding,
                            ),
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          HexagonTextField(
                            icon: Icon(Icons.lock),
                            hintText: AppLocalizations.of(context).translate("customer_change_password_route_enter_new_password"),
                            enableErrorText: state.enableErrorText,
                            errorText: AppLocalizations.of(context).translate("register_route_insert_password"),
                            text: password,
                            obscureText: true,
                            onChanged: (text) {
                              password = text;
                            },
                          ),
                          HexagonButton(
                            text: AppLocalizations.of(context).translate("customer_change_password_route_save"),
                            onPressed: () {
                              _customerChangePasswordBloc.add(SaveCustomerChangePasswordEvent(password));
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            floatingActionButton: new FloatingActionButton(
              elevation: 0.0,
              child: new Icon(Icons.shopping_basket),
              backgroundColor: color_floating_action_bar_color,
              onPressed: () {
                _customerChangePasswordBloc.add(BasketCustomerChangePasswordEvent());
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _customerChangePasswordBloc.close();
    super.dispose();
  }
}
