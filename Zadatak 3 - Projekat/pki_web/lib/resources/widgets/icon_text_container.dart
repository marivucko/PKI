import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';

class IconTextContainer extends StatelessWidget {
  final String firstLineText;
  final String secondLineText;
  final IconData iconData;
  final double margin;

  const IconTextContainer({
    Key key,
    @required this.firstLineText,
    @required this.secondLineText,
    @required this.iconData,
    this.margin = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 80,
        right: 80,
      ),
      height: 75,
      width: 280,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          color: color_white,
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: padding_custom_large + margin, right: margin_medium),
            height: 45,
            width: 45,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Icon(
                iconData,
                color: color_white,
              ),
            ),
          ),
          Container(
            height: 45,
            width: 180,
            margin: EdgeInsets.only(left: margin_small + margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 22.5,
                  width: 180,
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: firstLineText,
                      hintStyle: GoogleFonts.pacifico(
                        fontSize: 15,
                        color: color_white,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 22.5,
                  width: 180,
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: secondLineText,
                      hintStyle: GoogleFonts.pacifico(
                        fontSize: 15,
                        color: color_white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
