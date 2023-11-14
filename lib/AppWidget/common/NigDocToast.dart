import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../../AppWidget/common/Colors.dart'as custom_color;

class NigDocToast{
  showSuccessToast(message){
    Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb:1,
    backgroundColor: custom_color.success_color,
    textColor: custom_color.success_text_color,
    fontSize: 16.0);
  }
   showErrorToast(message){
    Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb:1,
    backgroundColor: custom_color.error_color,
    textColor: Colors.black,
    fontSize: 16.0);
  }
}