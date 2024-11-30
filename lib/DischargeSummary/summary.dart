import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/DischargeSummary/Addsummary.dart';
import 'package:nigdoc/DischargeSummary/Dischargesummary.dart';
import 'package:nigdoc/DischargeSummary/DischargesummeryPrint.dart';
import '../../AppWidget/common/Colors.dart'as custom_color;


class Discharge_summery extends StatefulWidget {
  const Discharge_summery({super.key});

  @override
  State<Discharge_summery> createState() => _Discharge_summeryState();
}

class _Discharge_summeryState extends State<Discharge_summery> {
  TextEditingController fromdateInputController =TextEditingController();
  TextEditingController todateInputController =TextEditingController();
  var userResponse;
  var accesstoken;
  bool isLoading = false;
 @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];
    fromdateInputController.text = Helper().getCurrentDate();
    todateInputController.text = Helper().getCurrentDate();

    getsummaryList();
    // TODO: implement initState
    super.initState();
  }
  List summaryList = [];
   final DateFormate = "yyyy-MM-dd";
   DateTime currentDate = DateTime.now();
  Future<void> selectDate(BuildContext context, data) async {
    var checkfield = data;
    // print(data);
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: custom_color.appcolor,
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: custom_color.appcolor, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: custom_color.appcolor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        initialDate: currentDate,
        firstDate: DateTime(DateTime.now().year-3, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    if (checkfield == "from") {
      // var formatter = new DateFormat('dd-MM-yyyy');
      fromdateInputController.text =
          DateFormat(DateFormate).format(pickedDate!);

      // fromdateInputController.text = pickedDate.toString().split(' ')[0];
      getsummaryList();
      // get();
      // getdoctorlist();
    } else {
      todateInputController.text = DateFormat(DateFormate).format(pickedDate!);
     
      getsummaryList();
      // get();
      // getdoctorlist();
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Map<String, String> data = {
      'date': '',
      'customer_name':''
    };
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>dischargesummary()));
      },
      child: Scaffold(
       appBar: AppBar(
            title: Text(
              'Discharge Summery',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor:custom_color.appcolor,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => dischargesummary(),
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
            //  height: screenHeight*0.86,
             child: Column(
               children: [
                 // Container(
                 //   child: Text('data'),
                   
                 // ),
                 Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                   width: screenWidth,
                   height: screenHeight * 0.06,
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(
                         width: screenWidth * 0.45,
                         child: TextFormField(
                           decoration: InputDecoration(
                             hintText: 'From',
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(8)),
                             labelText: 'From',
                             suffixIcon: Icon(
                               Icons.date_range,
                               color: custom_color.appcolor,
                             ),
                           ),
                           controller: fromdateInputController,
                           readOnly: true,
                           onTap: () async {
                             selectDate(context, 'from');
                           },
                         ),
                       ),
                       Container(
                         width: screenWidth * 0.45,
                         child: TextFormField(
                             decoration: InputDecoration(
                               hintText: 'To',
                               border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(8)),
                               labelText: 'To',
                               suffixIcon: Icon(
                                 Icons.date_range,
                                 color: custom_color.appcolor,
                               ),
                             ),
                             controller: todateInputController,
                             readOnly: true,
                             onTap: () async {
                               selectDate(context, 'to');
                             }),
                       ),
                     ],
                   ),
                 ),
               ),
                          
              Helper().isvalidElement(summaryList) && summaryList.length > 0 ?  
              Container(
                  height: screenHeight*0.80,
                   child: Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Column(
                       children: [
                         Container(
                          height: screenHeight*0.78,
                           child: ListView.builder(
                             shrinkWrap: true,
                             itemCount: summaryList.length,
                             itemBuilder: (BuildContext context, int index) {
                               var data=summaryList[index];
                               return Center(
                                 child: Padding(
                                   padding: const EdgeInsets.all(0.0),
                                   child: Container(
                                     color: index % 2 == 0
                                         ? custom_color.lightcolor
                                         : Colors.white,
                                     width: screenWidth,
                                     height: screenHeight * 0.07,
                                     child: Padding(
                                       padding: const EdgeInsets.all(2.0),
                                       child: Row(
                                         children: [
                                           Container(
                                             width: screenWidth*0.85,
                                             child: Column(
                                               children: [
                                                 Padding(
                                                   padding: const EdgeInsets.all(0.0),
                                                   child: Row(
                                                     children: [
                                                       Container(
                                                         width: screenWidth * 0.40,
                                                         child: Row(
                                                           children: [
                                                             Text(
                                                               'Name : ${data['customer_name'].toString()}',
                                                               style: TextStyle(
                                                                   fontWeight:
                                                                       FontWeight.bold),
                                                             ),
                                                           ],
                                                         ),
                                                       ),
                                                        Container(
                                                          width: screenWidth * 0.40,
                                                         child: Row(
                                                           children: [
                                                             Text(
                                                               'Mobile No : ${data['phone'].toString()}',
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
                                                SizedBox(height: screenHeight*0.01,),
                                                 Padding(
                                                   padding: const EdgeInsets.all(0.0),
                                                   child: Row(
                                                     children: [
                                                       Container(
                                                         width: screenWidth * 0.38,
                                                         child: Row(
                                                           children: [
                                                             Text(
                                                               'Total Amount : ${data['grand_total']}',
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
                                               ],
                                             ),
                                           ),

                                           Container(
                                            width: screenWidth*0.10,
                                             child: Column(
                                                        children: [
                                                          PopupMenuButton(
                                                              itemBuilder:
                                                                  (context) => [
                                                                        PopupMenuItem(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Icon(
                                                                                Icons.print,
                                                                                color: custom_color.appcolor,
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsets.only(left: 10),
                                                                                child: Text(
                                                                                  'Print',
                                                                                  style: TextStyle(fontSize: 16),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                                Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => Dischargesummeryprint(select_discharge :data)));
                                                                              },
                                                                        ),
                                                                      ]),
                                                        ],
                                                      ),
                                           ),

                                         ],
                                       ),
                                     ),
                                   ),
                                 ),
                               );
                             },
                           ),
                         ),
                       ],
                     ),
                   ),
                 ):Container(child: Text('no data'),)
               ],
             ),
           ),
         ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Addsummary()));
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
   getsummaryList() async {
    // var formatter = new DateFormat('yyyy-MM-dd');
    var data = {
      "from_date": fromdateInputController.text.toString(),
      "to_date": todateInputController.text.toString(),
     
    };
    // this.setState(() {
    //   isLoading = true;
    // });
    var list = await PatientApi().getDischargeSummary(accesstoken, data);
    if (Helper().isvalidElement(list) &&
        Helper().isvalidElement(list['status']) &&
        list['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      summaryList = list['list'];
      // for(var data in prescriptionList){
      //        if(DoctorDropdownvalue == 'All'){
      //         presc_list.add(data);
      //        }
      // }
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isLoading = true;
      });
    }
  }
}