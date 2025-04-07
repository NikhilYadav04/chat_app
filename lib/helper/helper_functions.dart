import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String userLoggedInKey = "LOGINKEY";
  static String userNameKey = "NAMEKEY";
  static String userEmailKey = "EMAILKEY";

  //storing the logged in status to SF
  static Future<bool> saveUserLoggedInStatus(bool isUserloggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setBool(userLoggedInKey, isUserloggedIn);
  }
 
   //storing the name to SF
  static Future<bool> saveUserName(String userName) async{
   SharedPreferences sf = await SharedPreferences.getInstance();
  return sf.setString(userNameKey, userName);
  }

   //storing email to SF
  static Future<bool> saveUserEMail(String userEmail) async{
   SharedPreferences sf = await SharedPreferences.getInstance();
  return sf.setString(userEmailKey, userEmail);
  }

  //getting the data fromsf
  static Future<bool?> getUserLoggedInStatus(BuildContext context) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  //getting the name
  static Future<String?> getUserName() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }

  // getting the email
  static Future<String?> getUserEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }
}
