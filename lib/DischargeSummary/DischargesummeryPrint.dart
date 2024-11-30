import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Prescription/PrescriptionList.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/DischargeSummary/summary.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class Dischargesummeryprint extends StatefulWidget {
  final select_discharge;
  const Dischargesummeryprint({super.key,request, this.select_discharge});

  @override
  State<Dischargesummeryprint> createState() => _DischargesummeryprintState();
}

class _DischargesummeryprintState extends State<Dischargesummeryprint> {
  var accesstoken;
  var userResponse;
  var data;
  var shop_id;
  var id;
  var categoryid;
  var patientid;
  var ID;
  var patient_id;
  String _headerSelected = "yes";
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    userResponse = await storage.getItem('userResponse');
    accesstoken = await userResponse['access_token'];
    data = widget.select_discharge;
    shop_id = userResponse['clinic_profile']['id'];
    
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
        onPopInvoked: (didPop) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Discharge_summery()));
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Discharge Summerys Print',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Discharge_summery()));
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            backgroundColor: custom_color.appcolor,
          ),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.12,
                      ),
                      Container(
                        width: screenWidth * 0.20,
                        child: Text(
                          'Header',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: screenWidth * 0.20,
                              child: Row(
                                children: [
                                  Radio(
                                    value: 'yes',
                                    groupValue: _headerSelected,
                                    activeColor: Colors.blue,
                                    onChanged: (value) {
                                      setState(() {
                                        _headerSelected = value.toString();
                                      });
                                    },
                                  ),
                                  const Text("Yes"),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth * 0.18,
                                    child: Radio(
                                      value: "no",
                                      groupValue: _headerSelected,
                                      activeColor: Colors.blue,
                                      onChanged: (value) {
                                        setState(() {
                                          _headerSelected = value.toString();
                                        });
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  const Text("No"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 65),
                    child: Text(
                      'Select Category Order To Print',
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.12,
                      ),
                      Container(
                        width: screenWidth * 0.30,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  custom_color.appcolor),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onPressed: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Discharge_summery()));
                          }),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.04,
                      ),
                      Container(
                        width: screenWidth * 0.32,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  custom_color.appcolor),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                          child: Text(
                            'Confirm',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onPressed: (() {
                            id = data['id'].toString();
                                categoryid = data['category_id'];
                                patientid = data['patient_id'].toString();
                            Codec<String, String> stringToBase64 =
                                utf8.fuse(base64);
                                 patient_id =
                                base64.encode(utf8.encode(patientid));
                                 ID =
                                base64.encode(utf8.encode(id));
                                _launchInBrowser(Uri.parse(
                                'https://nigdoc.com/users/patient_summary_details_print.php?patient_id=${patient_id}&id=${ID}&order_cat_id=${categoryid}&shop_id=${shop_id}&header=${_headerSelected}'));
                                // var u = 'https://nigdoc.com/users/patient_summary_details_print.php?patient_id=${patient_id}&id=${ID}&order_cat_id=${categoryid}&shop_id=${shop_id}&header=${_headerSelected}';
                                // print(u);
                          }),
                         ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                    ],
                  ),
                ]))))
        )
    );
  }
}