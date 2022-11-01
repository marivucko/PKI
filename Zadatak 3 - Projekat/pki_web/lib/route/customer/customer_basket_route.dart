import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/customer/customer_basket/bloc.dart';
import 'package:starter_pack/resources/values/dimen.dart';
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
    return BlocBuilder(
      bloc: _customerBasketBloc,
      builder: (BuildContext context, CustomerBasketState state) {
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
                              text: AppLocalizations.of(context).translate("app_bar_products_list"),
                              icon: Icon(Icons.list),
                              onPressed: () {
                                _customerBasketBloc.add(ProductsCustomerBasketEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_basket"),
                              icon: Icon(Icons.shopping_basket),
                              padding: 35,
                              width: 80,
                              onPressed: () {
                                _customerBasketBloc.add(BasketCustomerBasketEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_change_data"),
                              icon: Icon(Icons.create_rounded),
                              width: 180,
                              onPressed: () {
                                if (state is InitialCustomerBasketState) {
                                  _customerBasketBloc.add(ChangeOptionsCustomerBasketEvent());
                                } else {
                                  _customerBasketBloc.add(InitialOptionsCustomerBasketEvent());
                                }
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_logout"),
                              icon: Icon(Icons.logout),
                              width: 120,
                              onPressed: () {
                                _customerBasketBloc.add(LogoutCustomerBasketEvent());
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
                    heightPercent: 0.50,
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
                        ),                      DataTable(
                        showBottomBorder: true,
                        dataRowHeight: 50,
                        dividerThickness: 2,
                        columnSpacing: 2,
                        columns: [
                          DataColumn(label: StyledText(text: "")),
                          DataColumn(label: StyledText(text: "Proizvod", width: 125)),
                          DataColumn(label: StyledText(text: "Cena", width: 125)),
                          DataColumn(label: StyledText(text: "Količina", width: 125)),
                          DataColumn(label: StyledText(text: "Cena * Količina", width: 125)),
                        ],
                        rows: AllServices().databaseService.basket.orderItemList.map((event) => DataRow(
                          cells: [
                            DataCell(StyledText(text: "${i++}")),
                            DataCell(StyledText(text: event.product.name, width: 125)),
                            DataCell(StyledText(text: event.product.price.toString(), width: 125)),
                            DataCell(StyledText(text: event.quantity.toString(), width: 125)),
                            DataCell(StyledText(text: (event.product.price * event.quantity).toString(), width: 125)),
                          ],
                        )).toList(),
                      ),
                      Container(margin: EdgeInsets.only(top: 20),),
                      Center(
                        child: StyledText(
                          text: "Ukupno: ${AllServices().databaseService.basket.totalPrice.toString()}",
                          width: double.infinity,
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
              SideMenu(
                marginRight: 240,
                visible: state is ChangeOptionsCustomerBasketState,
                sideMenuButtons: <Widget>[
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_personal_data"),
                    onTap: () {
                      _customerBasketBloc.add(GoToChangePersonalDataCustomerBasketEvent());
                    },
                  ),
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_password"),
                    onTap: () {
                      _customerBasketBloc.add(GoToChangePasswordCustomerBasketEvent());
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
    _customerBasketBloc.close();
    super.dispose();
  }
}
