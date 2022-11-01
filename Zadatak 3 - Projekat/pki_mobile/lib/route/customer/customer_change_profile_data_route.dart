import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/customer/customer_change_profile_data/bloc.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/widgets/background_widget.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_button.dart';
import 'package:starter_pack/resources/widgets/card_container.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_read_only_text_field.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_text_field.dart';
import 'package:starter_pack/services/all_services.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerChangeProfileDataRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerChangeProfileDataBloc(context),
      child: _CustomerChangeProfileDataStatefulWidget(),
    );
  }
}

class _CustomerChangeProfileDataStatefulWidget extends StatefulWidget {
  _CustomerChangeProfileDataStatefulWidgetState createState() => _CustomerChangeProfileDataStatefulWidgetState();
}

class _CustomerChangeProfileDataStatefulWidgetState extends State<_CustomerChangeProfileDataStatefulWidget> {
  CustomerChangeProfileDataBloc _customerChangeProfileDataBloc;

  String name = AllServices().databaseService.getUser().name != null ? AllServices().databaseService.getUser().name : "";
  String surname = AllServices().databaseService.getUser().surname != null ? AllServices().databaseService.getUser().surname : "";
  String address = AllServices().databaseService.getUser().address != null ? AllServices().databaseService.getUser().address : "";
  String phone = AllServices().databaseService.getUser().phone != null ? AllServices().databaseService.getUser().phone : "";

  @override
  void initState() {
    _customerChangeProfileDataBloc = BlocProvider.of<CustomerChangeProfileDataBloc>(context);
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
                    _customerChangeProfileDataBloc.add(NavigateCustomerChangeProfileDataEvent(value));
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
                bloc: _customerChangeProfileDataBloc,
                builder: (BuildContext context, CustomerChangeProfileDataState state) {
                  return Stack(
                    children: <Widget>[
                      CardContainer(
                        heightPerCent: 0.86,
                        borderRadius: 15,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: main_route_left_right_padding,
                              right: main_route_left_right_padding,
                            ),
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          HexagonTextField(
                            margin: EdgeInsets.only(top: 12),
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
                            margin: EdgeInsets.only(top: 12),
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
                            margin: EdgeInsets.only(top: 12),
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
                            margin: EdgeInsets.only(top: 12),
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
                              _customerChangeProfileDataBloc.add(SaveCustomerChangeProfileDataEvent(name, surname, address, phone));
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
                _customerChangeProfileDataBloc.add(BasketCustomerChangeProfileDataEvent());
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _customerChangeProfileDataBloc.close();
    super.dispose();
  }
}
