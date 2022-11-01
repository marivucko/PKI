import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/services/all_services.dart';

class BaseDialog extends StatelessWidget {
  final Widget child;

  const BaseDialog({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllServices().designService.setTransparentStatusAndNavigationBar();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(corner_radius),
      ),
      backgroundColor: color_dialog_background,
      child: Container(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
    );
  }
}
