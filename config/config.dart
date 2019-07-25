import 'package:flutter/material.dart';
import '../local/locale_string.dart';
import '../utils/local_storage.dart';

/// 主题配置
class ThemeConfig {
  static Color defaultColor = ThemeConfig.themeColorMap[ThemeConfig.grayKey];

  static String grayKey = 'gray';
  static String blueKey = 'blue';
  static String blueAccentKey = 'blueAccent';
  static String cyanKey = 'cyan';
  static String deepPurpleKey = 'deepPurple';
  static String deepPurpleAccentKey = 'deepPurpleAccent';
  static String deepOrangeKey = 'deepOrange';
  static String greenKey = 'green';
  static String indigoKey = 'indigo';
  static String indigoAccentKey = 'indigoAccent';
  static String orangeKey = 'orange';
  static String purpleKey = 'purple';
  static String pinkKey = 'pink';
  static String redKey = 'red';
  static String tealKey = 'teal';
  static String blackKey = 'black';

  static Map<String, Color> themeColorMap = {
    grayKey: Colors.grey,
    blueKey: Colors.blue,
    blueAccentKey: Colors.blueAccent,
    cyanKey: Colors.cyan,
    deepPurpleKey: Colors.deepPurple,
    deepPurpleAccentKey: Colors.deepPurpleAccent,
    deepOrangeKey: Colors.deepOrange,
    greenKey: Colors.green,
    indigoKey: Colors.indigo,
    indigoAccentKey: Colors.indigoAccent,
    orangeKey: Colors.orange,
    purpleKey: Colors.purple,
    pinkKey: Colors.pink,
    redKey: Colors.red,
    tealKey: Colors.teal,
    blackKey: Colors.black,
  };

  static Future<Color> localThemeColor() async {
    final String themeKey = await SpfUtils.get(Keys.SPF_THEME_KEY);
    final Color localColor = (themeKey == null || themeKey == "")
        ? ThemeConfig.defaultColor
        : ThemeConfig.themeColorMap[themeKey];
    return localColor;
  }
}

/// 语言配置
class LocaleConfig {
  static Locale defaultLocale = LocaleConfig.localValus[LocaleConfig.zhKey];

  static String enKey = "en";
  static String zhKey = "zh";

  static Map<String, Locale> localValus = {
    zhKey: Locale('zh', 'CH'),
    enKey: Locale('en', 'US'),
  };

  static List<String> languageCodeKeys = [enKey, zhKey];

  static Map<String, String> getTitle = {
    enKey: "English",
    zhKey: "简体中文",
  };

  static Map<String, LocaleBase> languageCodeValues = {
    enKey: new LocaleEn(),
    zhKey: new LocaleZh(),
  };

  static Future<Locale> localLocale() async {
    final String localeKey = await SpfUtils.get(Keys.SPF_LOCALE_KEY);
    final Locale localLocale = (localeKey == null || localeKey == "")
        ? LocaleConfig.defaultLocale
        : LocaleConfig.localValus[localeKey];
    return localLocale;
  }
}
