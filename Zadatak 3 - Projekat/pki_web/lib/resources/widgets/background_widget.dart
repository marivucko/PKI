import 'package:flutter/material.dart';
import 'package:starter_pack/resources/values/colors.dart';

class BackgroundWidget extends StatelessWidget {
  final List<Widget> children;

  const BackgroundWidget({Key key, @required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color_orange_top, color_orange_bottom],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Stack(children: children)
        ],
      ),
    );
  }
}
