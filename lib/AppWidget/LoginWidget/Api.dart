import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nigdoc/Api/url.dart' as requestpath;
import 'package:nigdoc/AppWidget/common/utils.dart';

_setHeaders(access_token) => {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $access_token'
    };
_setHeadersWithOutToken() => {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };

class loginpage {
  loginresponse(data) async {
    String loginurl = requestpath.base_url + requestpath.userlogin;
    var response = await http.post(Uri.parse(loginurl),
        body: jsonEncode(data), headers: _setHeadersWithOutToken());
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  
  userSignup(data) async {
    String signupurl = requestpath.base_url + requestpath.userSignup;
   var response = await http.post(
      Uri.parse(signupurl),
      body: jsonEncode(data),
      headers: _setHeadersWithOutToken());
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  // userSignup(data,accessToken, context) async {
  //   try {
  //     String signupurl = requestpath.base_url + requestpath.userSignup;
  //     var response = await http.post(
  //       Uri.parse(signupurl),
  //       body: jsonEncode(data),
  //       headers: _setHeaders(accessToken),
  //     );
  //     if (response.statusCode == 200) {
  //       if (response.body == '{"status":"Token is Invalid"}' ||
  //           response.body == '{"status":"Token is Expired"}') {
  //         Helper().sessionExpired(context);
  //       } else {
  //         return json.decode(response.body);
  //       }
  //     } else {
  //       return json.decode(response.body);
  //     }
  //   } catch (e) {
  //     print('login error $e');
  //   }
  // }
}
