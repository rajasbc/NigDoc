import 'package:flutter/material.dart';
import 'package:nigdoc/Api/url.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/Medicine/MedicineList.dart';
import 'package:nigdoc/MedicineStock/Stock.dart';
import 'package:nigdoc/Reports/DailyCollection.dart';
import 'package:nigdoc/Reports/DepartmentWiseCollection.dart';
import 'package:nigdoc/Reports/PatientRegisterRepotr.dart';
import 'package:nigdoc/Reports/collectionreport.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class MedicineStock extends StatefulWidget {
  const MedicineStock({super.key});

  @override
  State<MedicineStock> createState() => _MedicineStockState();
}

class _MedicineStockState extends State<MedicineStock> {
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
              'Medicine & Stock',
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
                                          'Medicine List',
                                          style: TextStyle(
                                              color: Colors.white,fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                                Container(
                                  // color: Colors.amber,
                                  height: screenHeight * 0.08,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.asset(
                                        'assets/medicine.png'),
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
                                  builder: (context) => MedicineList(),
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
                                          'Stock List',
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
                                    child: Image.asset('assets/stock1.png'),
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
                                  builder: (context) => stock(),
                                ));
                          },
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
                        //                   'CollectionReport',
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
                        //               0, 1), // changes position of shadow
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => collectionreport(),
                        //         ));
                        //   },
                        // ),

                       
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
