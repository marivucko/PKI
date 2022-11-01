import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_incrementer/bloc.dart';

//import 'hexagon_incrementer_bloc.dart';

class HexagonIncrementer extends StatelessWidget {

  const HexagonIncrementer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HexagonIncrementerBloc(context),
      child: _HexagonIncrementerStatefulWidget(),
    );
  }

  static int getQuantity() {
    return _HexagonIncrementerStatefulWidget.getQuantity();
  }
}

class _HexagonIncrementerStatefulWidget extends StatefulWidget {

  const _HexagonIncrementerStatefulWidget({Key key}) : super(key: key);

  _HexagonIncrementerStatefulWidgetState createState() => _HexagonIncrementerStatefulWidgetState();

  static int getQuantity() {
    return _HexagonIncrementerStatefulWidgetState.quantity;
  }
}

class _HexagonIncrementerStatefulWidgetState extends State<_HexagonIncrementerStatefulWidget> {
  HexagonIncrementerBloc _hexagonIncrementerBloc;

  double sideEdgeWidth = 15;
  static int quantity;

  static int getQuantity() {
    return quantity;
  }

  _HexagonIncrementerStatefulWidgetState();

  @override
  void initState() {
    _hexagonIncrementerBloc = BlocProvider.of<HexagonIncrementerBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _hexagonIncrementerBloc,
      builder: (BuildContext context, HexagonIncrementerState state) {
        quantity = state.quantity;
        return GestureDetector(
          child: Stack(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipPath(
                    child: Container(
                      height: 60,
                      width: 250,
                      color: color_black,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          "Količina",
                          style: GoogleFonts.pacifico(
                            color: color_black,
                            fontSize: register_route_input_text_font_size,
                          ),
                        ),
                      ),
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
                      height: 60,
                      width: 250,
                      color: color_orange_card_container,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 35),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              "Količina",
                              style: GoogleFonts.pacifico(
                                color: color_black,
                                fontSize: register_route_input_text_font_size,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 50),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 20,
                              child: AutoSizeText(
                                state.quantity.toString(),
                                style: GoogleFonts.pacifico(
                                  color: color_black,
                                  fontSize: register_route_input_text_font_size,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              children: [
                                Container(
                                  child: SizedBox(
                                    height: 27,
                                    width: 30,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.arrow_drop_up),
                                      iconSize: 24,
                                      onPressed: () {
                                        _hexagonIncrementerBloc.add(IncHexagonIncrementerEvent());
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  child: SizedBox(
                                    height: 27,
                                    width: 30,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      onPressed: () {
                                        _hexagonIncrementerBloc.add(DecHexagonIncrementerEvent());
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    clipper: _MyClipper2(sideEdgeWidth, 2),
                  ),
                ),
              ),
            ],
          ),
          onTap: () {},
        );
      },
    );
  }

  @override
  void dispose() {
    _hexagonIncrementerBloc.close();
    super.dispose();
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
