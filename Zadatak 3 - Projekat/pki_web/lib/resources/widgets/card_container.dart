import 'package:flutter/material.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';

class CardContainer extends StatelessWidget {
  final List<Widget> children;
  final double heightPercent;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double borderRadius;

  const CardContainer({
    Key key,
    @required this.children,
    this.heightPercent = 0.75,
    this.margin,
    this.padding,
    this.borderRadius = 35,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              margin: margin,
              padding: padding,
              width: MediaQuery.of(context).size.width * 0.5 > 600 ? MediaQuery.of(context).size.width * 0.5 : 600,
              height: MediaQuery.of(context).size.height * heightPercent,
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
