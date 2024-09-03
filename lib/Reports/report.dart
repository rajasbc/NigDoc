import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/Reports/DailyCollection.dart';
import 'package:nigdoc/Reports/DepartmentWiseCollection.dart';
import 'package:nigdoc/Reports/PatientRegisterRepotr.dart';
import 'package:nigdoc/Reports/collectionreport.dart';
import '../../AppWidget/common/Colors.dart'as custom_color;

class report extends StatefulWidget {
  const report({super.key});

  @override
  State<report> createState() => _reportState();
}

class _reportState extends State<report> {
  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Dash()));
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Reports',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor:custom_color.appcolor,
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
                     Row(
                  children: [
                     SizedBox(height: screenHeight*0.2,),
                     SizedBox(width: screenWidth*0.15,),
                    InkWell(
                                          child: Container(
                                            height: screenHeight * 0.18,
                                            width: screenWidth * 0.32,
                                            child: Column(
                                              children: [
                                                Padding(
                                                    padding: const EdgeInsets.only(top: 8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: custom_color.appcolor,
                                                        // border: width != 0 ?
                                                        // Border.all(width: 2, color:custom_color.app_color1)
                                                        // : Border(),
                                                        borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(10),
                                                            topRight: Radius.circular(10),
                                                            bottomLeft: Radius.circular(10),
                                                            bottomRight: Radius.circular(10)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Colors.grey.withOpacity(0.2),
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
                                                          'Daily Collection',
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
                                                    child: Image.asset('assets/dailycollection.png'),
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
                                                  builder: (context) => dailycollection(),
                                                ));
                                          },
                                        ),
                                        SizedBox(width: screenWidth*0.1,),
                                        InkWell(
                                      child: Container(
                                        height: screenHeight * 0.18,
                                        width: screenWidth * 0.32,
                                        child: Column(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(top: 8),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: custom_color.appcolor,
                                                    // border: width != 0 ?
                                                    // Border.all(width: 2, color:custom_color.app_color1)
                                                    // : Border(),
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        topRight: Radius.circular(10),
                                                        bottomLeft: Radius.circular(10),
                                                        bottomRight: Radius.circular(10)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Colors.grey.withOpacity(0.2),
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
                                                      'Patient Register Report',
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
                                                child: Image.asset('assets/patient.png'),
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
                                              builder: (context) => patientregisterreport(),
                                            ));
                                      },
                                    ),
                  ],
                ),
                Row(
                  children: [
                     SizedBox(height: screenHeight*0.2,),
                     SizedBox(width: screenWidth*0.15,),
                    InkWell(
                                          child: Container(
                                            height: screenHeight * 0.18,
                                            width: screenWidth * 0.32,
                                            child: Column(
                                              children: [
                                                Padding(
                                                    padding: const EdgeInsets.only(top: 8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: custom_color.appcolor,
                                                        // border: width != 0 ?
                                                        // Border.all(width: 2, color:custom_color.app_color1)
                                                        // : Border(),
                                                        borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(10),
                                                            topRight: Radius.circular(10),
                                                            bottomLeft: Radius.circular(10),
                                                            bottomRight: Radius.circular(10)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Colors.grey.withOpacity(0.2),
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
                                                          'Collection Report',
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
                                                    child: Image.asset('assets/collectionreport.png'),
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
                                                  builder: (context) => collectionreport(),
                                                ));
                                          },
                                        ),
                                        SizedBox(width: screenWidth*0.1,),
                                        InkWell(
                                      child: Container(
                                        height: screenHeight * 0.18,
                                        width: screenWidth * 0.32,
                                        child: Column(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(top: 8),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: custom_color.appcolor,
                                                    // border: width != 0 ?
                                                    // Border.all(width: 2, color:custom_color.app_color1)
                                                    // : Border(),
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        topRight: Radius.circular(10),
                                                        bottomLeft: Radius.circular(10),
                                                        bottomRight: Radius.circular(10)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Colors.grey.withOpacity(0.2),
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
                                                      'Department Wise Collection',
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
                                                child: Image.asset('assets/depwise.png'),
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
                                              builder: (context) => Departmentcollection(),
                                            ));
                                      },
                                    ),
                  ],
                ),
                  ],
                ),
              ),
            )),
      ));
  }
}