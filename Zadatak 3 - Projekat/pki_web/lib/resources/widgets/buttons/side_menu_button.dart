import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starter_pack/resources/values/colors.dart';

class SideMenuButton extends StatelessWidget {
  final String buttonText;
  final Function onTap;

  const SideMenuButton({
    Key key,
    @required this.buttonText,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 61,
        margin: EdgeInsets.only(left: 6, right: 6),
        padding: EdgeInsets.only(top: 24, bottom: 12, left: 4),
        child: Align(
          alignment: Alignment.centerLeft,
          child: AutoSizeText(
            buttonText,
            minFontSize: 12,
            style: TextStyle(
              color: color_black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: color_black,
            ),
          ),
        ),
      ),
    );
  }
}
