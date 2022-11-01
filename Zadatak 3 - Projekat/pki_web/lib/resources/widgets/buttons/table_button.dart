import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_pack/data/beans/order.dart';

class TableButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Order order;

  const TableButton({
    Key key,
    @required this.text,
    @required this.onTap,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
//      margin: 10,
//    color: Colors.blue,
        decoration: BoxDecoration(
          color: color_black,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        width: 75,
        child: Center(
          child: AutoSizeText(
            text,
            minFontSize: 12,
            style: GoogleFonts.pacifico(
              color: color_white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
