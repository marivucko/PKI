import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/customer/customer_profile/bloc.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/widgets/background_widget.dart';
import 'package:starter_pack/resources/widgets/card_container.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_read_only_text_field.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_text_field.dart';
import 'package:starter_pack/services/all_services.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerProfileRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerProfileBloc(context),
      child: _CustomerProfileStatefulWidget(),
    );
  }
}

class _CustomerProfileStatefulWidget extends StatefulWidget {
  _CustomerProfileStatefulWidgetState createState() => _CustomerProfileStatefulWidgetState();
}

class _CustomerProfileStatefulWidgetState extends State<_CustomerProfileStatefulWidget> {
  CustomerProfileBloc _customerProfileBloc;

  @override
  void initState() {
    _customerProfileBloc = BlocProvider.of<CustomerProfileBloc>(context);
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
                    _customerProfileBloc.add(NavigateCustomerProfileEvent(value));
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
                bloc: _customerProfileBloc,
                builder: (BuildContext context, CustomerProfileState state) {
                  return Stack(
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: main_route_left_right_padding,
                              right: main_route_left_right_padding,
                            ),
                            child: Center(
                              child: Image.asset('assets/images/logo.png'),
                            ),
                          ),
                          CardContainer(
                            heightPerCent: 0.6,
                            setHeight: true,
                            height: 400,
                            borderRadius: 15,
                            margin: EdgeInsets.only(
                              top: margin_xXXlarge,
                            ),
                            children: [
                              HexagonReadOnlyTextField(
                                margin: EdgeInsets.only(top: 12),
                                icon: Icon(Icons.portrait),
                                hintText: AppLocalizations.of(context).translate("register_route_name"),
                                text: AllServices().databaseService.getUser().name != null ? AllServices().databaseService.getUser().name : "",
                              ),
                              HexagonReadOnlyTextField(
                                margin: EdgeInsets.only(top: 12),
                                icon: Icon(Icons.account_box),
                                hintText: AppLocalizations.of(context).translate("register_route_name"),
                                text: AllServices().databaseService.getUser().surname != null ? AllServices().databaseService.getUser().surname : "",
                              ),
                              HexagonReadOnlyTextField(
                                margin: EdgeInsets.only(top: 12),
                                icon: Icon(Icons.location_on),
                                hintText: AppLocalizations.of(context).translate("register_route_name"),
                                text: AllServices().databaseService.getUser().address != null ? AllServices().databaseService.getUser().address : "",
                              ),
                              HexagonReadOnlyTextField(
                                margin: EdgeInsets.only(top: 12),
                                icon: Icon(Icons.phone),
                                hintText: AppLocalizations.of(context).translate("register_route_name"),
                                text: AllServices().databaseService.getUser().phone != null ? AllServices().databaseService.getUser().phone : "",
                              ),
                              HexagonReadOnlyTextField(
                                margin: EdgeInsets.only(top: 12, bottom: 5),
                                icon: Icon(Icons.person),
                                hintText: AppLocalizations.of(context).translate("register_route_name"),
                                text: AllServices().databaseService.getUser().username != null ? AllServices().databaseService.getUser().username : "",
                              ),
                            ],
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
                  _customerProfileBloc.add(BasketCustomerProfileEvent());
                }),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _customerProfileBloc.close();
    super.dispose();
  }
}
