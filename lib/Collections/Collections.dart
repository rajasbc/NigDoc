import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/Cancelledbill.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/Paidbill.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/Pendingbilllist.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class collection extends StatefulWidget {
  const collection({super.key});

  @override
  State<collection> createState() => _collectionState();
}

class _collectionState extends State<collection> {
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
              'Collections',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    
                                    InkWell(
                                      child: Container(
                                        // height: screenHeight * 0.1500,
                                        width: screenWidth * 0.30,
                                        child: Column(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        custom_color.appcolor,
                                                    // border: width != 0 ?
                                                    // Border.all(width: 2, color:custom_color.app_color1 )
                                                    // : Border(),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        spreadRadius: 4,
                                                        blurRadius: 4,
                                                        offset: Offset(0,
                                                            1), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Pending',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )),
                                            Container(
                                              // color: Colors.amber,
                                              height: screenHeight * 0.1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                    'assets/pending.png'),
                                              ),
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          // color: custom_color.lightcolor,
                                          color: Colors.white,
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
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 4,
                                              blurRadius: 4,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Pendingbilllist(),
                                            ));
                                      },
                                    ),
                                    InkWell(
                                      child: Container(
                                        // height: screenHeight * 0.1567,
                                        width: screenWidth * 0.30,
                                        child: Column(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        custom_color.appcolor,
                                                    // border: width != 0 ?
                                                    // Border.all(width: 2, color:custom_color.app_color1 )
                                                    // : Border(),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        spreadRadius: 4,
                                                        blurRadius: 4,
                                                        offset: Offset(0,
                                                            1), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '  Paid  ',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )),
                                            Container(
                                              // color: Colors.amber,
                                              height: screenHeight * 0.1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                    'assets/paid.png'),
                                              ),
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          // color: custom_color.lightcolor,
                                          color: Colors.white,
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
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 4,
                                              blurRadius: 4,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  paidbilllist(),
                                            ));
                                      },
                                    ),
                                    InkWell(
                                      child: Container(
                                        // height: screenHeight * 0.1567,
                                        width: screenWidth * 0.30,
                                        child: Column(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        custom_color.appcolor,
                                                    // border: width != 0 ?
                                                    // Border.all(width: 2, color:custom_color.app_color1 )
                                                    // : Border(),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        spreadRadius: 4,
                                                        blurRadius: 4,
                                                        offset: Offset(0,
                                                            1), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )),
                                            Container(
                                              // color: Colors.amber,
                                              height: screenHeight * 0.1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                    'assets/cancel.png'),
                                              ),
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          // color: custom_color.lightcolor,
                                          color: Colors.white,
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
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 4,
                                              blurRadius: 4,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Cancelledbill(),
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
                  ],
                ),
              ),
            )),
      ));
  }
}