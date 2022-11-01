import 'package:flutter/material.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';

class CardContainer extends StatelessWidget {
  final List<Widget> children;
  final double heightPerCent;
  final double widthPerCent;
  final EdgeInsets margin;
  final bool setHeight;
  final double height;
  final double borderRadius;

  const CardContainer({
    Key key,
    @required this.children,
    this.heightPerCent = 1.0,
    this.widthPerCent = 1.0,
    this.margin = EdgeInsets.zero,
    this.setHeight = false,
    this.height = 0,
    this.borderRadius = 35,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * widthPerCent,
      height: setHeight ? height : MediaQuery.of(context).size.height * heightPerCent,
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.all(margin_large),
              decoration: BoxDecoration(
                color: color_orange_card_container,
                border: Border.all(
                  color: color_black,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
              ),
              child: ListView(
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
