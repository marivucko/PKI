import 'package:flutter/material.dart';
import 'package:starter_pack/resources/values/colors.dart';

class OfflineWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: color_red,
      alignment: Alignment.center,
      child: Icon(
        Icons.signal_wifi_off,
        size: 128,
        color: color_white,
      ),
    );
  }

}