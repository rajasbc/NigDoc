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
Editpatient(access_token,data) async{
    String editpatienturl = requestpath.base_url + requestpath.editpatient;
    var response = await http.post(Uri.parse(editpatienturl),
    body: jsonEncode(data), headers: _setHeaders(access_token)
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
 getreferralList(access_token) async{
    String getreferralurl = requestpath.base_url + requestpath.getreferralList;
    var response = await http.get(
      Uri.parse(getreferralurl),      
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  addreferralList(access_token,data) async{
    String addreferralurl = requestpath.base_url + requestpath.addreferral;
    var response = await http.post(Uri.parse(addreferralurl),
    body: jsonEncode(data), headers: _setHeaders(access_token)
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   
   Editreferral(access_token,data) async{
    String editreferralurl = requestpath.base_url + requestpath.editreferral;
    var response = await http.post(Uri.parse(editreferralurl),
    body: jsonEncode(data), headers: _setHeaders(access_token)
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

   searchlab(accesstoken, data) async {
    String searchlaburl = requestpath.base_url + requestpath.getSearchDocAndLabNameList;
    var response = await http.post(Uri.parse(searchlaburl),
        body: jsonEncode(data), headers: _setHeaders(accesstoken));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  Addlablink(access_token,data) async {
    String addlablinkurl = requestpath.base_url + requestpath.addlablink;
    var response = await http.post(Uri.parse(addlablinkurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  searchpharmacy(accesstoken, data) async {
    String searchpharmacyurl = requestpath.base_url + requestpath.getSearchDocAndPharmacyNameList;
    var response = await http.post(Uri.parse(searchpharmacyurl),
        body: jsonEncode(data), headers: _setHeaders(accesstoken));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  getprescriptionist(accesstoken, data) async {
    String prescriptionurl = requestpath.base_url + requestpath.getPrescriptionList;
    var response = await http.post(Uri.parse(prescriptionurl),
        body: jsonEncode(data), headers: _setHeaders(accesstoken));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  getprescriptionDetails(accesstoken, data) async {
    String prescriptionurl = requestpath.base_url + requestpath.getPrescriptionDetails;
    var response = await http.post(Uri.parse(prescriptionurl),
        body: jsonEncode(data), headers: _setHeaders(accesstoken));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   getDischargeSummary(accesstoken, data) async {
    String summeryurl = requestpath.base_url + requestpath.getDischargeSummary;
    var response = await http.post(Uri.parse(summeryurl),
        body: jsonEncode(data), headers: _setHeaders(accesstoken));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   getgrouplist(access_token) async {
    String grouplisturl = requestpath.base_url + requestpath.getgrouplist;
    var response = await http.get(
      Uri.parse(grouplisturl),
        headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }


  getCategory(access_token) async {
    String Category_list_url = requestpath.base_url + requestpath.getDocCategory;
    var response = await http.get(Uri.parse(Category_list_url),
        headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  // getSubcategory(access_token,) async {
  //   String subcategoryUrl = requestpath.base_url + requestpath.getDocSubCategory;
  //   var response = await http.get(Uri.parse(subcategoryUrl),
  //        headers: _setHeaders(access_token));
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else {
  //     return json.decode(response.body);
  //   }
  // }
   getSubcategory(data, accessToken, context) async {
    String subcategoryUrl = requestpath.base_url + requestpath.getDocSubCategory;
    var response = await http.post(Uri.parse(subcategoryUrl),
        body: jsonEncode(data), headers: _setHeaders(accessToken));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  addSummary(access_token,data) async {
    String addsummaryurl = requestpath.base_url + requestpath.addSummary;
    var response = await http.post(Uri.parse(addsummaryurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  Adddcategory(access_token,data) async {
    String addcategoryurl = requestpath.base_url + requestpath.addDocCategory;
    var response = await http.post(Uri.parse(addcategoryurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  editCategory(access_token,data) async {
    String editcategoryurl = requestpath.base_url + requestpath.editCategory;
    var response = await http.post(Uri.parse(editcategoryurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  deleteCategory(access_token,data) async {
    String deleteCategoryurl = requestpath.base_url + requestpath.deleteCategory;
   var response = await http.post(
      Uri.parse(deleteCategoryurl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  addDocGroup(access_token,data) async {
    String addgroupurl = requestpath.base_url + requestpath.addDocGroup;
    var response = await http.post(Uri.parse(addgroupurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  editGroup(access_token,data) async {
    String editgroupurl = requestpath.base_url + requestpath.editGroup;
    var response = await http.post(Uri.parse(editgroupurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  deleteGroup(access_token,data) async {
    String deletegroupurl = requestpath.base_url + requestpath.deleteGroup;
   var response = await http.post(
      Uri.parse(deletegroupurl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   viewgroup(access_token,data) async {
    String deletegroupurl = requestpath.base_url + requestpath.viewgroup;
   var response = await http.post(
      Uri.parse(deletegroupurl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   addSubcategory(access_token,data) async {
    String subcategoryurl = requestpath.base_url + requestpath.addSubcategory;
   var response = await http.post(
      Uri.parse(subcategoryurl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

   getGroupwisecategory(data, accessToken, context) async {
    String subcategoryUrl = requestpath.base_url + requestpath.getGroupwisecategory;
    var response = await http.post(Uri.parse(subcategoryUrl),
        body: jsonEncode(data), headers: _setHeaders(accessToken));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   deleteGroupwisecategory(access_token,data) async {
    String deletegroupCategoryurl = requestpath.base_url + requestpath.deleteGroupwisecategory;
   var response = await http.post(
      Uri.parse(deletegroupCategoryurl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  
  editSubcategory(access_token,data) async {
    String editsubcategoryUrl = requestpath.base_url + requestpath.editSubcategory;
    var response = await http.post(Uri.parse(editsubcategoryUrl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  deleteSubcategory(access_token,data) async {
    String deleteSubCategoryurl = requestpath.base_url + requestpath.deleteSubcategory;
   var response = await http.post(
      Uri.parse(deleteSubCategoryurl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  AddTest(access_token,data) async {
    String addtesturl = requestpath.base_url + requestpath.AddTest;
   var response = await http.post(
      Uri.parse(addtesturl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  getlinklablist(access_token) async{
    String gettesturl = requestpath.base_url + requestpath.getLinklabList;
    var response = await http.get(
      Uri.parse(gettesturl),      
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  Edittest(access_token,data) async {
    String edittesturl = requestpath.base_url + requestpath.EditTest;
    var response = await http.post(Uri.parse(edittesturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  getdailyreport(accesstoken, data) async {
    String dailyreporturl = requestpath.base_url + requestpath.getDailyCollection;
    var response = await http.post(Uri.parse(dailyreporturl),
        body: jsonEncode(data), headers: _setHeaders(accesstoken));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  getparientregisterreport(accesstoken, data) async {
    String patientreporturl = requestpath.base_url + requestpath.getPatientRegisterReport;
    var response = await http.post(Uri.parse(patientreporturl),
        body: jsonEncode(data), headers: _setHeaders(accesstoken));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  getcollectionreport(accesstoken, data) async {
    String collectionreporturl = requestpath.base_url + requestpath.getCollectionReport;
    var response = await http.post(Uri.parse(collectionreporturl),
        body: jsonEncode(data), headers: _setHeaders(accesstoken));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  getDepartmentWisReport(accesstoken, data) async {
    String depreporturl = requestpath.base_url + requestpath.getDepartmentWisReport;
    var response = await http.post(Uri.parse(depreporturl),
        body: jsonEncode(data), headers: _setHeaders(accesstoken));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
    getdoctorWise(accesstoken, data) async {
    String doctowiseurl = requestpath.base_url + requestpath.getDoctorwise;
    var response = await http.post(Uri.parse(doctowiseurl),
        body: jsonEncode(data), headers: _setHeaders(accesstoken));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  getDocFloor(access_token) async {
    String getfloorlisturl = requestpath.base_url + requestpath.getDocFloor;
   var response = await http.get(
      Uri.parse(getfloorlisturl),      
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  DocEditFloor(access_token,data) async {
    String editfloorurl = requestpath.base_url + requestpath.DocEditFloor;
    var response = await http.post(Uri.parse(editfloorurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  DocAddFloor(access_token,data) async {
    String addfloorurl = requestpath.base_url + requestpath.DocAddFloor;
    var response = await http.post(Uri.parse(addfloorurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
    DocDeleteFloor(access_token,data) async {
    String deletefloorlisturl = requestpath.base_url + requestpath.DocDeleteFloor;
   var response = await http.post(
      Uri.parse(deletefloorlisturl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   getDocWardList(access_token) async {
    String getwardurl = requestpath.base_url + requestpath.getDocWardList;
   var response = await http.get(
      Uri.parse(getwardurl),      
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   DocAddWard(access_token,data) async {
    String addwardurl = requestpath.base_url + requestpath.DocAddWard;
    var response = await http.post(Uri.parse(addwardurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
      DocEditWard(access_token,data) async {
    String editwardurl = requestpath.base_url + requestpath.DocEditWard;
    var response = await http.post(Uri.parse(editwardurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
    DocDeleteWard(access_token,data) async {
    String deletewardlisturl = requestpath.base_url + requestpath.DocDeleteWard;
   var response = await http.post(
      Uri.parse(deletewardlisturl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  getWardListRoom(access_token,data) async {
    String deletewardlisturl = requestpath.base_url + requestpath.getWardListRoom;
   var response = await http.post(
      Uri.parse(deletewardlisturl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
    getRoomList(access_token) async {
    String getwardurl = requestpath.base_url + requestpath.getRoomList;
   var response = await http.get(
      Uri.parse(getwardurl),      
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
      AddDocRoom(access_token,data) async {
    String addroomurl = requestpath.base_url + requestpath.AddDocRoom;
    var response = await http.post(Uri.parse(addroomurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
    getEditRoomList(access_token,data) async {
    String editroomlisturl = requestpath.base_url + requestpath.getEditRoomList;
    var response = await http.post(Uri.parse(editroomlisturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   DocEditRoom(access_token,data) async {
    String editroomurl = requestpath.base_url + requestpath.DocEditRoom;
    var response = await http.post(Uri.parse(editroomurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
    DocDeleteRoom(access_token,data) async {
    String deletewardlisturl = requestpath.base_url + requestpath.DocDeleteRoom;
   var response = await http.post(
      Uri.parse(deletewardlisturl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   getBedCategoryList(access_token) async {
    String getbedcategoryurl = requestpath.base_url + requestpath.getBedCategoryList;
   var response = await http.get(
      Uri.parse(getbedcategoryurl),      
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
    DocDeleteBedCategory(access_token,data) async {
    String deletewardlisturl = requestpath.base_url + requestpath.DocDeleteBedCategory;
   var response = await http.post(
      Uri.parse(deletewardlisturl),
      body: jsonEncode(data),
      headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
    getBedCategoryRoomList(access_token,data) async {
    String editroomlisturl = requestpath.base_url + requestpath.getBedCategoryRoomList;
    var response = await http.post(Uri.parse(editroomlisturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
    AddBedCategory(access_token,data) async {
    String addroomurl = requestpath.base_url + requestpath.AddBedCategory;
    var response = await http.post(Uri.parse(addroomurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   getAdmissionList(access_token, data) async {
    String admissionlisturl =
        requestpath.base_url + requestpath.getAdmissionList;
    var response = await http.post(Uri.parse(admissionlisturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
           if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   DocAddAppoinment(access_token,data) async {
    String addappoinmenturl = requestpath.base_url + requestpath.DocAddAppoinment;
    var response = await http.post(Uri.parse(addappoinmenturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   getSlotTimeDoctorList(access_token,data) async {
    String doctorurl = requestpath.base_url + requestpath.getSlotTimeDoctorList;
    var response = await http.post(Uri.parse(doctorurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   getSlotTime(access_token,data) async {
    String slottimeurl = requestpath.base_url + requestpath.getSlotTime;
    var response = await http.post(Uri.parse(slottimeurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
  getDocWorkingHours(access_token) async {
    String workinghoursurl = requestpath.base_url + requestpath.getDocWorkingHours;
    var response = await http.get(
      Uri.parse(workinghoursurl),
        headers: _setHeaders(access_token));
        if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   AddDocWorkingHours(access_token,data) async {
    String slottimeurl = requestpath.base_url + requestpath.AddDocWorkingHours;
    var response = await http.post(Uri.parse(slottimeurl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
   }
   getEditWorkingHoursDocList(access_token, data) async {
    String doclisturl =
        requestpath.base_url + requestpath.getEditWorkingHoursDocList;
    var response = await http.post(Uri.parse(doclisturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
           if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
     getWorkingHoursViewList(access_token, data) async {
    String viewlisturl =
        requestpath.base_url + requestpath.getWorkingHoursViewList;
    var response = await http.post(Uri.parse(viewlisturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
           if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   getDoctorScheduleList(access_token, data) async {
    String viewlisturl =
        requestpath.base_url + requestpath.getDoctorScheduleList;
    var response = await http.post(Uri.parse(viewlisturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
           if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   AddDoctorTimeSchedule(access_token,data) async {
    String addappoinmenturl = requestpath.base_url + requestpath.AddDoctorTimeSchedule;
    var response = await http.post(Uri.parse(addappoinmenturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   AddDoctorLeave(access_token,data) async {
    String addappoinmenturl = requestpath.base_url + requestpath.AddDoctorLeave;
    var response = await http.post(Uri.parse(addappoinmenturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
   getDoctorLeaveList(access_token, data) async {
    String pendinglisturl =
        requestpath.base_url + requestpath.getDoctorLeaveList;
    var response = await http.post(Uri.parse(pendinglisturl),
        body: jsonEncode(data), headers: _setHeaders(access_token));
           if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
}