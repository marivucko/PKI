import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';

class LoadingBuffer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: loadingBufferHeight,
      width: loadingBufferWidth,
      child: CircularProgressIndicator(
        strokeWidth: loadingBufferStrokeWidth,
        backgroundColor: color_dialog_background,
        valueColor: AlwaysStoppedAnimation<Color>(color_black),
      ),
    );
  }
}