import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:starter_pack/resources/values/colors.dart';

class DesignService {

  void setTransparentStatusBarAndWhiteNAvigrationBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    setNavigationBarColor(color_white);
  }

  Future<void> setStatusBarColor(Color statusBarColor) async {
    await FlutterStatusbarcolor.setStatusBarColor(statusBarColor, animate: true);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(useWhiteForeground(statusBarColor));
  }

  Future<void> setNavigationBarColor(Color navigationBarColor) async {
    await FlutterStatusbarcolor.setNavigationBarColor(navigationBarColor, animate: true);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(!useWhiteForeground(navigationBarColor));
  }

  void removeNavigationBar() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    setTransparentStatusBarAndWhiteNAvigrationBar();
  }

  void setFullScreen() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

}