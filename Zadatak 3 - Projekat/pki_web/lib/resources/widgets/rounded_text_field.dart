import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';

class RoundedTextField extends StatelessWidget {
  final double sideEdgeWidth;
  final Icon icon;
  final String hintText;
  final String text;
  final EdgeInsets margin;
  final Function onChanged;
  final bool enableErrorText;
  final String errorText;
  final bool obscureText;
  final bool readOnly;

  const RoundedTextField({
    Key key,
    this.sideEdgeWidth = 15,
    this.icon,
    this.hintText,
    this.text,
    this.margin = EdgeInsets.zero,
    this.onChanged,
    this.enableErrorText = false,
    this.errorText,
    this.obscureText = false,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
//      Stack(
//      children: [
//        Container(
//          margin: margin,
//          child: Padding(
//            padding: const EdgeInsets.all(10.0),
//            child: ClipPath(
//              child: Container(
//                height: 60,
//                width: double.infinity,
//                color: color_black,
//              ),
//              clipper: _MyClipper(sideEdgeWidth),
//            ),
//          ),
//        ),
//        Container(
//          margin: margin,
//          child: Padding(
//            padding: const EdgeInsets.all(10.0),
//            child: ClipPath(
//              child:
       Padding(
            padding: const EdgeInsets.all(10.0), child:
              Container(
                padding: const EdgeInsets.all(10.0),
                height: 60,
                decoration: BoxDecoration(
                  color: color_orange_card_container,
                  border: Border.all(color: color_black, width: 2,)
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: padding_custom_large),
                        height: 45,
                        width: 45,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: icon,
                        ),
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
                ),),);
//              ),
//              clipper: _MyClipper2(sideEdgeWidth, 2),
//            ),
//          ),
//        )
//      ],
//    );
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

class _MyClipper extends CustomClipper<Path> {
  final double sideEdgeWidth;

  _MyClipper(this.sideEdgeWidth);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height / 2);
    path.lineTo(sideEdgeWidth, 0);
    path.lineTo(size.width - sideEdgeWidth, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - sideEdgeWidth, size.height);
    path.lineTo(sideEdgeWidth, size.height);
    path.lineTo(0, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _MyClipper2 extends CustomClipper<Path> {
  final double sideEdgeWidth;
  final double lineWidth;

  _MyClipper2(this.sideEdgeWidth, this.lineWidth);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(lineWidth, size.height / 2);
    path.lineTo(sideEdgeWidth + lineWidth - 0.5, 2);
    path.lineTo(size.width - (sideEdgeWidth + lineWidth - 0.5), lineWidth);
    path.lineTo(size.width - lineWidth, size.height / 2);
    path.lineTo(size.width - (sideEdgeWidth + lineWidth - 0.5), size.height - lineWidth);
    path.lineTo(sideEdgeWidth + lineWidth - 0.5, size.height - lineWidth);
    path.lineTo(lineWidth, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
