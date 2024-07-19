import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart'as custom_color;

class PharmacyList extends StatefulWidget {
  const PharmacyList({super.key});

  @override
  State<PharmacyList> createState() => _PharmacyListState();
}

class _PharmacyListState extends State<PharmacyList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  var list;
  var accesstoken;
  var Pharmacylist;
  bool isloading=false;
  @override
  void initState() {
    var userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];
    getMediAndLabNameList();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 50;
    double screenWidth = MediaQuery.of(context).size.width;
    return new WillPopScope(
        onWillPop: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Setting(),
              ));
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'Pharmacy List',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor:custom_color.appcolor ,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setting(),
                    ));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body:isloading? Container(
            height: screenHeight,
            width: screenWidth,
            child:Helper().isvalidElement(Pharmacylist)&&Pharmacylist.length>0? Container(
                height: screenHeight * 0.75,
                width: screenWidth,
                padding: EdgeInsets.all(5),
                child: ListView.builder(
                    // shrinkWrap: true,
                    itemCount: Pharmacylist.length,
                    itemBuilder: (BuildContext context, int index) {
                      list = index + 1;
                      var data=Pharmacylist[index];
                      return Container(
                        child: Column(
                          children: [
                            Card(
                                color: index % 2 == 0
                                    ? custom_color.lightcolor
                                    : Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Name:',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text("${data['pharmacy_name']}"),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Mobile : ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // Text("9876543210"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Email :',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // Text("Saveetha@gmail.com"),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'City : ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // Text("Dharmapuri"),
                                              ],
                                            ),
                                          ],
                                        ),
                                         SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Address :',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // Text("qwertyui8o9pdfg"),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Status: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text("${data['status'].toString()}",style: TextStyle(color: data['status'].toString().toLowerCase()=='enabled'?Colors.green:Colors.red),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      );
                    })):Center(child:Text('No Data Found')),
          ):Center(child: SpinLoader()),
        ));
  }
  getMediAndLabNameList() async {
    var data = {
      "type":'pharmacy',
    };
    var List = await PatientApi().getMediAndLabNameList(accesstoken, data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        isloading=true;
        Pharmacylist = List['list'];
        // var values = MediAndLabNameList;
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }
}
