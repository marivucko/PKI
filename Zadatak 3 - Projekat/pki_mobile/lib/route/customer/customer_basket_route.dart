import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/customer/customer_Basket/bloc.dart';
import 'package:starter_pack/resources/widgets/background_widget.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_button.dart';
import 'package:starter_pack/resources/widgets/card_container.dart';
import 'package:starter_pack/resources/widgets/styled_text.dart';
import 'package:starter_pack/services/all_services.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerBasketRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerBasketBloc(context),
      child: _CustomerBasketStatefulWidget(),
    );
  }
}

class _CustomerBasketStatefulWidget extends StatefulWidget {
  _CustomerBasketStatefulWidgetState createState() => _CustomerBasketStatefulWidgetState();
}

class _CustomerBasketStatefulWidgetState extends State<_CustomerBasketStatefulWidget> {
  CustomerBasketBloc _customerBasketBloc;

  int i = 1;

  @override
  void initState() {
    _customerBasketBloc = BlocProvider.of<CustomerBasketBloc>(context);
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
                    _customerBasketBloc.add(NavigateCustomerBasketEvent(value));
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
                bloc: _customerBasketBloc,
                builder: (BuildContext context, CustomerBasketState state) {
                  i = 1;
                  return Stack(
                    children: <Widget>[
                      Align(
                        alignment: FractionalOffset.center,
                        child: Container(
                          child: CardContainer(
                            children:AllServices().databaseService.basket.orderItemList.length > 0
                            ? [
                                Container(
                                  margin: EdgeInsets.only(top: 30, bottom: 30),
                                  child: Center(
                                    child: AutoSizeText(
                                      "Sadržaj vaše korpe",
                                      minFontSize: 24,
                                      style: GoogleFonts.pacifico(
                                        color: color_black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              DataTable(
                                showBottomBorder: true,
                                dataRowHeight: 50,
                                dividerThickness: 2,
                                columnSpacing: 2,
                                columns: [
                                  DataColumn(label: StyledText(text: "", widthFraction: 9)),
                                  DataColumn(label: StyledText(text: "Proizvod")),
                                  DataColumn(label: StyledText(text: "Cena")),
                                  DataColumn(label: StyledText(text: "Kol")),
                                  DataColumn(label: StyledText(text: "Cena * Kol", widthFraction: 5)),
                                ],
                                rows: AllServices().databaseService.basket.orderItemList.map((event) => DataRow(
                                  cells: [
                                    DataCell(StyledText(text: "${i++}", widthFraction: 9)),
                                    DataCell(StyledText(text: event.product.name)),
                                    DataCell(StyledText(text: event.product.price.toString())),
                                    DataCell(StyledText(text: event.quantity.toString())),
                                    DataCell(StyledText(text: (event.product.price * event.quantity).toString(), widthFraction: 5)),
                                  ],
                                )).toList(),
                              ),
                              Container(margin: EdgeInsets.only(top: 20),),
                              Center(
                                child: StyledText(
                                  text: "Ukupno: ${AllServices().databaseService.basket.totalPrice.toString()}",
                                  widthFraction: 2,
                                )
                              ),
                              Container(margin: EdgeInsets.only(top: 20),),
                              HexagonButton(
                                text: "Naručite",
                                onPressed: () {
                                  _customerBasketBloc.add(OrderCustomerBasketEvent());
                                },
                              ),
                            ]
                            : [
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Center(
                                  child: AutoSizeText(
                                    "Korpa je prazna",
                                    minFontSize: 24,
                                    style: GoogleFonts.pacifico(
                                      color: color_black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _customerBasketBloc.close();
    super.dispose();
  }
}
