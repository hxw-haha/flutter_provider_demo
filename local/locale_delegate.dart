import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../config/config.dart';

import 'locale_string.dart';

class DefaultLocalizationsDelegate
    extends LocalizationsDelegate<DefaultLocalizations> {
  DefaultLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return LocaleConfig.languageCodeKeys.contains(locale.languageCode);
  }

  ///根据locale，创建一个对象用于提供当前locale下的文本显示
  @override
  Future<DefaultLocalizations> load(Locale locale) {
    return new SynchronousFuture<DefaultLocalizations>(
        new DefaultLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<DefaultLocalizations> old) {
    return false;
  }

  ///全局静态的代理
  static DefaultLocalizationsDelegate defaultDelegate =
      new DefaultLocalizationsDelegate();
}

///自定义多语言实现
class DefaultLocalizations {
  final Locale locale;

  DefaultLocalizations(this.locale);

  LocaleBase get currentLocalized {
    return LocaleConfig.languageCodeValues[locale.languageCode];
  }

  static DefaultLocalizations of(BuildContext context) {
    return Localizations.of(context, DefaultLocalizations);
  }

  /// 获取当前 app 语言
  static LocaleBase currentLocale(BuildContext context) {
    return DefaultLocalizations.of(context).currentLocalized;
  }
}
