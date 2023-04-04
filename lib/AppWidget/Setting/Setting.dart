import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/Cancelledbill.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/Paidbill.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/Pendingbilllist.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/veiw/DoctorList.dart';
import 'package:nigdoc/AppWidget/InjectionList/InjectionList.dart';
import 'package:nigdoc/AppWidget/LabLink/LabList.dart';
import 'package:nigdoc/AppWidget/Medicine/MedicineList.dart';
import 'package:nigdoc/AppWidget/PharmacyLink/PharmacyList.dart';
import 'package:nigdoc/AppWidget/Shop/View/ClinicConfiguration.dart';
import 'package:nigdoc/AppWidget/Shop/View/ClinicProfile.dart';
import 'package:nigdoc/AppWidget/StaffWidget/veiw/StaffList.dart';
import 'package:nigdoc/AppWidget/TestList/TestList.dart';
import 'package:nigdoc/AppWidget/TreatmentWidget/treatment.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height - 50;
    double screenWidth = MediaQuery.of(context).size.width;
    return new WillPopScope( onWillPop: () async {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Dash(),)
         );
         return true;
        },
        child:Scaffold( resizeToAvoidBottomInset: false,
          appBar: AppBar(title: Text('Settings',
          style: TextStyle(color: Colors.white),),
          backgroundColor: custom_color.appcolor,
          leading: IconButton(onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Dash(),)
         );
          }, icon: Icon(Icons.arrow_back,
          color: Colors.white,),),
          
          ),
          body:Container(
            height: screenHeight,
            width: screenWidth,
            // color: Colors.amber,
            child:Column(
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
                            height: screenHeight * 0.1567,
                            width: screenWidth * 0.27,
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: custom_color.appcolor,
                                        // border: width != 0 ?
                                        // Border.all(width: 2, color:custom_color.app_color1 )
                                        // : Border(),
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
                                          'Profile',
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
                                    child: Image.asset('assets/profile.png'),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: custom_color.lightcolor,
                              // border: width != 0 ?
                              // Border.all(width: 2, color:custom_color.app_color1 )
                              // : Border(),
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
                                  builder: (context) => ClinicProfile(),
                                ));
                          },
                        ),
                        InkWell(
                          child: Container(
                            height: screenHeight * 0.1567,
                            width: screenWidth * 0.27,
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: custom_color.appcolor,
                                        // border: width != 0 ?
                                        // Border.all(width: 2, color:custom_color.app_color1 )
                                        // : Border(),
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
                                          'Config',
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
                                    child: Image.asset('assets/configuration.png'),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: custom_color.lightcolor,
                              // border: width != 0 ?
                              // Border.all(width: 2, color:custom_color.app_color1 )
                              // : Border(),
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
                                  offset:
                                      Offset(0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                            onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClinicConfig(),
                                ));
                          },
                        ),
                        InkWell(
                          child: Container(
                            height: screenHeight * 0.1567,
                            width: screenWidth * 0.27,
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: custom_color.appcolor,
                                        // border: width != 0 ?
                                        // Border.all(width: 2, color:custom_color.app_color1 )
                                        // : Border(),
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
                                          'Treatment',
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
                                    child: Image.asset('assets/treatment.png'),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: custom_color.lightcolor,
                              // border: width != 0 ?
                              // Border.all(width: 2, color:custom_color.app_color1 )
                              // : Border(),
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
                                  offset:
                                      Offset(0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                            onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TreatmentList(),
                                ));
                          },
                        ),

                        // Text(
                        //   "Collection",
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold, fontSize: 17,letterSpacing: 0.8),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                   SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: Container(
                            height: screenHeight * 0.1567,
                            width: screenWidth * 0.25,
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: custom_color.appcolor,
                                        // border: width != 0 ?
                                        // Border.all(width: 2, color:custom_color.app_color1 )
                                        // : Border(),
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
                                          'Injection',
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
                                    child: Image.asset('assets/injection.png'),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: custom_color.lightcolor,
                              // border: width != 0 ?
                              // Border.all(width: 2, color:custom_color.app_color1 )
                              // : Border(),
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
                                  builder: (context) => LabList(),
                                ));
                          },
                        ),
                        InkWell(
                          child: Container(
                            height: screenHeight * 0.1567,
                            width: screenWidth * 0.25,
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: custom_color.appcolor,
                                        // border: width != 0 ?
                                        // Border.all(width: 2, color:custom_color.app_color1 )
                                        // : Border(),
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
                                          '  Staff  ',
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
                                    child: Image.asset('assets/staff.png'),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: custom_color.lightcolor,
                              // border: width != 0 ?
                              // Border.all(width: 2, color:custom_color.app_color1 )
                              // : Border(),
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
                                  offset:
                                      Offset(0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                            onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StaffList(),
                                ));
                          },
                        ),
                        InkWell(
                          child: Container(
                            height: screenHeight * 0.1567,
                            width: screenWidth * 0.25,
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: custom_color.appcolor,
                                        // border: width != 0 ?
                                        // Border.all(width: 2, color:custom_color.app_color1 )
                                        // : Border(),
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
                                          'Doctor',
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
                                    child: Image.asset('assets/doctor.png'),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: custom_color.lightcolor,
                              // border: width != 0 ?
                              // Border.all(width: 2, color:custom_color.app_color1 )
                              // : Border(),
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
                                  offset:
                                      Offset(0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                            onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorList(),
                                ));
                          },
                        ),

                       
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                   SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       InkWell(
                  //         child: Container(
                  //           height: screenHeight * 0.1567,
                  //           width: screenWidth * 0.25,
                  //           child: Column(
                  //             children: [
                  //               Padding(
                  //                   padding: const EdgeInsets.only(top: 8),
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                       color: custom_color.appcolor,
                  //                       // border: width != 0 ?
                  //                       // Border.all(width: 2, color:custom_color.app_color1 )
                  //                       // : Border(),
                  //                       borderRadius: BorderRadius.only(
                  //                           topLeft: Radius.circular(10),
                  //                           topRight: Radius.circular(10),
                  //                           bottomLeft: Radius.circular(10),
                  //                           bottomRight: Radius.circular(10)),
                  //                       boxShadow: [
                  //                         BoxShadow(
                  //                           color: Colors.grey.withOpacity(0.2),
                  //                           spreadRadius: 4,
                  //                           blurRadius: 4,
                  //                           offset: Offset(0,
                  //                               1), // changes position of shadow
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child: Text(
                  //                         'Test Report',
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   )),
                  //               Container(
                  //                 // color: Colors.amber,
                  //                 height: screenHeight * 0.1,
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.all(8.0),
                  //                   child: Image.asset('assets/test report.png'),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //           decoration: BoxDecoration(
                  //             color: custom_color.lightcolor,
                  //             // border: width != 0 ?
                  //             // Border.all(width: 2, color:custom_color.app_color1 )
                  //             // : Border(),
                  //             borderRadius: BorderRadius.only(
                  //                 topLeft: Radius.circular(10),
                  //                 topRight: Radius.circular(10),
                  //                 bottomLeft: Radius.circular(10),
                  //                 bottomRight: Radius.circular(10)),
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.grey.withOpacity(0.2),
                  //                 spreadRadius: 4,
                  //                 blurRadius: 4,
                  //                 offset: Offset(
                  //                     0, 1), // changes position of shadow
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         onTap: () {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                 builder: (context) => TestList(),
                  //               ));
                  //         },
                  //       ),
                  //       InkWell(
                  //         child: Container(
                  //           height: screenHeight * 0.1567,
                  //           width: screenWidth * 0.25,
                  //           child: Column(
                  //             children: [
                  //               Padding(
                  //                   padding: const EdgeInsets.only(top: 8),
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                       color: custom_color.appcolor,
                  //                       // border: width != 0 ?
                  //                       // Border.all(width: 2, color:custom_color.app_color1 )
                  //                       // : Border(),
                  //                       borderRadius: BorderRadius.only(
                  //                           topLeft: Radius.circular(10),
                  //                           topRight: Radius.circular(10),
                  //                           bottomLeft: Radius.circular(10),
                  //                           bottomRight: Radius.circular(10)),
                  //                       boxShadow: [
                  //                         BoxShadow(
                  //                           color: Colors.grey.withOpacity(0.2),
                  //                           spreadRadius: 4,
                  //                           blurRadius: 4,
                  //                           offset: Offset(0,
                  //                               1), // changes position of shadow
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child: Text(
                  //                         'Injection',
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   )),
                  //               Container(
                  //                 // color: Colors.amber,
                  //                 height: screenHeight * 0.1,
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.all(8.0),
                  //                   child: Image.asset('assets/injection.png'),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //           decoration: BoxDecoration(
                  //             color: custom_color.lightcolor,
                  //             // border: width != 0 ?
                  //             // Border.all(width: 2, color:custom_color.app_color1 )
                  //             // : Border(),
                  //             borderRadius: BorderRadius.only(
                  //                 topLeft: Radius.circular(10),
                  //                 topRight: Radius.circular(10),
                  //                 bottomLeft: Radius.circular(10),
                  //                 bottomRight: Radius.circular(10)),
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.grey.withOpacity(0.2),
                  //                 spreadRadius: 4,
                  //                 blurRadius: 4,
                  //                 offset:
                  //                     Offset(0, 1), // changes position of shadow
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //           onTap: () {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                 builder: (context) => InjectionList(),
                  //               ));
                  //         },
                  //       ),
                  //       InkWell(
                  //         child: Container(
                  //           height: screenHeight * 0.1567,
                  //           width: screenWidth * 0.25,
                  //           child: Column(
                  //             children: [
                  //               Padding(
                  //                   padding: const EdgeInsets.only(top: 8),
                  //                   child: Container(
                  //                     decoration: BoxDecoration(
                  //                       color: custom_color.appcolor,
                  //                       // border: width != 0 ?
                  //                       // Border.all(width: 2, color:custom_color.app_color1 )
                  //                       // : Border(),
                  //                       borderRadius: BorderRadius.only(
                  //                           topLeft: Radius.circular(10),
                  //                           topRight: Radius.circular(10),
                  //                           bottomLeft: Radius.circular(10),
                  //                           bottomRight: Radius.circular(10)),
                  //                       boxShadow: [
                  //                         BoxShadow(
                  //                           color: Colors.grey.withOpacity(0.2),
                  //                           spreadRadius: 4,
                  //                           blurRadius: 4,
                  //                           offset: Offset(0,
                  //                               1), // changes position of shadow
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child: Text(
                  //                         'Treatment',
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   )),
                  //               Container(
                  //                 // color: Colors.amber,
                  //                 height: screenHeight * 0.1,
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.all(8.0),
                  //                   child: Image.asset('assets/treatment.png'),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //           decoration: BoxDecoration(
                  //             color: custom_color.lightcolor,
                  //             // border: width != 0 ?
                  //             // Border.all(width: 2, color:custom_color.app_color1 )
                  //             // : Border(),
                  //             borderRadius: BorderRadius.only(
                  //                 topLeft: Radius.circular(10),
                  //                 topRight: Radius.circular(10),
                  //                 bottomLeft: Radius.circular(10),
                  //                 bottomRight: Radius.circular(10)),
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.grey.withOpacity(0.2),
                  //                 spreadRadius: 4,
                  //                 blurRadius: 4,
                  //                 offset:
                  //                     Offset(0, 1), // changes position of shadow
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //           onTap: () {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                 builder: (context) => TreatmentList(),
                  //               ));
                  //         },
                  //       ),

                  //       // Text(
                  //       //   "Collection",
                  //       //   style: TextStyle(
                  //       //       fontWeight: FontWeight.bold, fontSize: 17,letterSpacing: 0.8),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: screenHeight*0.4,
                    width: screenWidth,
                    // color: Color.fromARGB(255, 48, 112, 134),
                    // child: Image.asset('assets/doctor.gif',fit: BoxFit.fill,),
                  )
                
              ],
            )
          )


        ));
  }
}