


import 'package:shared_preferences/shared_preferences.dart';

class Preferenes {

  static late SharedPreferences _prefs ;

  static bool _isDarkMode = true;

  static Future initPref()async{

    _prefs = await SharedPreferences.getInstance();

  }

  static bool get isDarkMode {

    return _prefs.getBool("dark") ?? _isDarkMode;

  }

  static set isDarkMode( bool value ){

    _isDarkMode = value;

    _prefs.setBool("dark", value);

  }





}