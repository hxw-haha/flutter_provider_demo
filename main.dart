import 'dart:async';

import 'package:flutter/material.dart';
import './theme/theme_model.dart';
import './utils/local_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'config/config.dart';
import 'local/locale_model.dart';
import 'local/locale_delegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZoned(() async {
    final Color localColor = await ThemeConfig.localThemeColor();
    final Locale localLocale = await LocaleConfig.localLocale();
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return ThemeModel.initThemeModel(localColor);
        }),
        ChangeNotifierProvider(create: (_) {
          return LocaleModel.initLocalModel(localLocale);
        }),
      ],
      child: MainPage(),
    ));
    Provider.debugCheckInvalidValueType = null;
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeModel themeModel = Provider.of<ThemeModel>(context);
    final LocaleModel localeModel = Provider.of<LocaleModel>(context);
    return MaterialApp(
      theme: themeModel.themeData ??
          ThemeModel.initThemeModel(ThemeConfig.defaultColor),
      home: HomePage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultLocalizationsDelegate.defaultDelegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        print('deviceLocale: $deviceLocale');
      },
      locale: localeModel.locale,
      supportedLocales: [localeModel.locale],
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, LocaleModel>(builder:
        (BuildContext context, ThemeModel theme, LocaleModel locale, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            DefaultLocalizations.currentLocale(context).app_title,
          ),
        ),
        body: ListView(
          children: <Widget>[
            new ExpansionTile(
              title: new Row(
                children: <Widget>[
                  Icon(
                    Icons.color_lens,
                    color: theme.themeData.primaryColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      DefaultLocalizations.currentLocale(context).theme,
                      style: TextStyle(color: theme.themeData.primaryColor),
                    ),
                  )
                ],
              ),
              children: <Widget>[
                new Wrap(
                  children: ThemeConfig.themeColorMap.keys.map((String key) {
                    Color value = ThemeConfig.themeColorMap[key];
                    return new InkWell(
                      onTap: () {
                        SpfUtils.save(Keys.SPF_THEME_KEY, key);
                        theme.changeThemeColor(value);
                      },
                      child: new Container(
                        margin: EdgeInsets.all(5.0),
                        width: 36.0,
                        height: 36.0,
                        color: value,
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
            new ExpansionTile(
              title: new Row(
                children: <Widget>[
                  Icon(
                    Icons.language,
                    color: theme.themeData.primaryColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      DefaultLocalizations.currentLocale(context).language,
                      style: TextStyle(color: theme.themeData.primaryColor),
                    ),
                  )
                ],
              ),
              children: <Widget>[
                new Wrap(
                  children: LocaleConfig.languageCodeKeys.map((String key) {
                    return new InkWell(
                      onTap: () {
                        SpfUtils.save(Keys.SPF_LOCALE_KEY, key);
                        locale.changeLocale(LocaleConfig.localValus[key]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        height: 36.0,
                        color: theme.themeData.primaryColor,
                        child: Center(
                          child: Text(
                            LocaleConfig.getTitle[key],
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
