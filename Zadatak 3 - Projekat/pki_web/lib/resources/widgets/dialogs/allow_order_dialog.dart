import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_button.dart';
import 'package:starter_pack/resources/widgets/buttons/hexagon_orange_button.dart';
import 'package:starter_pack/resources/widgets/dialogs/base_dialog.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_pack/resources/widgets/dialogs/message_dialog.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_numeric_text_field.dart';
import 'package:starter_pack/resources/widgets/hexagon/hexagon_text_field.dart';

class AllowOrderDialog extends StatelessWidget {
  final String message;
  final Function allowFunction;
  final Function onClose;
  final String buttonText;
  String i = "";

  AllowOrderDialog({
    this.message,
    this.allowFunction,
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
            Container(
              width: MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.width : 600,
              child: HexagonNumericTextField(
                margin: EdgeInsets.only(top: 10),
                icon: Icon(Icons.looks_one),
                maxLines: 2,
                hintText: "Unesite vreme u danima za koliko stiže narudžbina",
                enableErrorText: false,
                errorText: 'Art',
                text: i,
                onChanged: (text) {
                  i = text;
                },
//                width: 650,
                width1: 450,
              ),
            ),
            AutoSizeText(
              message,
              minFontSize: 24,
              style: GoogleFonts.pacifico(
                color: color_black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              width: 300,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: HexagonOrangeButton(
                      text: "Odustanite",
                      onPressed: onClose,
                      width: 150,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: HexagonButton(
                      text: "Odobrite",
                      onPressed: () {
                        if (i.isEmpty) {
                          MessageDialog.showClassic(context: context, message: "Molimo unesite vreme u danima za koliko stiže roba.");
                        } else {
                          allowFunction();
                        }
                      },
                      width: 150,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static _show({
    @required BuildContext context,
    @required String message,
    @required Function allowFunction,
    Function onClose,
  }) {
    showDialog(
      barrierColor: color_dialog_shadow.withAlpha(195),
      barrierDismissible: true,
      context: context,
      builder: (context) =>
          AllowOrderDialog(
            onClose: onClose ??
                    () {
                  Navigator.pop(context);
                },
            message: message,
            allowFunction: () {
              allowFunction();
              Navigator.pop(context);
            },
          ),
    );
  }

  static showClassic({
    @required BuildContext context,
    @required String message,
    @required Function allowFunction,
    Function onClose,
  }) {
    _show(
      context: context,
      message: message,
      onClose: onClose,
      allowFunction: allowFunction,
    );
  }

  static close(BuildContext context) {
    Navigator.pop(context);
  }
}
