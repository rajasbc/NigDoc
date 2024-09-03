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

class Api {
  getstafflist(access_token) async {
    String stafflisturl = requestpath.base_url + requestpath.StaffListEndpoint;
    var response = await http.get(Uri.parse(stafflisturl),
        headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  Addstaff(access_token,data) async {
    String adduserurl = requestpath.base_url + requestpath.adduser;
    var response = await http.post(Uri.parse(adduserurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  Editstaff(access_token,data) async {
    String edituserurl = requestpath.base_url + requestpath.edituser;
    var response = await http.post(Uri.parse(edituserurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  Deletestaff(access_token,data) async {
    String deletestaffurl = requestpath.base_url + requestpath.deleteuser;
   var response = await http.post(
      Uri.parse(deletestaffurl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  
  selecteddepartment(data, accessToken, context) async {
    String departmentUrl = requestpath.base_url + requestpath.selecteddepartment;
    var response = await http.post(Uri.parse(departmentUrl),
        body: jsonEncode(data), headers: _setHeaders(accessToken));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
}
