import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';

class AppBarBack extends StatelessWidget {
  AppBarBack();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          SystemNavigator.pop();
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: margin_large, bottom: margin_large),
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Icon(
              Icons.arrow_back,
              color: color_black,
              //size: icon_size_small,
            ),
            Container(
              margin: EdgeInsets.only(left: margin_small),
              child: AutoSizeText(
                AppLocalizations.of(context).translate("back_button_text"),
                style: GoogleFonts.pacifico(
                  color: color_black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
