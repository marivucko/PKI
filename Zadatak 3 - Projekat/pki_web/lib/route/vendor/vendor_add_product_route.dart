import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/vendor/vendor_add_product/bloc.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/widgets/icon_text_field.dart';
import 'package:starter_pack/resources/widgets/buttons/side_menu_button.dart';
import 'package:starter_pack/resources/widgets/one_line_rectangle_numeric_text_field.dart';
import 'package:starter_pack/resources/widgets/one_line_rectangle_text_field.dart';
import 'package:starter_pack/resources/widgets/rectangle_text_field.dart';
import 'package:starter_pack/resources/widgets/rounded_text_field.dart';
import 'package:starter_pack/resources/widgets/side_menu.dart';
import 'package:starter_pack/resources/widgets/card_container.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_text_field.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_radio_buttons.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_button.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/services/all_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class VendorAddProductRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VendorAddProductBloc(context),
      child: _VendorAddProductStatefulWidget(),
    );
  }
}

class _VendorAddProductStatefulWidget extends StatefulWidget {
  _VendorAddProductStatefulWidgetState createState() => _VendorAddProductStatefulWidgetState();
}

class _VendorAddProductStatefulWidgetState extends State<_VendorAddProductStatefulWidget> {
  VendorAddProductBloc _vendorAddProductBloc;
  String name = "";
  String price = "";
  String description = "";
  String manual = "";

  @override
  void initState() {
    _vendorAddProductBloc = BlocProvider.of<VendorAddProductBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _vendorAddProductBloc,
      builder: (BuildContext context, VendorAddProductState state) {
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
                                _vendorAddProductBloc.add(AllOrdersVendorAddProductEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_add_product"),
                              icon: Icon(Icons.add_circle),
                              padding: 35,
                              width: 80,
                              onPressed: () {
                                _vendorAddProductBloc.add(AddProductVendorAddProductEvent());
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_change_data"),
                              icon: Icon(Icons.create_rounded),
                              width: 180,
                              onPressed: () {
                                if (state is InitialVendorAddProductState) {
                                  _vendorAddProductBloc.add(ChangeOptionsVendorAddProductEvent());
                                } else {
                                  _vendorAddProductBloc.add(InitialOptionsVendorAddProductEvent());
                                }
                              },
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_logout"),
                              icon: Icon(Icons.logout),
                              width: 120,
                              onPressed: () {
                                _vendorAddProductBloc.add(LogoutVendorAddProductEvent());
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
                    heightPercent: 0.75,
                    borderRadius: 15,
                    margin: EdgeInsets.only(bottom: margin, left: margin_small, right: margin_small),
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: !state.insertedImage
                        ? DottedBorder(
                          color: Colors.black,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(15),
                          strokeWidth: 2,
                          dashPattern: [8, 4],
                          child: Container(
                              child: GestureDetector(
                            child: Container(
                              padding: EdgeInsets.only(top: 20, bottom: 20),
                              color: Colors.transparent,
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(Icons.add_circle_outline, size: 30),
                                    Container(
                                      margin: EdgeInsets.only(top: 10, bottom: 10),
                                    ),
                                    AutoSizeText(
                                      "Dodajte sliku proizvoda",
                                      minFontSize: 20,
                                      style: GoogleFonts.pacifico(
                                        color: color_black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              _vendorAddProductBloc.add(PickImageVendorAddProductEvent());
                            },
                          )),
                        )
                        : Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(Icons.check, size: 30),
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                ),
                                AutoSizeText(
                                  "Slika je dodata",
                                  minFontSize: 20,
                                  style: GoogleFonts.pacifico(
                                    color: color_black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //Icons.money
                      OneLineRectangleTextField(
                        icon: Icon(Icons.text_fields),
                        titleText: "Ime proizvoda",
                        hintText: "Ime proizvoda",
                        enableErrorText: state.enableErrorText,
                        errorText: "Unesite ime proizvoda",
                        minLines: 2,
                        maxLines: 12,
                        text: name,
                        onChanged: (text) {
                          name = text;
                        },
                      ),
                      OneLineRectangleNumericTextField(
                        icon: Icon(Icons.money),
                        titleText: "Cena",
                        hintText: "Cena proizvoda",
                        enableErrorText: state.enableErrorText,
                        errorText: "Unesite cenu proizvoda",
                        minLines: 2,
                        maxLines: 12,
                        text: price,
                        onChanged: (text) {
                          price = text;
                        },
                      ),
                      RectangleTextField(
                        icon: Icon(Icons.article),
                        titleText: "Opis proizvoda",
                        hintText: "Unesite opis proizvoda",
                        enableErrorText: state.enableErrorText,
                        errorText: "Unesite opis proizvoda",
                        minLines: 2,
                        maxLines: 12,
                        text: description,
                        onChanged: (text) {
                          description = text;
                        },
                      ),
                      RectangleTextField(
                        icon: Icon(Icons.library_books),
                        titleText: "Način korišćenja proizvoda",
                        hintText: "Unesite način korišćenja proizvoda",
                        enableErrorText: state.enableErrorText,
                        errorText: "Unesite način korišćenja proizvoda",
                        minLines: 2,
                        maxLines: 12,
                        text: manual,
                        onChanged: (text) {
                          manual = text;
                        },
                      ),
                      Container(),
                      HexagonButton(
//                        text: AppLocalizations.of(context).translate("vendor_add_product_route_save_data"),
                        text: "Sačuvajte",
                        onPressed: () {
                          _vendorAddProductBloc.add(SaveVendorAddProductEvent(name, price, description, manual));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SideMenu(
                marginRight: 240,
                visible: state is ChangeOptionsVendorAddProductState,
                sideMenuButtons: <Widget>[
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_personal_data"),
                    onTap: () {
                      _vendorAddProductBloc.add(GoToChangePersonalDataVendorAddProductEvent());
                    },
                  ),
                  SideMenuButton(
                    buttonText: AppLocalizations.of(context).translate("app_bar_change_password"),
                    onTap: () {
                      _vendorAddProductBloc.add(GoToChangePasswordVendorAddProductEvent());
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
    _vendorAddProductBloc.close();
    super.dispose();
  }
}
