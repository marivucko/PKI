import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/values/dimen.dart';
import 'package:starter_pack/resources/widgets/dialogs/base_dialog.dart';
import 'package:starter_pack/resources/widgets/dialogs/loading_buffer.dart';

enum LoadingDialogType {
  loading,
  downloading
}

class LoadingDialog extends StatelessWidget {

  final LoadingDialogType loadingDialogType;

  LoadingDialog(this.loadingDialogType);

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      child: Container(
        height: dialogHeight,
        padding: EdgeInsets.all(
          padding
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingBuffer(),
            Container(
              margin: EdgeInsets.only(
                left: margin_xlarge,
              ),
              child: AutoSizeText(
                text(context),
                maxFontSize: main_route_main_text,
                style: GoogleFonts.pacifico(
                  fontSize: main_route_main_text,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        )
      )
    );
  }

  static _show(BuildContext context, LoadingDialogType loadingDialogType) {
    showDialog (
      barrierColor: color_dialog_shadow.withAlpha(195),
      barrierDismissible: false,
      context: context,
      builder: (context) => LoadingDialog(loadingDialogType)
    );
  }

  static showLoading(BuildContext context) {
    _show(context, LoadingDialogType.loading);
  }

  static showDownloading(BuildContext context) {
    _show(context, LoadingDialogType.downloading);
  }

  String text(BuildContext context) {
    switch(loadingDialogType) {
      case LoadingDialogType.loading: return AppLocalizations.of(context).translate("loading");
      case LoadingDialogType.downloading: return AppLocalizations.of(context).translate("downloading");
      default: return AppLocalizations.of(context).translate("loading");
    }
  }

  static close(BuildContext context) {
    Navigator.pop(context);
  }

}
