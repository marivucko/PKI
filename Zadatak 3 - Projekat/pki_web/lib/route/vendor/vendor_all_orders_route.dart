import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/vendor/vendor_all_orders/bloc.dart';
import 'package:starter_pack/data/beans/order.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/widgets/buttons/table_button.dart';
import 'package:starter_pack/resources/widgets/icon_text_field.dart';
import 'package:starter_pack/resources/widgets/buttons/side_menu_button.dart';
import 'package:starter_pack/resources/widgets/side_menu.dart';
import 'package:starter_pack/resources/widgets/card_container.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_text_field.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_radio_buttons.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_button.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/widgets/styled_text.dart';
import 'package:starter_pack/services/all_services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorAllOrdersRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VendorAllOrdersBloc(context),
      child: _VendorAllOrdersStatefulWidget(),
    );
  }
}

class _VendorAllOrdersStatefulWidget extends StatefulWidget {
  _VendorAllOrdersStatefulWidgetState createState() => _VendorAllOrdersStatefulWidgetState();
}

class _VendorAllOrdersStatefulWidgetState extends State<_VendorAllOrdersStatefulWidget> {
  VendorAllOrdersBloc _vendorAllOrdersBloc;
  int i = 1;

  @override
  void initState() {
    _vendorAllOrdersBloc = BlocProvider.of<VendorAllOrdersBloc>(context);
    _vendorAllOrdersBloc.add(InitializeVendorAllOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _vendorAllOrdersBloc,
      builder: (BuildContext context, VendorAllOrdersState state) {
        i = 1;
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
                                _vendorAllOrdersBloc.add(AllOrdersVendorAllOrdersEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_add_product"),
                              icon: Icon(Icons.add_circle),
                              padding: 35,
                              width: 80,
                              onPressed: () {
                                _vendorAllOrdersBloc.add(AddProductVendorAllOrdersEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_change_data"),
                              icon: Icon(Icons.create_rounded),
                              width: 180,
                              onPressed: () {
                                if (state is InitialVendorAllOrdersState) {
                                  _vendorAllOrdersBloc.add(ChangeOptionsVendorAllOrdersEvent());
                                } else {
                                  _vendorAllOrdersBloc.add(InitialOptionsVendorAllOrdersEvent());
                                }
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_logout"),
                              icon: Icon(Icons.logout),
                              width: 120,
                              onPressed: () {
                                _vendorAllOrdersBloc.add(LogoutVendorAllOrdersEvent());
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
                    margin: EdgeInsets.only(bottom: margin, left: margin_small, right: margin_small),
                    padding: EdgeInsets.only(top: margin_larger),
                    heightPercent: 0.75,
                    children: [
                      Center(
                        child: AutoSizeText(
                          "Narudžbine",
                          minFontSize: 24,
                          style: GoogleFonts.pacifico(
                            color: color_black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(height: 50),
                      DataTable(
                        dataRowHeight: 50,
                        dividerThickness: 2,
                        columnSpacing: 2,
                        columns: [
                          DataColumn(label: StyledText(text: "")),
                          DataColumn(label: StyledText(text: "Kupac")),
                          DataColumn(label: StyledText(text: "Cena")),
                          DataColumn(label: StyledText(text: "Status")),
                          DataColumn(label: StyledText(text: "Odobri")),
                          DataColumn(label: StyledText(text: "Odbij")),
                        ],
                        rows: state is RefreshVendorAllOrdersState ? [] : state.orders.map((event) => DataRow(
                          cells: [
                            DataCell(StyledText(text: "${i++}")),
                            DataCell(StyledText(text: event.username)),
                            DataCell(StyledText(text: event.price.toString())),
                            DataCell(
                              StyledText(
                                text: event.status == Order.ORDER_NOT_PROCESSED
                                ? "Neobradjeno"
                                : event.status == Order.ORDER_ALLOWED
                                  ? "Odobreno"
                                  : "Odbijeno",
                                color: event.status == Order.ORDER_NOT_PROCESSED
                                ? color_black
                                : event.status == Order.ORDER_ALLOWED
                                  ? color_green
                                  : color_red,
                              ),
                            ),
                            DataCell(
                              event.status == Order.ORDER_NOT_PROCESSED
                              ? TableButton(
                                text: "Odobri",
                                onTap: (){
                                  _vendorAllOrdersBloc.add(OpenDialogToAllowOrderVendorAllOrdersEvent(event));
                                },
                              ):
                              Container(),
                            ),
                            DataCell(
                              event.status == Order.ORDER_NOT_PROCESSED
                              ? TableButton(
                                text: "Odbij",
                                onTap: (){
                                  _vendorAllOrdersBloc.add(DeclineOrderAllOrdersEvent(event));
                                },
                              ):
                              Container(),
                            ),
                          ],
                        )).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              SideMenu(
                marginRight: 240,
                visible: state is ChangeOptionsVendorAllOrdersState,
                sideMenuButtons: <Widget>[
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_personal_data"),
                    onTap: () {
                      _vendorAllOrdersBloc.add(GoToChangePersonalDataVendorAllOrdersEvent());
                    },
                  ),
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_password"),
                    onTap: () {
                      _vendorAllOrdersBloc.add(GoToChangePasswordVendorAllOrdersEvent());
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
    _vendorAllOrdersBloc.close();
    super.dispose();
  }
}
