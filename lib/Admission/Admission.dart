import 'package:flutter/material.dart';
import 'package:nigdoc/Admission/AdmissionList.dart';
import 'package:nigdoc/Admission/BedCategory.dart';
import 'package:nigdoc/Admission/Floor.dart';
import 'package:nigdoc/Admission/PatientAdmission.dart';
import 'package:nigdoc/Admission/Room.dart';
import 'package:nigdoc/Admission/Ward.dart';
import 'package:nigdoc/Api/url.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/Medicine/MedicineList.dart';
import 'package:nigdoc/MedicineStock/Stock.dart';
import 'package:nigdoc/Reports/DailyCollection.dart';
import 'package:nigdoc/Reports/DepartmentWiseCollection.dart';
import 'package:nigdoc/Reports/PatientRegisterRepotr.dart';
import 'package:nigdoc/Reports/collectionreport.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class Admission extends StatefulWidget {
  const Admission({super.key});

  @override
  State<Admission> createState() => _AdmissionState();
}

class _AdmissionState extends State<Admission> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Dash()));
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Admission',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: custom_color.appcolor,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dash(),
                    ));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: Container(
                            // height: screenHeight * 0.16,
                            width: screenWidth * 0.27,
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: custom_color.appcolor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 4,
                                            blurRadius: 4,
                                            offset: Offset(0,
                                                1),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Floor List',
                                          style: TextStyle(
                                              color: Colors.white,fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                                Container(
                                  // color: Colors.amber,
                                  height: screenHeight * 0.1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                        'assets/floor.png'),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: custom_color.lightcolor,
                              // color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 4,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FloorList(),
                                ));
                          },
                        ),
                        InkWell(
                          child: Container(
                            width: screenWidth * 0.27,
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: custom_color.appcolor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 4,
                                            blurRadius: 4,
                                            offset: Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Ward List',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                                Container(
                                  height: screenHeight * 0.1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset('assets/ward.png'),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: custom_color.lightcolor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 4,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Ward(),
                                ));
                          },
                        ),
                        InkWell(
                          child: Container(
                            width: screenWidth * 0.27,
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: custom_color.appcolor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 4,
                                            blurRadius: 4,
                                            offset: Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Room',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                                Container(
                                  // color: Colors.amber,
                                  height: screenHeight * 0.1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                        'assets/collectionreport.png'),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: custom_color.lightcolor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 4,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 1), 
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RoomList(),
                                ));
                          },
                        ),

                       
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight*0.02,),
                   Container(
                     child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                        
                         Padding(
                           padding: const EdgeInsets.only(left:15),
                           child: InkWell(
                                  child: Container(
                                    width: screenWidth * 0.27,
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(top: 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: custom_color.appcolor,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight: Radius.circular(10),
                                                    bottomLeft: Radius.circular(10),
                                                    bottomRight: Radius.circular(10)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.2),
                                                    spreadRadius: 4,
                                                    blurRadius: 4,
                                                    offset: Offset(0,
                                                        1), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Bed Category',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            )),
                                        Container(
                                          // color: Colors.amber,
                                          height: screenHeight * 0.09,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/bed.png'),
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      color: custom_color.lightcolor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 4,
                                          blurRadius: 4,
                                          offset: Offset(
                                              0, 1), 
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BedCategory(),
                                        ));
                                  },
                                ),
                         ),
                              // InkWell(
                              //   child: Container(
                              //     width: screenWidth * 0.27,
                              //     child: Column(
                              //       children: [
                              //         Padding(
                              //             padding: const EdgeInsets.only(top: 8),
                              //             child: Container(
                              //               decoration: BoxDecoration(
                              //                 color: custom_color.appcolor,
                              //                 borderRadius: BorderRadius.only(
                              //                     topLeft: Radius.circular(10),
                              //                     topRight: Radius.circular(10),
                              //                     bottomLeft: Radius.circular(10),
                              //                     bottomRight: Radius.circular(10)),
                              //                 boxShadow: [
                              //                   BoxShadow(
                              //                     color: Colors.grey.withOpacity(0.2),
                              //                     spreadRadius: 4,
                              //                     blurRadius: 4,
                              //                     offset: Offset(0,
                              //                         1), // changes position of shadow
                              //                   ),
                              //                 ],
                              //               ),
                              //               child: Padding(
                              //                 padding: const EdgeInsets.all(8.0),
                              //                 child: Text(
                              //                   'Patient Admission',
                              //                   style: TextStyle(
                              //                       color: Colors.white,
                              //                       fontWeight: FontWeight.bold),
                              //                 ),
                              //               ),
                              //             )),
                              //         Container(
                              //           // color: Colors.amber,
                              //           height: screenHeight * 0.1,
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: Image.asset(
                              //                 'assets/collectionreport.png'),
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //     decoration: BoxDecoration(
                              //       color: custom_color.lightcolor,
                              //       borderRadius: BorderRadius.only(
                              //           topLeft: Radius.circular(10),
                              //           topRight: Radius.circular(10),
                              //           bottomLeft: Radius.circular(10),
                              //           bottomRight: Radius.circular(10)),
                              //       boxShadow: [
                              //         BoxShadow(
                              //           color: Colors.grey.withOpacity(0.2),
                              //           spreadRadius: 4,
                              //           blurRadius: 4,
                              //           offset: Offset(
                              //               0, 1), 
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              //   onTap: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => Patientadmission(),
                              //         ));
                              //   },
                              // ),
                              Padding(
                                 padding: const EdgeInsets.only(left:22),
                                child: InkWell(
                                  child: Container(
                                    width: screenWidth * 0.27,
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(top: 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: custom_color.appcolor,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight: Radius.circular(10),
                                                    bottomLeft: Radius.circular(10),
                                                    bottomRight: Radius.circular(10)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.2),
                                                    spreadRadius: 4,
                                                    blurRadius: 4,
                                                    offset: Offset(0,
                                                        1), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Admission List',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            )),
                                        Container(
                                          // color: Colors.amber,
                                          height: screenHeight * 0.09,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/admission.png'),
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      color: custom_color.lightcolor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 4,
                                          blurRadius: 4,
                                          offset: Offset(
                                              0, 1), 
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Admissionlist(),
                                        ));
                                  },
                                ),
                              ),
                       ],
                     ),
                   ),
                ],
              ),
            ),
          )),
        ));
  }
}
