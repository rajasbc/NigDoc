import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/DischargeSummary/Category.dart';
import 'package:nigdoc/DischargeSummary/Group.dart';
import 'package:nigdoc/DischargeSummary/summary.dart';
import '../../AppWidget/common/Colors.dart'as custom_color;

class dischargesummary extends StatefulWidget {
  const dischargesummary({super.key});

  @override
  State<dischargesummary> createState() => _dischargesummaryState();
}

class _dischargesummaryState extends State<dischargesummary> {
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
          title: Text('Discharge Summary',style: TextStyle(color: Colors.white),),
          backgroundColor:custom_color.appcolor ,
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
          
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                     SizedBox(height: screenHeight*0.2,),
                     SizedBox(width: screenWidth*0.15,),
                    InkWell(
                                          child: Container(
                                            height: screenHeight * 0.1567,
                                            width: screenWidth * 0.30,
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
                                                          'Add Category',
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
                                                    child: Image.asset('assets/menu.png'),
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
                                                  builder: (context) => categorylist(),
                                                ));
                                          },
                                        ),
                                        SizedBox(width: screenWidth*0.1,),
                                        InkWell(
                                      child: Container(
                                        height: screenHeight * 0.1567,
                                        width: screenWidth * 0.30,
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
                                                      'Add Groups',
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
                                                child: Image.asset('assets/addgroup.png'),
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
                                              builder: (context) => grouplist(),
                                            ));
                                      },
                                    ),
                  ],
                ),
                Row(
                  children: [
                     SizedBox(width: screenWidth*0.15,),
                    InkWell(
                                          child: Container(
                                            height: screenHeight * 0.1567,
                                            width: screenWidth * 0.30,
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
                                                          'Summary',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    )),
                                                    // SizedBox(width: screenWidth*0.8,),
                                                Container(
                                                  // color: Colors.amber,
                                                  height: screenHeight * 0.1,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Image.asset('assets/summary.png'),
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
                                                  builder: (context) => Discharge_summery(),
                                                ));
                                          },
                                        ),
                  ],
                ),
              ],
            ),
          )),
      ));
  }
}