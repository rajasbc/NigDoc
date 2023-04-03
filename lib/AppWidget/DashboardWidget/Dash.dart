import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/Cancelledbill.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/Paidbill.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/Pendingbilllist.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/DashboardApi.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Nigdocmenubar.dart';
import 'package:nigdoc/AppWidget/Medicine/MedicineList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/veiw/PatientList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/veiw/PrescriptionPage.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class Dash extends StatefulWidget {
  const Dash({super.key});

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  var bottomNav = 'home';
  final List<String> images = [
    'assets/banner1.png',
    'assets/banner2.jpg',
    'assets/banner3.png',
  ];

  var userResponse;
  var accesstoken;
  var DashboardList;
  @override
  void initState() {
     getvalue();
    // userResponse = storage.getItem('userResponse');
    // accesstoken= userResponse['access_token'];
    

    // TODO: implement initState
    super.initState();
  } 
  getvalue() async {
    userResponse = storage.getItem('userResponse');
    accesstoken= await userResponse['access_token'];
    getDashBoardList();

  }
  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 50;
    double screenWidth = MediaQuery.of(context).size.width;
    return new WillPopScope(
       onWillPop: () async {
        exit(0);
       },
      child: Scaffold(
        // drawer: SafeArea(
        //     child: Drawer(
        //   elevation: 50,
        //   child: Nigdocmenubar(),
        // )),
        appBar: AppBar(
           automaticallyImplyLeading: false,
          //  elevation: 0,
          // backgroundColor: Color.fromARGB(255, 8, 122, 135),
          // backgroundColor: HexColor('#C2DED1'),
          // backgroundColor: Colors.white,
          title: const Text(
            'NigDoctor',
            style: TextStyle(color: Colors.white),
          ),
          // iconTheme: IconThemeData(color: custom_color.app),
          backgroundColor: custom_color.appcolor,
              //  leading: IconButton(
              //   onPressed: () {
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //       builder: (context) => VistedLab(),
              //     //     ));
              //   },
              //   icon: Icon(
              //     Icons.arrow_back_ios_new_outlined,
              //     color: custom_color.appcolor,
              //   )),
          actions: [
            IconButton(
                // onPressed: () {
                //   Helper().appLogoutCall(context, 'logout');
                // },
                onPressed: () {
                  Alert(
      context: context,
      
      style: alertStyle,
      type: AlertType.warning,
     
      title: "LOGOUT ALERT",
      desc: "Are you sure you want to Logout?",
      buttons: [
        DialogButton(
          child: Text(
            "YES",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Helper().appLogoutCall(context, 'logout'),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            " No ",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
                  // showDialog(
                  //   context: context,
                  //   builder: (ctx) => AlertDialog(
                  //     title: const Text("Logout Alert"),
                  //     content: const Text("Are you sure you want to Logout?"),
                  //     actions: <Widget>[
                  //       TextButton(
                  //         onPressed: () {
                  //           Navigator.of(ctx).pop();
                  //           //  Helper().appLogoutCall(context, 'logout');
                  //         },
                  //         child: Container(
                  //           // color: Colors.green,
                  //           padding: const EdgeInsets.all(14),
                  //           child: const Text("No"),
                  //         ),
                  //       ),
                  //       TextButton(
                  //         onPressed: () {
                  //           // Navigator.of(ctx).pop();
                  //           Helper().appLogoutCall(context, 'logout');
                  //         },
                  //         child: Container(
                  //           // color: Colors.green,
                  //           padding: const EdgeInsets.all(14),
                  //           child: const Text("Yes"),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // );
                },
                icon: Icon(Icons.logout)),
            // on(onPressed: getAllCustomers, icon: Icon(Icons.category))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                
                width: screenWidth,
                color: custom_color.lightcolor,
                child: Container(
                  height: screenHeight * 0.25,
                  decoration: BoxDecoration(),
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider.builder(
                      itemCount: images.length,
                      itemBuilder: (context, index, realIdx) {
                        return GestureDetector(
                          child: Center(
                            child: Image(
                              // height: screenHeight * 0.5,
                              image: AssetImage(images[index]),
                              fit: BoxFit.contain,
                            ),
                            // fit: BoxFit.cover, width: 1000)
                          ),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Container(
                      child: Row(
                        children: [ 
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Monthly Report",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 0.8,
                                color: custom_color.appcolor),
                          ),
                        ],
                      ),
                    ),
                   
                          // Text(
                          //   "Monthly Report",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.bold, fontSize: 16),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      height: screenHeight * 0.192,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenWidth * 0.40,
                              // height: screenHeight * 0.07,
                              decoration: Helper().ContainerShowdow(0, 'no'),
                              padding: const EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: screenWidth * 0.44,
                                      child: Text(
                                        'Patient Count',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        width: screenWidth * 0.44,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Helper().isvalidElement(DashboardList)&&
                                           Helper().isvalidElement(DashboardList['Patient_count'])? Text(
                                              '  ${DashboardList['Patient_count'].toString()}',
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ):SpinLoader()
                                            // Text('0',
                                            //     textAlign: TextAlign.end,
                                            //     style: TextStyle(
                                            //         fontSize: 18,
                                            //         fontWeight: FontWeight.bold)),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenWidth * 0.4,
                              height: screenHeight * 0.1,
                              decoration: Helper().ContainerShowdow(0, 'no'),
                              padding: const EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: screenWidth * 0.44,
                                      child: Text(
                                        'Prescription Count',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        width: screenWidth * 0.44,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Helper().isvalidElement(DashboardList)&&
                                             Helper().isvalidElement(DashboardList['prescription_count'])? Text(
                                              '  ${DashboardList['prescription_count'].toString()}',
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ):SpinLoader()
                                            // Text('0',
                                            //     textAlign: TextAlign.end,
                                            //     style: TextStyle(
                                            //         fontSize: 18,
                                            //         fontWeight: FontWeight.bold)),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenWidth * 0.4,
                              height: screenHeight * 0.1,
                              decoration: Helper().ContainerShowdow(0, 'no'),
                              padding: const EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: screenWidth * 0.44,
                                      child: Text(
                                        'Appointment Count',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        width: screenWidth * 0.44,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Helper().isvalidElement(DashboardList)&&
                                            Helper().isvalidElement(DashboardList['appointment_list'])? Text(
                                              '  ${DashboardList['appointment_list'].toString()}',
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ):SpinLoader()
                                            // Text('0',
                                            //     textAlign: TextAlign.end,
                                            //     style: TextStyle(
                                            //         fontSize: 18,
                                            //         fontWeight: FontWeight.bold)),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenWidth * 0.4,
                              height: screenHeight * 0.1,
                              decoration: Helper().ContainerShowdow(0, 'no'),
                              padding: const EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: screenWidth * 0.44,
                                      child: Text(
                                        'Pending Appointment Count',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        width: screenWidth * 0.44,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Helper().isvalidElement(DashboardList)&&
                                            Helper().isvalidElement(DashboardList['pending_appoint'])? Text(
                                              '  ${DashboardList['pending_appoint'].toString()}',
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ):SpinLoader()
                                            // Text('0',
                                            //     textAlign: TextAlign.end,
                                            //     style: TextStyle(
                                            //         fontSize: 18,
                                            //         fontWeight: FontWeight.bold)),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Collection",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 0.8,
                                color: custom_color.appcolor),
                          ),
                        ],
                      ),
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
                                            'Pending',
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
                                      child: Image.asset('assets/pending.png'),
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
                                    builder: (context) => Pendingbilllist(),
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
                                            '  Paid  ',
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
                                      child: Image.asset('assets/paid.png'),
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
                                    builder: (context) => paidbilllist(),
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
                                            'Cancel',
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
                                      child: Image.asset('assets/cancel.png'),
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
                                    builder: (context) => Cancelledbill(),
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
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Report",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 0.8,
                                color: custom_color.appcolor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                     
                      width: screenWidth*0.95,
                      height: screenHeight*0.075,
                      
                      

                      child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 0.2,),
                          // Text('  Add New Prescription',style: TextStyle(color:custom_color.appcolor,fontWeight: FontWeight.bold,fontSize:22, ),),
                          // Icon(Icons.add,size: 50,color: Colors.white,),
                          
                        ],
    
                      ),
                       decoration: BoxDecoration(
                                color:custom_color.lightcolor,
                                border: 
                                Border.all(width: 3, color:custom_color.appcolor ),
                               
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
    
                    )
                    
    
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: custom_color.appcolor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PrescriptionPage()));
          },
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 5,
            child: Container(
              height: screenHeight * 0.07,
              width: screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    splashColor: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(Icons.home,
                              color: bottomNav == 'home'
                                  ? Colors.blue
                                  : Colors.black),
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: bottomNav == 'home'
                                  ? Colors.blue
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    onTap: () {
                      this.setState(() {
                        bottomNav = 'home';
                      });
                    },
                  ),
                  InkWell(
                    splashColor: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(Icons.people_alt_outlined,
                              color: bottomNav == 'customer'
                                  ? Colors.blue
                                  : Colors.black),
                        ),
                        Text(
                          'Patient',
                          style: TextStyle(
                              color: bottomNav == 'customer'
                                  ? Colors.blue
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    onTap: () {
                      this.setState(() {
                        bottomNav = 'customer';
                      });
                      Navigator.push(
                              context,
    
                              MaterialPageRoute(
                                  builder: (context) => const PatientList()),
                            );
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    splashColor: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(Icons.medical_information_outlined,
                              color: bottomNav == 'medicine'
                                  ? Colors.blue
                                  : Colors.black),
                        ),
                        Text(
                          'Medicine',
                          style: TextStyle(
                              color: bottomNav == 'medicine'
                                  ? Colors.blue
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    onTap: () {
                      this.setState(() {
                        bottomNav = 'product';
                      });
                      Navigator.push(
                              context,
    
                              MaterialPageRoute(
                                  builder: (context) => const MedicineList()),
                            );
                    },
                  ),
                  InkWell(
                    onTap: () {
                      this.setState(() {
                        bottomNav = 'setting';
                      });
                       Navigator.push(
                              context,
    
                              MaterialPageRoute(
                                  builder: (context) => const Setting()),
                            );
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(
                            Icons.settings,
                            color: bottomNav == 'setting'
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                        Text(
                          'Setting',
                          style: TextStyle(
                              color: bottomNav == 'setting'
                                  ? Colors.blue
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
   getDashBoardList() async {
    

    var List = await DashboardApi().getdeshboardList(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
       
       DashboardList = List['list'];
        // MedicineLoader=true;
        // valid=true;
      });
    
    }
  }
  var alertStyle = AlertStyle(
    
      animationType: AnimationType.fromBottom,
      isCloseButton: false,
      
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.center,
      animationDuration: Duration(milliseconds: 300),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.white,
        ),
      ),
      titleStyle: TextStyle(fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
      alertAlignment: Alignment.center,
    );
}
