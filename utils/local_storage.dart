import 'package:shared_preferences/shared_preferences.dart';

class SpfUtils {
  /// 保存数据
  static Future<bool> save(String key, Object value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      return prefs.setString(key, value);
    } else if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is double) {
      return prefs.setDouble(key, value);
    } else if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is List<String>) {
      return prefs.setStringList(key, value);
    } else {
      return remove(key);
    }
  }

  /// 获取数据
  static get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// 删除指定key
  static Future<bool> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  /// 清空
  static Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}

class Keys {
  static final String SPF_LOCALE_KEY = "locale_key";
  static final String SPF_THEME_KEY = "theme_key";
}
