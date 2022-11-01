import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_button.dart';
import 'package:starter_pack/resources/widgets/dialogs/base_dialog.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageDialog extends StatelessWidget {
  final String message;
  final Function onClose;
  final String buttonText;

  MessageDialog({
    this.message,
    this.onClose,
    this.buttonText = "Ok",
  });

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      child: Container(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AutoSizeText(
              message,
              minFontSize: 24,
              style: GoogleFonts.pacifico(
                color: color_black,
                fontWeight: FontWeight.w500,
              ),
            ),
            HexagonButton(
              text: buttonText,
              onPressed: onClose,
            ),
          ],
        ),
      ),
    );
  }

  static _show({
    @required BuildContext context,
    @required String message,
    Function onClose,
  }) {
    showDialog(
      barrierColor: color_dialog_shadow.withAlpha(195),
      barrierDismissible: true,
      context: context,
      builder: (context) => MessageDialog(
        onClose: onClose ??
          () {
            Navigator.pop(context);
          },
        message: message,
      ),
    );
  }

  static showClassic({
    @required BuildContext context,
    @required String message,
    Function onClose,
    }) {
    _show(
      context: context,
      message: message,
      onClose: onClose,
    );
  }

  static close(BuildContext context) {
    Navigator.pop(context);
  }
}
