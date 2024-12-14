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

class billingapi {
  getpendinglist(access_token, data) async {
    String pendinglisturl =
        requestpath.base_url + requestpath.pendingbilllistEndpoint;
    var response = await http.post(Uri.parse(pendinglisturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
           if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  pendingpayment(access_token, data) async {
    String pendinglisturl =
        requestpath.base_url + requestpath.pendingpayment;
    var response = await http.post(Uri.parse(pendinglisturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
           if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  gerRegisterReport(access_token, data) async {
    String registerturl =
        requestpath.base_url + requestpath.gerRegisterReport;
    var response = await http.post(Uri.parse(registerturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
           if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   getRegisterReportPayList(access_token, data) async {
    String registerturl =
        requestpath.base_url + requestpath.getRegisterReportPayList;
    var response = await http.post(Uri.parse(registerturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
           if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  DocRegisterReportPay(access_token, data) async {
    String pendinglisturl =
        requestpath.base_url + requestpath.DocRegisterReportPay;
    var response = await http.post(Uri.parse(pendinglisturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
           if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   DocRegisterReportSendOTP(access_token, data) async {
    String sendotpurl =
        requestpath.base_url + requestpath.DocRegisterReportSendOTP;
    var response = await http.post(Uri.parse(sendotpurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
           if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
}
