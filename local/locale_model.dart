import 'package:flutter/cupertino.dart';

class LocaleModel extends ChangeNotifier {
  Locale _locale;

  LocaleModel(Locale locale) {
    this._locale = locale;
  }

  Locale get locale => _locale;

  static LocaleModel initLocalModel(Locale locale) {
    return LocaleModel(locale);
  }

  void changeLocale(Locale locale) {
    this._locale = locale;
    notifyListeners();
  }
}
