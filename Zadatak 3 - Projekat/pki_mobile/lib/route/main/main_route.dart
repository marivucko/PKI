import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/main/main_bloc.dart';
import 'package:starter_pack/resources/core/internet_scaffold.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/widgets/background_widget.dart';
import 'package:starter_pack/resources/widgets/buttons/main_route_button.dart';
import 'package:starter_pack/services/all_services.dart';

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
              //title: AppBarBack(),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SafeArea(
              child: BlocBuilder(
                bloc: _mainBloc,
                builder: (BuildContext context, MainState state) {
                  return Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: margin_xXXlarge,
                            ),
                            padding: EdgeInsets.only(
                              left: main_route_left_right_padding,
                              right: main_route_left_right_padding,
                            ),
                            child: Center(
                              child: Image.asset('assets/images/logo.png'),
                            ),
                          ),
                          Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).translate("main_route_text"),
                              maxFontSize: main_route_main_text,
                              style: GoogleFonts.pacifico(
                                fontSize: main_route_main_text,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: padding_custom_large,
                              bottom: padding_custom_large,
                              left: padding_medium,
                              right: padding_medium,
                            ),
                            margin: EdgeInsets.only(
                              top: margin_larger,
                              bottom: padding_xlarge,
                              left: margin_larger,
                              right: margin_larger,
                            ),
                            decoration: BoxDecoration(
                              color: color_yellow_light,
                              borderRadius: BorderRadius.all(
                                Radius.circular(35),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MainRouteButton(
                                  buttonText: AppLocalizations.of(context).translate("main_route_login_button"),
                                  onTap: () {
                                    _mainBloc.add(LoginMainEvent());
                                  },
                                ),
                                MainRouteButton(
                                  buttonText: AppLocalizations.of(context).translate("main_route_register_button"),
                                  onTap: () {
                                    _mainBloc.add(RegisterMainEvent());
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mainBloc.close();
    super.dispose();
  }
}
