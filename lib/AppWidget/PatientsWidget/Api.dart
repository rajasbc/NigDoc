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
    var response = await http.get(
      Uri.parse(patientlisturl),
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


add_patient(access_token,patient_details) async {
    String addpatienturl = requestpath.base_url + requestpath.apppatientEndpoint;
    var response = await http.post(Uri.parse(addpatienturl),
        body: jsonEncode(patient_details), headers: _setHeaders(access_token));
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
  medicineList(access_token,data) async {
    String medicinelisturl = requestpath.base_url + requestpath.medicinelist;
   var response = await http.post(
      Uri.parse(medicinelisturl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  Deletemedicine(access_token,data) async {
    String deletemedicinelisturl = requestpath.base_url + requestpath.deletemedicine;
   var response = await http.post(
      Uri.parse(deletemedicinelisturl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

   getReferralList(access_token,data) async{
    String getReferralList =requestpath.base_url + requestpath.ReferralListEndpoint;
    var response = await http.post(
      Uri.parse(getReferralList),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
      if(response.statusCode==200){
        return json.decode(response.body);
      }else{
        return json.decode(response.body);
      }
  }

  getinjectionList(access_token) async {
    String getinjectionlisturl = requestpath.base_url + requestpath.getinjectionEndpoint;
   var response = await http.get(
      Uri.parse(getinjectionlisturl),      
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  add_prescription(accesstoken, Prescription_data) async {
    String addprescriptionurl = requestpath.base_url + requestpath.postprescriptionEndpoint;
    var response = await http.post(Uri.parse(addprescriptionurl),
        body: jsonEncode(Prescription_data), headers: _setHeaders(accesstoken));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
 
  add_medicine(access_token,data) async {
    String addmedicineurl = requestpath.base_url + requestpath.addmedicine;
    var response = await http.post(Uri.parse(addmedicineurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   Editmedicine(access_token,data) async {
    String editmedicineurl = requestpath.base_url + requestpath.editmedicine;
    var response = await http.post(Uri.parse(editmedicineurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   getdepartmentlist(access_token) async {
    String departmenturl = requestpath.base_url + requestpath.department;
    var response = await http.get(
      Uri.parse(departmenturl),
        headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  Adddepartment(access_token,data) async {
    String adddepartmenturl = requestpath.base_url + requestpath.adddepartment;
    var response = await http.post(Uri.parse(adddepartmenturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  Editdepartment(access_token,data) async {
    String editdepartmenturl = requestpath.base_url + requestpath.editdepartment;
    var response = await http.post(Uri.parse(editdepartmenturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  getProfile(access_token) async {
    String profileurl = requestpath.base_url + requestpath.Docprofile;
    var response = await http.get(
      Uri.parse(profileurl),
        headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  Editprofile(access_token,data) async {
    String editprofileurl = requestpath.base_url + requestpath.editprofile;
    var response = await http.post(Uri.parse(editprofileurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  add_injection(access_token,data) async {
    String addinjectionurl = requestpath.base_url + requestpath.addinjection;
    var response = await http.post(Uri.parse(addinjectionurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  Editinjection(access_token,data) async {
    String editinjectionurl = requestpath.base_url + requestpath.editinjection;
    var response = await http.post(Uri.parse(editinjectionurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   Deleteinjection(access_token,data) async {
    String deleteinjectionurl = requestpath.base_url + requestpath.deleteinjection;
   var response = await http.post(
      Uri.parse(deleteinjectionurl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }


getTreatmentList(access_token) async{
    String Treatmentlisturl = requestpath.base_url + requestpath.TreatmentListEndpoint;
    var response = await http.get(Uri.parse(Treatmentlisturl),
     headers: _setHeaders(access_token)
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }


AddTreatment(access_token,data) async{
    String addtreatmenturl = requestpath.base_url + requestpath.addtreatmentEndpoint;
    var response = await http.post(Uri.parse(addtreatmenturl),
     body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  EditTreatment(access_token,data) async{
    String edittreatmenturl = requestpath.base_url + requestpath.edittreatmentEndpoint;
    var response = await http.post(Uri.parse(edittreatmenturl),
    body: jsonEncode(data), headers: _setHeaders(access_token)
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }



getMedicineList(access_token,data) async {
    String getmedicinelisturl = requestpath.base_url + requestpath.medicinelist;
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
  getdepartmentList(access_token) async{
    String getdepartmenturl = requestpath.base_url + requestpath.getdepartmentEndpoint;
    var response = await http.get(
      Uri.parse(getdepartmenturl),      
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
}