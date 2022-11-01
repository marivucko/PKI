import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/register/bloc.dart';

class HexagonRadioButtons extends StatelessWidget {
  final double sideEdgeWidth;
  final int groupValue;
  final Function onChangedFirst;
  final Function onChangedSecond;

  const HexagonRadioButtons({
    Key key,
    this.sideEdgeWidth = 15,
    this.groupValue,
    this.onChangedFirst,
    this.onChangedSecond,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipPath(
              child: Container(
                height: 60,
                width: double.infinity,
                color: color_black,
              ),
              clipper: _MyClipper(sideEdgeWidth),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipPath(
              child: Container(
                color: color_orange_card_container,
                height: 60,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.only(left: margin_large),
                        child: GestureDetector(
                          child: Row(
                            children: [
                              Radio(
                                value: RegisterBloc.RADIO_BUTTON_CUSTOMER_SELECTED,
                                groupValue: groupValue,
                                activeColor: color_black,
                                onChanged: (val) {
                                  onChangedFirst();
                                },
                              ),
                              AutoSizeText(
                                AppLocalizations.of(context).translate("register_route_customer"),
                                style: GoogleFonts.pacifico(
                                  color: color_black,
                                  fontSize: register_route_input_text_font_size,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            onChangedFirst();
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(left: 65),
                        width: 130,
                        child: GestureDetector(
                          child: Row(
                            children: [
                              Radio(
                                value: RegisterBloc.RADIO_BUTTON_VENDOR_SELECTED,
                                groupValue: groupValue,
                                activeColor: color_black,
                                onChanged: (val) {
                                  onChangedSecond();
                                },
                              ),
                              AutoSizeText(
                                AppLocalizations.of(context).translate("register_route_vendor"),
                                style: GoogleFonts.pacifico(
                                  color: color_black,
                                  fontSize: register_route_input_text_font_size,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            onChangedSecond();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              clipper: _MyClipper2(sideEdgeWidth, 2),
            ),
          ),
        )
      ],
    );
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
