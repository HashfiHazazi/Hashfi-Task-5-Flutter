import 'package:shared_preferences/shared_preferences.dart';

class LoginLocalStorage {
  static const String _userNameKey = 'USERNAME_KEY';
  static const String _userEmailKey = 'USER_EMAIL_KEY';
  static const String _userPhoneNumberKey = 'USER_PHONE_NUMBER_KEY';

  static Future<void> setUserName(String userName) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_userNameKey, userName);
  }

  static Future<String?> getUserName() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_userNameKey);
  }

  static Future<void> setUserEmail(String userName) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_userEmailKey, userName);
  }

  static Future<String?> getUserEmail() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_userEmailKey);
  }

  static Future<void> setUserPhoneNumber(String userName) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_userPhoneNumberKey, userName);
  }

  static Future<String?> getUserPhoneNumber() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_userPhoneNumberKey);
  }

  static Future<void> clearStorage() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
