import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/Api.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/veiw/AddDoctor.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart'as custom_color;

class DoctorList extends StatefulWidget {
  const DoctorList({super.key});

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  bool isloading = false;
  var doctorlist;
  var accesstoken;

  @override
  void initState() {
    accesstoken = storage.getItem('userResponse')['access_token'];

    getdoctorlist();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Setting()),
        );
        return true;
      },
      child: Scaffold(
         appBar: AppBar(title: Text('Doctor List',
              style: TextStyle(color: Colors.white),),
              backgroundColor:custom_color.appcolor,
              leading: IconButton(onPressed: (){
                Navigator.push(
              context, MaterialPageRoute(builder: (context)=> Setting(),)
             );
              }, icon: Icon(Icons.arrow_back,
              color: Colors.white,),),
            
              ),
        // appBar: AppBar(
        //   title: Text('Doctor List'),
        //   backgroundColor:custom_color.appcolor ,
        //   // actions: [
        //   //   Padding(
        //   //     padding: const EdgeInsets.all(8.0),
        //   //     child: TextButton(
        //   //         onPressed: () {
        //   //           Navigator.push(
        //   //               context,
        //   //               MaterialPageRoute(
        //   //                 builder: (context) => AddDoctor(),
        //   //               ));
        //   //         },
        //   //         child: Text(
        //   //           "Add Doctor",
        //   //           style: TextStyle(
        //   //               color: Colors.white,
        //   //               fontSize: 12,
        //   //               fontWeight: FontWeight.bold),
        //   //         ),
        //   //         style: ButtonStyle(
        //   //             backgroundColor:
        //   //                 WidgetStateProperty.all<Color>(Colors.green),
        //   //             shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        //   //                 RoundedRectangleBorder(
        //   //                     borderRadius: BorderRadius.circular(18.0),
        //   //                     side: BorderSide(color: Colors.green))))),
        //   //   ),
        //   // ],
        // ),
        body:isloading? Container(
            child: Helper().isvalidElement(doctorlist) && doctorlist.length > 0
                ? ListView.builder(
                    itemCount: doctorlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = doctorlist[index];
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: screenWidth * 0.5,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Name :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text('${data['name'].toString()}')
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                'Phone :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text('${data['contact_no'].toString()}')
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: screenWidth * 0.55,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Address :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text('${data['address'].toString()}')
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                'userlevel :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text('${data['user_type'].toString()}')
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(1.0),
                                  //   child: Row(
                                  //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Container(
                                  //           width: screenWidth * 0.55,
                                  //           child: Row(
                                  //             children: [
                                  //               Text(
                                  //                 'Organisation :',
                                  //                 style: TextStyle(
                                  //                     fontWeight:
                                  //                         FontWeight.bold),
                                  //               ),
                                  //               Text('${data[''].toString()}')
                                  //             ],
                                  //           )),
                                  //       Row(
                                  //         children: [
                                  //           Text(
                                  //             'City :',
                                  //             style: TextStyle(
                                  //                 fontWeight: FontWeight.bold),
                                  //           ),
                                  //           Text('${data[''].toString()}')
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text('${data['email'].toString()}')
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                : Center(child: Text('No Data Found'))):Center(child: SpinLoader(),
                ),
            //      floatingActionButton: FloatingActionButton(onPressed: (){
            // Navigator.push(context,MaterialPageRoute(builder: (context)=>AddDoctor()));
            // },
            // child: Icon(Icons.add,
            // size: 30,
            // color: Colors.white,),
            // backgroundColor: custom_color.appcolor,
            // ),
     
      ),
    );
  }

  getdoctorlist() async {
   
    doctorlist = await api().getdoctorlist(accesstoken);
    if (Helper().isvalidElement(doctorlist) &&
        Helper().isvalidElement(doctorlist['status']) &&
        doctorlist['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      doctorlist = doctorlist['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isloading = true;
      });
    }
  }
}
