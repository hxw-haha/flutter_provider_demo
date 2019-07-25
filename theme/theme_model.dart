import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData _themeData;

  ThemeModel(ThemeData themeData) {
    this._themeData = themeData;
  }

  ThemeData get themeData => _themeData;

  void changeThemeColor(Color themeColor) {
    this._themeData = initThemeData(themeColor);
    notifyListeners();
  }

  void changeThemeData(ThemeData themeData) {
    this._themeData = themeData;
    notifyListeners();
  }

  static ThemeModel initThemeModel(
    Color defaultThemeColor, {
    TargetPlatform platform,
  }) {
    return ThemeModel(initThemeData(defaultThemeColor, platform: platform));
  }

  static ThemeData initThemeData(
    Color primaryColor, {
    TargetPlatform platform,
  }) {
    return ThemeData(
        primaryColor: primaryColor,
        platform: platform ?? TargetPlatform.android);
  }
}
