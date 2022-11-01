import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MainRouteButton extends StatelessWidget {
  final String buttonText;
  final Function onTap;

  const MainRouteButton({
    Key key,
    @required this.buttonText,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color_orange_top, color_orange_bottom],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          margin: EdgeInsets.only(
            left: margin,
            right: margin,
          ),
          child: Center(
            child: Expanded(
              child: AutoSizeText(
                buttonText,
                maxFontSize: 20,
                style: GoogleFonts.pacifico(
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
