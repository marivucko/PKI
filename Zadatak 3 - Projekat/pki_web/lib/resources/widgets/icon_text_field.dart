import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';

class IconTextField extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function onPressed;
  final double width;
  final double padding;

  const IconTextField({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.icon,
    this.width = 90,
    this.padding = padding_custom_large,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.only(right: margin),
//          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
//                color: Colors.green,
                margin: EdgeInsets.only(left: padding),
                height: 30,
                width: 30,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: icon,
                ),
              ),
              Container(
//                color: Colors.deepPurple,
                height: 30,
                width: width,
                margin: EdgeInsets.only(left: margin_small),
                child: TextField(
                  enabled: false,
                  style: GoogleFonts.pacifico(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color_black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: text,
                    hintStyle: GoogleFonts.pacifico(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color_black,
                    ),
                    contentPadding: EdgeInsets.only(
                      bottom: 12, // HERE THE IMPORTANT PART
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
