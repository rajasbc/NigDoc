import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/BillingWidget/Api.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../Common/colors.dart' as Customcolor;

class Pendingbilllist extends StatefulWidget {
  const Pendingbilllist({super.key});

  @override
  State<Pendingbilllist> createState() => _PendingbilllistState();
}

class _PendingbilllistState extends State<Pendingbilllist> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  final DateFormate = "dd-MM-yyyy";
  TextEditingController fromdateInputController = TextEditingController();
  TextEditingController todateInputController = TextEditingController();

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
                primary: Customcolor.appcolor,
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: Customcolor.appcolor, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Customcolor.appcolor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        initialDate: currentDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2025));

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    if (checkfield == "from") {
      // var formatter = new DateFormat('dd-MM-yyyy');
      fromdateInputController.text =
          DateFormat(DateFormate).format(pickedDate!);

      // fromdateInputController.text = pickedDate.toString().split(' ')[0];
      getbendingbilllist();
    } else {
      todateInputController.text = DateFormat(DateFormate).format(pickedDate!);
      // todateInputController.text = pickedDate.toString().split(' ')[0];
      getbendingbilllist();
    }
  }

  var accesstoken;
  bool isLoading = false;
  var pendingbill;

  void initState() {
    super.initState();
    accesstoken = storage.getItem('userResponse')['access_token'];
    fromdateInputController.text = Helper().getCurrentDate();
    todateInputController.text = Helper().getCurrentDate();
    getbendingbilllist();

    // print('ddd');
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
          context, MaterialPageRoute(builder: (context)=> Dash(),)
         );
         return true;
        },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pending Bill List'),
          backgroundColor: Customcolor.appcolor,
        ),
        body:isLoading? Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenwidht,
                  height: screenHeight * 0.06,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenwidht * 0.45,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'From',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            labelText: 'From',
                            suffixIcon: Icon(
                              Icons.date_range,
                              color: Customcolor.appcolor,
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
                        width: screenwidht * 0.45,
                        child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'To',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              labelText: 'To',
                              suffixIcon: Icon(
                                Icons.date_range,
                                color: Customcolor.appcolor,
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
              Divider(
                thickness: 3,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    // color: Colors.white,
                    height: screenHeight * 0.7596,
                    child: Helper().isvalidElement(pendingbill) &&
                            pendingbill.length > 0
                        ? ListView.builder(
                            itemCount: pendingbill.length,
                            itemBuilder: (BuildContext context, int index) {
                              var data = pendingbill[index];
                
                              // var paid = data['grand_total'] - data['balance'];
                              return Center(
                                child: Container(
                                  color: index % 2 == 0
                                      ? Color.fromARGB(255, 238, 242, 250)
                                      : Colors.white,
                                  width: screenwidht,
                                  // height: screenHeight * 0.20,
                                  // width: screenWidth * 0.90,
                                  // decoration:
                                  //     BoxDecoration(border: Border.all(color: Colors.grey)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                // width: screenwidht * 0.47,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.person,
                                                      color: Color.fromARGB(
                                                          255, 98, 96, 96),
                                                    ),
                                                    Helper().isvalidElement(
                                                            data['customer_name'])
                                                        ? Text(
                                                            '${data['customer_name'].toString()}')
                                                        : Text(''),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.phone,
                                                      color: Color.fromARGB(
                                                          255, 98, 96, 96),
                                                    ),
                                                    Text(
                                                        '${data['cus_phone'].toString()}')
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                //  width: screenwidht * 0.47,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.calendar_month,
                                                      color: Color.fromARGB(
                                                          255, 98, 96, 96),
                                                    ),
                                                    Text(
                                                        '${data['date'].toString().substring(0, 10)}')
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // width: screenwidht * 0.47,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Fess :',
                                                      // style: TextStyle(
                                                      //     fontWeight:
                                                      //         FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),
                                                    ),
                                                    Text(
                                                        '${data['grand_total'].toString()}')
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Discount :',
                                                    // style: TextStyle(
                                                    //     // fontWeight:
                                                    //     //     FontWeight.bold
                                                    //         color: Color.fromARGB(255, 54, 50, 50)),
                                                  ),
                                                  Text(
                                                      '${data['discount'].toString()}')
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // width: screenwidht * 0.55,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Paid :',
                                                    // style: TextStyle(
                                                    //     // fontWeight:
                                                    //     //     FontWeight.bold
                                                    //         color: Color.fromARGB(255, 54, 50, 50)),
                                                  ),
                                                  Text(
                                                      '${data['grand_total'] - data['balance']}')
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Balance :',
                                                    // style: TextStyle(
                                                    //     // fontWeight:
                                                    //     //     FontWeight.bold,
                                                    //         color: Color.fromARGB(255, 54, 50, 50)),
                                                  ),
                                                  Text(
                                                      '${data['balance'].toString()}')
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })
                        :Center(child: Text('No Data Found'),)
                    // :
                    // Text('Nodata'),
                    ),
              )
            ],
          ),
        ):SpinLoader(),
      ),
    );
  }

  // Future pendingpickDateRange() async {
  //   DateTimeRange? newDateRange = await showDateRangePicker(
  //     context: context,
  //     initialDateRange: pendingdateRange,
  //     firstDate: DateTime(2019),
  //     lastDate: DateTime(2024),
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: ColorScheme.light(
  //             primary: Colors.blue, // <-- SEE HERE
  //             onPrimary: Colors.white, // <-- SEE HERE
  //             onSurface: Colors.blue, // <-- SEE HERE
  //           ),
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               primary: Colors.red, // button text color
  //             ),
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //   setState(() {
  //     pendingdateRange = newDateRange ?? pendingdateRange;

  //     // if (newDateRange == null) return;
  //     // setState(() => dateRange = newDateRange);
  //   });
  //   // getPatientRegisterReportList();
  //   // this.setState(() {});
  // }

  getbendingbilllist() async {
    // var formatter = new DateFormat('yyyy-mm-dd');
    var formatter = new DateFormat('yyyy-MM-dd');
    var data = {
      "from_date": fromdateInputController.text.toString(),
      "to_date": todateInputController.text.toString(),
      "status_type": "Pending",
    };
    // this.setState(() {
    //   isLoading = true;
    // });
    pendingbill = await billingapi().getpendinglist(accesstoken, data);
    if (Helper().isvalidElement(pendingbill) &&
        Helper().isvalidElement(pendingbill['status']) &&
        pendingbill['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      pendingbill = pendingbill['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isLoading = true;
      });
    }
  }
}
