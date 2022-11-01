import 'package:flutter/material.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';

class CardContainerForListView extends StatelessWidget {
  final Widget child;
  final double heightPercent;
  final EdgeInsets margin;
  final EdgeInsets padding;

  const CardContainerForListView({
    Key key,
    @required this.child,
    this.heightPercent = 0.75,
    this.margin,
    this.padding,
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
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * heightPercent,
              decoration: BoxDecoration(
                color: color_orange_card_container,
                border: Border.all(
                  color: color_black,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(35),
                ),
              ),
              child: child
            ),
          ),
        ],
      ),
    );
  }
}
