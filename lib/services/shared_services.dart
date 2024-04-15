import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static SharedPreferences? _preferences;

  static const _KeyUsername = 'username';

  static Future initialize() async => _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async => await _preferences?.setString(_KeyUsername, username);

  static String? getUsername() => _preferences?.getString(_KeyUsername);
}





