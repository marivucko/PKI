import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  final String text;
  final Color color;
  final double widthFraction;

  const StyledText({
    Key key,
    @required this.text,
    this.color = color_black,
    this.widthFraction = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / widthFraction,
      child: Center(
        child: AutoSizeText(
          text,
          minFontSize: 12,
          style: GoogleFonts.pacifico(
            color: color,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
