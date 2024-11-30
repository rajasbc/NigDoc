import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/Reports/report.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class dailycollection extends StatefulWidget {
  const dailycollection({super.key});

  @override
  State<dailycollection> createState() => _dailycollectionState();
}

class _dailycollectionState extends State<dailycollection> {
  TextEditingController fromdateInputController = TextEditingController();
  TextEditingController todateInputController = TextEditingController();
  var list = 0;
  var userResponse;
  var accesstoken;
  bool isLoading = true;
  @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken = userResponse['access_token'];
    fromdateInputController.text = Helper().getCurrentDate();
    todateInputController.text = Helper().getCurrentDate();

    // getsummaryList();
    // TODO: implement initState
    super.initState();
  }

  List reportList = [];

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
                onPrimary: Colors.white,
                onSurface: custom_color.appcolor,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: custom_color.appcolor,
                ),
              ),
            ),
            child: child!,
          );
        },
        initialDate: currentDate,
        firstDate: DateTime(
            DateTime.now().year - 3, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day));

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    if (checkfield == "from") {
      // var formatter = new DateFormat('dd-MM-yyyy');
      fromdateInputController.text =
          DateFormat(DateFormate).format(pickedDate!);
      getdailyreportList();
      // fromdateInputController.text = pickedDate.toString().split(' ')[0];
      // getsummaryList();
      // get();
      // getdoctorlist();
    } else {
      todateInputController.text = DateFormat(DateFormate).format(pickedDate!);
      getdailyreportList();
      // getsummaryList();
      // get();
      // getdoctorlist();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Map<String, String> data = {'date': '', 'patient_name': ''};
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => report()));
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Daily Collection',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: custom_color.appcolor,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => report(),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.01),
                    Container(
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
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    isLoading
                        ? Helper().isvalidElement(reportList) &&
                                reportList.length > 0
                            ? Container(
                                height: screenHeight * 0.80,

                                //  width: screenWidth,
                                // padding:EdgeInsets.all(15),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: reportList.length,
                                    // itemCount: 10,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      list = index + 1;
                                      var data = reportList[index];
                                      return Container(
                                        child: Column(
                                          children: [
                                            Card(
                                              color: index % 2 == 0
                                                  ? custom_color.lightcolor
                                                  : Colors.white,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: screenWidth *
                                                              0.01,
                                                        ),
                                                        // Text('1'),
                                                        Text(
                                                          '($list)',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: screenWidth *
                                                              0.02,
                                                        ),
                                                        Column(
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                                  screenHeight *
                                                                      0.02,
                                                            ),
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Container(
                                                                  // color: Colors.amber,
                                                                  width:
                                                                      screenWidth *
                                                                          0.40,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                          "Date : ${data['date'].substring(0, 10)}")
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  // color: Colors.purple,
                                                                  width:
                                                                      screenWidth *
                                                                          0.46,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                          'Name : ${data['patient_name']}')
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  screenHeight *
                                                                      0.01,
                                                            ),
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Container(
                                                                  // color: Colors.amber,
                                                                  width:
                                                                      screenWidth *
                                                                          0.40,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                          "Doctor : ${data['doctor_name'].toString().toUpperCase()}")
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  // color: Colors.purple,
                                                                  width:
                                                                      screenWidth *
                                                                          0.46,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                          'Fees : ${data['fees'].toString()}')
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  screenHeight *
                                                                      0.01,
                                                            ),
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Container(
                                                                  // color: Colors.amber,
                                                                  width:
                                                                      screenWidth *
                                                                          0.40,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                          "Pre Amt : ${data['pre_amount'].toString()}")
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  // color: Colors.purple,
                                                                  width:
                                                                      screenWidth *
                                                                          0.46,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                          'Total Fees : ${data['total_fees'].toString()}')
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  screenHeight *
                                                                      0.01,
                                                            ),
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Container(
                                                                  // color: Colors.amber,
                                                                  width:
                                                                      screenWidth *
                                                                          0.40,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                          "Paid : ${data['paid'].toString().toUpperCase()}")
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  // color: Colors.purple,
                                                                  width:
                                                                      screenWidth *
                                                                          0.46,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                          'Discount : ${data['discount'].toString()}')
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  screenHeight *
                                                                      0.01,
                                                            ),
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Container(
                                                                  // color: Colors.amber,
                                                                  width:
                                                                      screenWidth *
                                                                          0.85,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                          "Balance : ${data['balance'].toString()}")
                                                                    ],
                                                                  ),
                                                                ),
                                                                // Container(
                                                                //   color: Colors.purple,
                                                                //   width: screenWidth * 0.44,
                                                                //   child: Row(
                                                                //     children: [
                                                                //       Text(
                                                                //         'Fees :',
                                                                //         style: TextStyle(
                                                                //             fontWeight: FontWeight.bold),
                                                                //       ),
                                                                //       // Text('${data['contact_no'].toString()}')
                                                                //     ],
                                                                //   ),
                                                                // ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  screenHeight *
                                                                      0.01,
                                                            ),
                                                          ],
                                                        ),

//                                                           PopupMenuButton(itemBuilder: (context)=>[
//                                       PopupMenuItem(child: Row(
//                                               children: [
//                                                 Icon(Icons.edit,color: custom_color.appcolor,),
//                                                 Padding(padding: EdgeInsets.only(left: 10),
//                                                 child: Text('Edit',style: TextStyle(fontSize: 16),),)
//                                               ],
//                                             ),
//                                             onTap: () {
//           //                                      Navigator.push(
//           // context, MaterialPageRoute(builder: (context)=> Edittreatment(medicinelist:data),)
//         //  );
// //
//                                             },
//                                             ),

//                                     ]

//                                     ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),

//                                   child: ListTile(
//                                     // title: SizedBox(child: Text('${data['treatment']}')),

//                                     leading: Text('$list'),

//                                     trailing: PopupMenuButton(itemBuilder: (context)=>[
//                                       PopupMenuItem(child: Row(
//                                               children: [
//                                                 Icon(Icons.edit,color: custom_color.appcolor,),
//                                                 Padding(padding: EdgeInsets.only(left: 10),
//                                                 child: Text('Edit',style: TextStyle(fontSize: 16),),)
//                                               ],
//                                             ),
//                                             onTap: () {
//                                                Navigator.push(
//           context, MaterialPageRoute(builder: (context)=> Edittreatment(medicinelist:data),)
//          );
// //
//                                             },
//                                             ),

//                                     ]

//                                     ),

//                                   ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              )
                            : Container(child: Text('No Data Found'))
                        : Container(
                            child: SpinLoader(),
                          )
                  ],
                ),
              ),
            ),
          )),
        ));
  }

  getdailyreportList() async {
    // var formatter = new DateFormat('yyyy-MM-dd');
    isLoading = false;
    var data = {
      "from_date": fromdateInputController.text.toString(),
      "to_date": todateInputController.text.toString(),
    };
    // this.setState(() {
    //   isLoading = true;
    // });
    var list = await PatientApi().getdailyreport(accesstoken, data);
    if (Helper().isvalidElement(list) &&
        Helper().isvalidElement(list['status']) &&
        list['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      reportList = list['list'];
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
