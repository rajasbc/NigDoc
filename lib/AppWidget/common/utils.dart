import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/LoginWidget/veiw/Loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
final LocalStorage storage = new LocalStorage('doctor_store');
 late SharedPreferences pref;
class Helper {
  isvalidElement(data) {
    return data != null;
  }
  appLogoutCall(context, action) async {
    pref = await SharedPreferences.getInstance();
    await storage.deleteItem('doctor_store');
    await pref.setBool('isLogin', false);
    await storage.clear();
    await pref.remove('isLogin');
    await pref.remove('access_token');

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Loginpage()));
    Fluttertoast.showToast(
        msg: action == 'logout' ? 'Logout successfully' : 'Session expeired',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:
             Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
