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

class DashboardApi {
  appVersionCheck() async {
    String getnotificationUrl =
        requestpath.base_url + requestpath.getAppversionEndpoint;
    var response = await http.get(Uri.parse(getnotificationUrl),headers: _setHeadersWithOutToken());
    if (response.statusCode == 200) {
      if (response.body == '{"status":"Token is Expired"}') {
        return [json.decode(response.body)];
      } else {
        return json.decode(response.body);
      }
    } else {
     return json.decode(response.body);
    }
  }

  getdeshboardList(access_token) async {
    String dashboardlisturl =
        requestpath.base_url + requestpath.dashboardDetailsEndpoint;
    var response = await http.get(Uri.parse(dashboardlisturl),
        headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  updateFCM(data) async {
    String update_fcm = requestpath.base_url + requestpath.updateFCMEndpoint;
    var response = await http.post(
      Uri.parse(update_fcm),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  GetNotification(data) async {
    String update_fcm =
        requestpath.base_url + requestpath.notificationListEndpoint;
    var response = await http.post(
      Uri.parse(update_fcm),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  eachDoctorAppoinmentList(data) async {
    String result = requestpath.base_url + requestpath.appointmentListEndpoint;
    var response = await http.post(
      Uri.parse(result),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  appointmnetFixbyDoctor(data) async {
    String result = requestpath.base_url + requestpath.appointmentFixEndpoint;
    var response = await http.post(
      Uri.parse(result),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
}
