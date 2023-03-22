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
class PatientApi{
  getpatientlist(access_token) async {
    String patientlisturl = requestpath.base_url + requestpath.patientListEndpoint;
    var response = await http.get(Uri.parse(patientlisturl),
        headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

   gettreatmentlist(access_token) async {
    String treatmentlisturl = requestpath.base_url + requestpath.treatmentListEndpoint;
    var response = await http.get(Uri.parse(treatmentlisturl),
        headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

getMediAndLabNameList(access_token,data) async {
    String getMediAndLabNamelisturl = requestpath.base_url + requestpath.getMediAndLabNameListEndpoint;
   var response = await http.post(
      Uri.parse(getMediAndLabNamelisturl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  getLabtestList(access_token,data) async {
    String getlabtestlisturl = requestpath.base_url + requestpath.getlabtestListEndpoint;
   var response = await http.post(
      Uri.parse(getlabtestlisturl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

   getmedicineList(access_token,data) async {
    String getmedicinelisturl = requestpath.base_url + requestpath.getmedicineListEndpoint;
   var response = await http.post(
      Uri.parse(getmedicinelisturl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

   
}