import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nigdoc/AppWidget/Notification/AppoinmentList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/WorKingHours/AddWorkingHours.dart';
import 'package:nigdoc/WorKingHours/ClinicWorkingHoursView.dart';
import 'package:nigdoc/WorKingHours/AddDoctorLeave.dart';
import 'package:nigdoc/WorKingHours/DoctorLeaveList.dart';
import 'package:nigdoc/WorKingHours/DoctorTimeScehdule.dart';
import 'package:nigdoc/WorKingHours/EditWorkingHours.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class Workinghours extends StatefulWidget {
  const Workinghours({super.key});

  @override
  State<Workinghours> createState() => _WorkinghoursState();
}

class _WorkinghoursState extends State<Workinghours> {
  bool isLoading = false;
  var list = 0;
   var accesstoken;
  var userResponse;
 var Working_Hours;
   void initState() {
    int1();
     
   
    super.initState();
  }
  int1()async{
    accesstoken = storage.getItem('userResponse')['access_token'];
    userResponse = storage.getItem('userResponse');
    // accesstoken=userResponse['access_token'];
   
    
    await getDocWorkingHours();
  
  }
   getDocWorkingHours() async {
   var WorkingHours= await PatientApi().getDocWorkingHours(accesstoken);
    if (Helper().isvalidElement(WorkingHours) &&
        Helper().isvalidElement(WorkingHours['status']) &&
        WorkingHours['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      Working_Hours = WorkingHours['list'];
     setState(() {
       isLoading = true;
     });
    
   
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidht = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Clinic Working Hours',
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
          ),
        ),
         body: 
         isLoading ?
             Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            // color: Colors.white,
                            height: screenHeight * 0.7596,
                            child: Helper().isvalidElement(Working_Hours) &&
                                    Working_Hours.length > 0
                                ? 
                                ListView.builder(
                                    itemCount: Working_Hours.length,
                                    // itemCount:1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var data = Working_Hours[index];

                                      // var paid = data['grand_total'] - data['balance'];
                                      list=index+1;
                                      return Center(
                                        child: Container(
                                          color: index % 2 == 0
                                              ? Color.fromARGB(
                                                  255, 238, 242, 250)
                                              : Colors.white,
                                          width: screenWidht,
                                       
                                          child: Row(
                                            children: [
                                              Text(' $list. '),
                                              Container(
                                                 width: screenWidht*0.80,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        // width: screenwidht * 0.47,
                                                        child: Row(
                                                          children: [
                                                             Text(
                                                              'Day : ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),
                                                            ),
                                                            Text(
                                                                '${data['day'].toString()}')
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Opening Time : ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),
                                                            ),
                                                            Text(
                                                                '${data['open_time'].toString()}')
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        //  width: screenwidht * 0.47,
                                                        child: Row(
                                                          children: [
                                                           Text(
                                                              'Closing Time : ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),
                                                            ),
                                                            Text(
                                                                '${data['close_time'].toString()}')
                                                          ],
                                                        ),
                                                      ),
                                                    
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // Icon(Icons.menu)
                                              PopupMenuButton(
                                              itemBuilder: (context) => [
PopupMenuItem(
                                                      child: Row(
                                                        children: [
                                                          // Icon(
                                                          //   Icons.edit,
                                                          //   color:Customcolor.app_color,
                                                          // ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 0),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  // FontAwesomeIcons
                                                                  //     .usersViewfinder,
                                                                  Icons.view_day,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                                Text(
                                                                  '  View',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      onTap: (() async {
                                                        // await storage.setItem('Edit_working',data);
                                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewlist(selected_working:data)));
                                                      }),
                                                    ),
                                                PopupMenuItem(
                                                      child: Row(
                                                        children: [
                                                          // Icon(
                                                          //   Icons.edit,
                                                          //   color:Customcolor.app_color,
                                                          // ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 0),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .edit,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                                Text(
                                                                  '  Edit',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      onTap: (() async {
                                                        // await storage.setItem('Edit_working',data);
                                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Editworkinghours(selected_working:data)));
                                                      }),
                                                    ),
                                                    PopupMenuItem(
                                                      child: Row(
                                                        children: [
                                                          // Icon(
                                                          //   Icons.edit,
                                                          //   color:Customcolor.app_color,
                                                          // ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 0),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  // FontAwesomeIcons
                                                                  //     .solidFaceFlushed,
                                                                  Icons.schedule,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                                Text(
                                                                  '  Docrot Schedule',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      onTap: (() async {
                                                        // await storage.setItem('Edit_working',data);
                                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Doctortimescehdule(selected_working:data)));
                                                      }),
                                                    ),
                                                     PopupMenuItem(
                                                      child: Row(
                                                        children: [
                                                          // Icon(
                                                          //   Icons.edit,
                                                          //   color:Customcolor.app_color,
                                                          // ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 0),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.add,
                                                                  // FontAwesomeIcons
                                                                  //     .edit,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                                Text(
                                                                  '  Doctor Leave',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      onTap: (() async {
                                                        // await storage.setItem('Edit_working',data);
                                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Doctorleavelist()));
                                                      }),
                                                    ),

                                                    
                                              ]),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : Center(
                                    child: Text('No Data Found'),
                                  )
                            // :
                            // Text('Nodata'),
                            ),
                      ),
                    )
                  ],
                ),
              )
            : SpinLoader(),
             floatingActionButton: FloatingActionButton(
                          onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>Addworkinghours()));
                        },
                           child:Icon(Icons.add,
          size: 30,
          color: Colors.white,),
          backgroundColor: custom_color.appcolor,
                        ),
      )
      );
  }
}