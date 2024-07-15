import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nigdoc/Api/url.dart' as requestpath;

_setHeaders(access_token) => {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $access_token'
    };
_setHeadersWithOutToken() => {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };

class api {
  getdoctorlist(access_token) async {
    String doctorlisturl = requestpath.base_url + requestpath.DoctorListEndpoint;
    var response = await http.get(Uri.parse(doctorlisturl),
        headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  userSignup(Map<String, String> data, accessToken, BuildContext context) {}
}
