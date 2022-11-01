import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';

class HexagonButton extends StatelessWidget {
  final double sideEdgeWidth;
  final Function onPressed;
  final String text;
  final double width;

  const HexagonButton({
    Key key,
    this.sideEdgeWidth = 15,
    this.onPressed,
    this.text,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipPath(
            child: Container(
              height: 60,
              width: 250,
              color: color_black,
              child: Center(
                child: AutoSizeText(
                  text,
                  style: GoogleFonts.pacifico(
                    color: color_white,
                    fontSize: register_route_input_text_font_size,
                  ),
                ),
              ),
            ),
            clipper: _MyClipper2(sideEdgeWidth, 2),
          ),
        ),
      ),
      onTap: onPressed,
    );
  }
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
