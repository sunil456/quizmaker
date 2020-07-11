import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions
{

  static String USER_LOOGGED_IN_KEY = "UserLoggedInKey";

  static saveUserLoggedInDetails({@required bool isLoggedIn}) async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(USER_LOOGGED_IN_KEY, isLoggedIn);
  }

  static Future<bool> getUserLoggedInDetails() async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(USER_LOOGGED_IN_KEY);
  }

}