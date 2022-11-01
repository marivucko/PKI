import 'package:flutter/material.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';

class Frame extends StatelessWidget {
  final Widget child;
  final double topMargin;

  const Frame({
    Key key,
    @required this.child,
    this.topMargin = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 175, left: 175),
      width: MediaQuery.of(context).size.width / 2 - 350,
      height: 400,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.only(left: 40),
              height: 35,
              child: Expanded(
                child: Divider(
                  color: color_orange_card_container,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.only(bottom: 40),
              width: 20,
              child: Expanded(
                child: VerticalDivider(
                  color: color_orange_card_container,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.only(top: 40),
              width: 50,
              child: Expanded(
                child: VerticalDivider(
                  color: color_orange_card_container,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(right: 40),
              height: 35,
              child: Expanded(
                child: Divider(
                  color: color_orange_card_container,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 35,
              height: 35,
              child: FittedBox(
                child: Image.asset('assets/images/image_border.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 35,
              height: 35,
              child: FittedBox(
                child: Image.asset('assets/images/image_border.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(left: 55, right: 50, top: topMargin),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
