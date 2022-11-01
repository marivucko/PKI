import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/main/main_bloc.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/widgets/buttons/main_route_button.dart';
import 'package:starter_pack/resources/widgets/icon_text_container.dart';
import 'package:starter_pack/resources/widgets/icon_text_field.dart';
import 'package:starter_pack/resources/widgets/buttons/side_menu_button.dart';
import 'package:starter_pack/resources/widgets/side_menu.dart';
import 'package:starter_pack/resources/widgets/frame.dart';
import 'package:starter_pack/services/all_services.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MainRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(context),
      child: _MainStatefulWidget(),
    );
  }
}

class _MainStatefulWidget extends StatefulWidget {
  _MainStatefulWidgetState createState() => _MainStatefulWidgetState();
}

class _MainStatefulWidgetState extends State<_MainStatefulWidget> {
  MainBloc _mainBloc;

  @override
  void initState() {
    _mainBloc = BlocProvider.of<MainBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _mainBloc,
      builder: (BuildContext context, MainState state) {
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
                              onPressed: () {},
                            ),
                            IconTextField(
                              text: AppLocalizations.of(context).translate("app_bar_my_account"),
                              icon: Icon(Icons.account_circle_sharp),
                              onPressed: () {
                                if (state is InitialMainState) {
                                  _mainBloc.add(ProfileOptionsMainEvent());
                                } else {
                                  _mainBloc.add(InitialOptionsMainEvent());
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
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
                  color: color_white,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: AutoSizeText(
                          "Dobrodošli!",
                          minFontSize: 48,
                          style: GoogleFonts.pacifico(
                            color: color_black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Frame(
                            child: Image.asset('assets/images/shop.png'),
                          ),
                          Frame(
                            topMargin: 45,
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 12,
                              enabled: false,
                              style: GoogleFonts.pacifico(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: color_black,
                              ),
                              textAlign: TextAlign.justify,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppLocalizations.of(context).translate("main_route_home_text"),
                                hintStyle: GoogleFonts.pacifico(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: color_black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SideMenu(
                visible: state is ProfileOptionsMainState,
                sideMenuButtons: <Widget>[
                  SideMenuButton(
                    buttonText: "LOGUJTE SE",
                    onTap: () {
                      _mainBloc.add(LoginMainEvent());
                    },
                  ),
                  SideMenuButton(
                    buttonText: "REGISTRUJTE SE",
                    onTap: () {
                      _mainBloc.add(RegisterMainEvent());
                    },
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: main_route_bottom_bar_green,
                      border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: main_route_bottom_bar_border,
                        ),
                      ),
                    ),
                    height: app_bar_height,
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconTextContainer(
                            firstLineText: "Adresa",
                            secondLineText: "Vojislava Ilića 24, Sombor",
                            iconData: Icons.location_on,
                          ),
                          IconTextContainer(
                            firstLineText: "Radno vreme",
                            secondLineText: "Radnim danima: 8-20h",
                            iconData: Icons.schedule,
                            margin: 7.5,
                          ),
                          IconTextContainer(
                            firstLineText: "Kontakt telefon",
                            secondLineText: "+381 64 29563200",
                            iconData: Icons.phone,
                            margin: 7.5,
                          ),
                          IconTextContainer(
                            firstLineText: "Elektronska pošta",
                            secondLineText: "info@medenjaci.com",
                            iconData: Icons.email,
                            margin: 7.5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _mainBloc.close();
    super.dispose();
  }
}
