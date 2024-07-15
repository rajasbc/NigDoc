import 'package:flutter/material.dart';
//import 'package:nigdoc/AppWidget/DoctorWidget/Referral/AddReferralList.dart';
//import 'package:nigdoc/AppWidget/DoctorWidget/Referral/Edit%20Referral.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/StaffWidget/Referral/AddReferralList.dart';
import 'package:nigdoc/AppWidget/StaffWidget/Referral/EditReferral.dart';
// import 'package:nigdoc/AppWidget/AppWidget/common/Colors.dart'as custom_color;
import '../../../AppWidget/common/Colors.dart' as custom_color;

class Referral extends StatefulWidget {
  const Referral({super.key});

  @override
  State<Referral> createState() => _ReferralState();
}

var select_list;
var title = {'Name', 'Email', 'Number'};

class _ReferralState extends State<Referral> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Setting()));
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Referral List',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: custom_color.appcolor,
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
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.grey),
                  //   borderRadius: BorderRadius.circular(5.0),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              color: index % 2 == 0
                                  ? custom_color.lightcolor
                                  : Colors.white,
                              width: screenWidth,
                              // height: screenHeight * 0.20,
                              // width: screenWidth * 0.90,
                              // decoration:
                              //     BoxDecoration(border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: screenWidth*0.75,
                                      // color: Colors.red,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  // color: Colors.amber,
                                                  width: screenWidth * 0.45,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Name :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                      //  Text(
                                                      //   'Name :',
                                                      //   style: TextStyle(
                                                      //       fontWeight:
                                                      //           FontWeight.bold),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  //  width: screenWidth * 0.35,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Address :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: screenWidth * 0.45,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Pincode :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  //  width: screenWidth * 0.35,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Mobile No :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Row(
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
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Container(
                                          //   padding: const EdgeInsets.only(
                                          //       left: 320, bottom: 0, top: 0),
                                          //   child: PopupMenuButton(
                                          //     itemBuilder: (context) => [
                                          //       PopupMenuItem(
                                          //         child: Row(
                                          //           children: [
                                          //             Icon(
                                          //               Icons.edit,
                                          //               color: custom_color.appcolor,
                                          //             ),
                                          //             Padding(
                                          //               padding:
                                          //                   EdgeInsets.only(left: 10),
                                          //               child: Text(
                                          //                 'Edit',
                                          //                 style:
                                          //                     TextStyle(fontSize: 16),
                                          //               ),
                                          //             ),
                                          //           ],
                                          //         ),
                                          //         onTap: (() {
                                          //           Navigator.push(
                                          //               context,
                                          //               MaterialPageRoute(
                                          //                   builder: (context) =>
                                          //                       Edit_Referral()));
                                          //         }),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:6),
                                      child: Container(
                                         child:PopupMenuButton(
                                           itemBuilder: (context) => [
                                             PopupMenuItem(
                                               child: Row(
                                                 children: [
                                                   Icon(
                                                     Icons.edit,
                                                     color: custom_color.appcolor,
                                                   ),
                                                   Padding(
                                                     padding:
                                                         EdgeInsets.only(left: 0),
                                                     child: Text(
                                                       'Edit',
                                                       style:
                                                           TextStyle(fontSize: 16),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                               onTap: (() {
                                                 Navigator.push(
                                                     context,
                                                     MaterialPageRoute(
                                                         builder: (context) =>
                                                             Edit_Referral()));
                                               }),
                                             ),
                                           ],
                                         ),
                                        width: screenWidth*0.2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Add_referralList()));
          }),
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
          backgroundColor: custom_color.appcolor,
        ),
      ),
    );
  }
}
