abstract class LocaleBase {
  String app_title;

  String theme;

  String language;
}

class LocaleEn extends LocaleBase {
  @override
  String get app_title => "provider setting";

  @override
  String get theme => "Theme";

  @override
  String get language => "Language";
}

class LocaleZh extends LocaleBase {
  @override
  String get app_title => "provider 设置";

  @override
  String get theme => "主题";

  @override
  String get language => "语言";
}
