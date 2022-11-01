import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:auto_size_text/auto_size_text.dart';

class OneLineRectangleTextField extends StatelessWidget {
  final double sideEdgeWidth;
  final Icon icon;
  final String titleText;
  final String hintText;
  final String text;
  final EdgeInsets margin;
  final Function onChanged;
  final bool enableErrorText;
  final String errorText;
  final bool obscureText;
  final bool readOnly;
  final int minLines;
  final int maxLines;

  const OneLineRectangleTextField({
    Key key,
    this.sideEdgeWidth = 15,
    this.icon,
    this.titleText,
    this.hintText,
    this.text,
    this.margin = EdgeInsets.zero,
    this.onChanged,
    this.enableErrorText = false,
    this.errorText,
    this.obscureText = false,
    this.readOnly = false,
    this.minLines = 1,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20),
          decoration: BoxDecoration(
            color: color_orange_card_container,
            border: Border.all(
              color: color_black,
              width: 2,
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
//                      color: Colors.green,
                  margin: EdgeInsets.only(left: padding_custom_large),
                  height: 40,
                  width: 40,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: icon,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                ),
                Container(
                  height: 45,
                  width: 250,
                  margin: EdgeInsets.only(left: margin_large),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextField(
                      controller: controller(),
                      style: GoogleFonts.pacifico(
                        fontSize: register_route_input_text_font_size,
                      ),
                      readOnly: readOnly,
                      textDirection: TextDirection.ltr,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        contentPadding: EdgeInsets.only(
                          bottom: 0,
                        ),
                        errorText: enableErrorText && text.isEmpty ? errorText : '',
                        errorStyle: GoogleFonts.pacifico(
                          fontSize: 10,
                        ),
                      ),
                      onChanged: (text) {
                        onChanged(text);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController controller() {
    if (text != null) {
      TextEditingController textController = TextEditingController(text: text != null ? text : "");
      return textController;
    } else {
      return null;
    }
  }
}
