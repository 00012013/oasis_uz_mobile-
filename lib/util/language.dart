import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferences {
  static const String _languageKey = 'selectedLanguage';

  static Future<void> saveLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  static Future<String?> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey);
  }
}
