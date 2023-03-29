import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
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

  ContainerShowdow(width, color) {
    return BoxDecoration(
      color: color == 'yes' ? Colors.blue : Colors.white,
      border: width != 0 ?
      Border.all(width: 2, color:Colors.blue )
      : Border(),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 4,
          blurRadius: 4,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ],
    );
  }
  getCurrentDate() {
    final today_date = new DateTime.now();
    return formateDate(today_date);
  }
   formateDate(date) {
    // var today = new DateTime.now();
    // DateTime date = date;
    
    // var formatter = new DateFormat('yyyy-MM-dd');
        var formatter = new DateFormat('dd-MM-yyyy');

    String formatted_date = formatter.format(date);
    return formatted_date;
  }
}
