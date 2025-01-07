import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/BillingWidget/Api.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/PendingPayment.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/Api.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/Collections/Collections.dart';
import 'package:nigdoc/WorKingHours/WorkingHours.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class Viewlist extends StatefulWidget {
  final selected_working;
  const Viewlist({super.key, required this.selected_working});

  @override
  State<Viewlist> createState() => _ViewlistState();
}

class _ViewlistState extends State<Viewlist> {
  final LocalStorage storage = new LocalStorage('doctor_store');
 
 TextEditingController searchText = TextEditingController();

  var accesstoken;
  bool isLoading = false;
  var pendingbill;
var item;
var view_list;
var userResponse;
var list = 0;
var searchList;
List viewlist=[];
  void initState() {
    init();
    super.initState();
  
  }
  init(){
     accesstoken = storage.getItem('userResponse')['access_token'];
    userResponse = storage.getItem('userResponse');
    item = widget.selected_working;
    getWorkingHoursViewList();
    // opentimeController.text=item['open_time'].toString();
  }

  @override
  Widget build(BuildContext context) {
    // final pendingstart = pendingdateRange.start;
    // final pendingend = pendingdateRange.end;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenwidht = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Workinghours(),
            ));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Doctor Shift Schedule',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: custom_color.appcolor,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Workinghours(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        // appBar: AppBar(
        //   title: Text('Pending Bill List'),
        //   backgroundColor: Customcolor.appcolor,
        // ),
        body: isLoading
            ? Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                   Container(
              // SizedBox(height: screenHeight*0.02,),
                 child:    Column(
                      children: [
                        SizedBox(height: screenHeight*0.02,),
                        Center(child: 
                              Container(
                                height: screenHeight * 0.06,
                                width: screenwidht*0.96,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: custom_color.appcolor),
                                    borderRadius: BorderRadius.all(Radius.circular(4))),
                                child: Row(
                                  children: [
                                    // Container(
                                    //     width: screenWidth * 0.1,
                                    //     height: screenHeight,
                                    //     child: Icon(Icons.search,
                                    //         color: custom_color.appcolor)),
                                    Container(
                                      width: screenwidht * 0.65,
                                      child: TextField(
                                        controller: searchText,
                                        onChanged: (text) {
                                          print(text);
                                    filterItems(text);
                                          this.setState(() {});
                                          // // var list = ProductListItem;
                                          //   searchList =  referralList.where((element) {
                                          //     var treatList = element['name'].toString().toLowerCase();
                                          //     return treatList.contains(text.toLowerCase());
                                          //     // return true;
                                          //   }).toList();
                                          //   this.setState(() {});
                                        },
                                        decoration: new InputDecoration(
                                          filled: true,
                                          border: InputBorder.none,
                                          fillColor: Colors.white,
                                          hintText: 'Search Dr Name List Here...',
                                        ),
                                      ),
                                    ),
                                    searchText.text.isNotEmpty
                                        ? Container(
                                            width: screenwidht * 0.08,
                                            height: screenHeight,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  searchText.clear();
                                                  filterItems(searchText.text);
                                                  // searchList='';
                                                });
                                              },
                                            ))
                                        : Container(),
                                         Container(
                                        width: screenwidht * 0.22,
                                        height: screenHeight,
                                        child: Icon(Icons.search,
                                            color: custom_color.appcolor)),
                                  ],
                                ),
                              ),),
                      ],
                    ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            // color: Colors.white,
                            // height: screenHeight * 0.7596,
                            child: Helper().isvalidElement(viewlist) &&
                                    viewlist.length > 0
                                ? ListView.builder(
                                    itemCount: viewlist.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var data = viewlist[index];
                                        list=index+1;
                                      // var paid = data['grand_total'] - data['balance'];
                                      return Center(
                                        child: Container(
                                          color: index % 2 == 0
                                              ? Color.fromARGB(
                                                  255, 238, 242, 250)
                                              : Colors.white,
                                          width: screenwidht,
                                      
                                          child: Row(
                                            children: [
                                               Text(' $list. '),
                                              Container(
                                                 width: screenwidht*0.83,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        // width: screenwidht * 0.47,
                                                        child: Row(
                                                          children: [
                                                             Text(
                                                                'Date : ',
                                                                 style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),),
                                                                 Text(
                                                                '${data['created_at'].toString().substring(0, 10)}')
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            Text('From Time : ',
                                                             style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),),
                                                            // Text(
                                                            //     '${data['from_time'].toString()}')
                                                                 Text(
                                                                convertTo12HourFormat(data['from_time'].toString()), // Apply the function here
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        //  width: screenwidht * 0.47,
                                                        child: Row(
                                                          children: [
                                                           Text('To Time : ',
                                                            style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),),
                                                            // Text(
                                                            //     '${data['to_time'].toString()}')
                                                             Text(
                                                                convertTo12HourFormat(data['to_time'].toString()), // Apply the function here
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        // width: screenwidht * 0.47,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Dr Name : ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),
                                                            ),
                                                            Text(
                                                                '${data['name'].toString()}')
                                                          ],
                                                        ),
                                                      ),
                                                     
                                                    ],
                                                  ),
                                                ),
                                              ),
                                             
                                              
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
      ),
    );
  }

  String convertTo12HourFormat(String time24Hour) {
  // Split the time string into its components
  final timeParts = time24Hour.split(':');
  int hour = int.parse(timeParts[0]);
  final minute = timeParts[1];

  // Determine the period (AM/PM)
  final period = hour >= 12 ? 'PM' : 'AM';

  // Convert the hour to 12-hour format
  if (hour == 0) {
    hour = 12; // Midnight
  } else if (hour > 12) {
    hour -= 12; // Afternoon
  }

  // Return the formatted time
  return '$hour:$minute $period';
}

  getWorkingHoursViewList() async {
    
    var data = {
      "day": item['day'].toString(),
      
    };
   
   var viewlist = await PatientApi().getWorkingHoursViewList(accesstoken, data);
    if (Helper().isvalidElement(viewlist) &&
        Helper().isvalidElement(viewlist['status']) &&
        viewlist['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      view_list = viewlist['list'];
       filterItems(searchText.text);
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isLoading = true;
      });
    }
  }
  void filterItems(String text) {
    // setState(() {
    if (text.isEmpty) {
      setState(() {
        viewlist = view_list;
      });
    } 
    else if (text.length >= 3) {
      setState(() {
        viewlist = view_list.where((item) =>
            item['name']
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase())
                ).toList();
      });
    }
  }
}
