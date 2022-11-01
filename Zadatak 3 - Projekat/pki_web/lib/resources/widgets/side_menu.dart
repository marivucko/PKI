import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/values/colors.dart';

class SideMenu extends StatelessWidget {
  final bool visible;
  final List<Widget> sideMenuButtons;
  final double marginRight;

  const SideMenu({
    Key key,
    @required this.visible,
    @required this.sideMenuButtons,
    this.marginRight = margin_larger,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: EdgeInsets.only(
            top: app_bar_height / 2 - 10,
            right: marginRight,
          ),
          width: 230,
          child: Container(
            height: (sideMenuButtons.length * 63 + 10).toDouble(),
            decoration: BoxDecoration(
              color: color_orange_card_container,
              border: Border.all(
                color: color_black,
                width: 2,
              ),
            ),
            child: Column(
              children: sideMenuButtons,
            ),
          ),
        ),
      ),
    );
  }
}
