import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._internal();
  SharedPreferences? _preferences;

  // Private constructor
  SharedPreferencesHelper._internal();

  // Public factory method to provide access to the singleton instance
  factory SharedPreferencesHelper() {
    return _instance;
  }

  // Initialize the SharedPreferences instance
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

// Method to get a String value from SharedPreferences
  bool? containsKey(String key) {
    return _preferences?.containsKey(key);
  }

//! Getter Methods
  // Method to get a String value from SharedPreferences
  String? getString(String key) {
    return _preferences?.getString(key);
  }

  // Method to get a bool value from SharedPreferences
  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  // Method to get a double value from SharedPreferences
  double? getDouble(String key) {
    return _preferences?.getDouble(key);
  }

  // Method to get a int value from SharedPreferences
  int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  // Method to get a List of String values from SharedPreferences
  List<String>? getStringList(String key) {
    return _preferences?.getStringList(key);
  }

//! Setter Methods
  // Method to set a value as bool in SharedPreferences
  Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  // Method to set a value as double in SharedPreferences
  Future<void> setDouble(String key, double value) async {
    await _preferences?.setDouble(key, value);
  }

  // Method to set a value as int in SharedPreferences
  Future<void> setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  // Method to set a value as String in SharedPreferences
  Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  // Method to set multiple values in SharedPreferences
  Future<void> setStringList(String key, List<String> value) async {
    await _preferences?.setStringList(key, value);
  }

//! Removed Methods
  // Method to remove a value from SharedPreferences
  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  // Method to clear all value from SharedPreferences
  Future<void> removeAll() async {
    await _preferences?.clear();
  }
}
