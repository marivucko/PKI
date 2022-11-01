import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/splash/splash_bloc.dart';
import 'package:starter_pack/resources/core/internet_scaffold.dart';
import 'package:starter_pack/services/all_services.dart';

class SplashRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(context),
      child: _SplashStatefulWidget(),
    );
  }

}

class _SplashStatefulWidget extends StatefulWidget {
  _SplashStatefulWidgetState createState() => _SplashStatefulWidgetState();
}

class _SplashStatefulWidgetState extends State<_SplashStatefulWidget> {

  SplashBloc _splashBloc;

  @override
  void initState() {
    _splashBloc = BlocProvider.of<SplashBloc>(context);
    _splashBloc.add(new InitialSplashEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _splashBloc,
      builder: (BuildContext context, SplashState state) {
        return InternetScaffold(
          content: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: AutoSizeText(
              AppLocalizations.of(context).translate("splash_route_title")
            ),
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    _splashBloc.close();
    super.dispose();
  }

}