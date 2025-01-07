import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/BillingWidget/Api.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/Collections/Collections.dart';
import 'package:nigdoc/Collections/RegisterReportPay.dart';
import 'package:nigdoc/Collections/TreatmentBillPaid.dart';
import 'package:nigdoc/Collections/TreatmentBillPay.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;


class treatmentbill extends StatefulWidget {
  const treatmentbill({super.key});

  @override
  State<treatmentbill> createState() => _treatmentbillState();
}

class _treatmentbillState extends State<treatmentbill> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  TextEditingController searchText = TextEditingController();
  final DateFormate = "yyyy-MM-dd";
  TextEditingController fromdateInputController = TextEditingController();
  TextEditingController todateInputController = TextEditingController();

  var accesstoken;
  bool isLoading = false;
  var treatment_report;
  var treatment_reportList;
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
        firstDate: DateTime(DateTime.now().year-2, DateTime.now().month, DateTime.now().day),
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
      gertreatmentbill();
    } else {
      todateInputController.text = DateFormat(DateFormate).format(pickedDate!);
      // todateInputController.text = pickedDate.toString().split(' ')[0];
      gertreatmentbill();
    }
  }

  void initState() {
    super.initState();
    accesstoken = storage.getItem('userResponse')['access_token'];
    fromdateInputController.text = Helper().getCurrentDate();
    todateInputController.text = Helper().getCurrentDate();
    gertreatmentbill();

    // print('ddd');
  }

  @override
  Widget build(BuildContext context) {
  
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidht = MediaQuery.of(context).size.width;
     Map<String, String> data = {'reg_date': ''};
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Dash(),
            ));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Treatment Bill',
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
        // appBar: AppBar(title: Text('Cancelled Bill List'),
        // backgroundColor: Customcolor.appcolor,
        // ),
        body: 
        isLoading
            ? 
            Container(
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
                              width: screenwidht * 0.45,
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
                    Divider(
                      thickness: 3,
                    ),
                    SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Container(
                            height: screenHeight * 0.06,
                            width: screenwidht * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: custom_color.appcolor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Row(
                              children: [
                              
                                Container(
                                  width: screenwidht * 0.65,
                                  child: TextField(
                                    controller: searchText,
                                    onChanged: (text) {
                                      print(text);
                                      filterItems(text);
                                      this.setState(() {});
                            
                                    },
                                    decoration: new InputDecoration(
                                      filled: true,
                                      border: InputBorder.none,
                                      fillColor: Colors.white,
                                      hintText: 'Search Name Here...',
                                    ),
                                  ),
                                ),
                                searchText.text.isNotEmpty
                                    ? Container(
                                        width: screenwidht * 0.06,
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
                                           
                                              // searchText.text = '';
                                              // searchList='';
                                            });
                                          },
                                        ))
                                    : Container(),
                                Container(
                                    width: screenwidht * 0.18,
                                    height: screenHeight,
                                    child: Icon(Icons.search,
                                        color: custom_color.appcolor)),
                              ],
                            ),
                          ),
                        ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            // height: screenHeight * 0.7596,
                            child: Helper().isvalidElement(treatment_reportList) &&
                                    treatment_reportList.length > 0
                                ? 
                                 ListView.builder(
                                    itemCount: treatment_reportList.length,
                                    //  itemCount: 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var data = treatment_reportList[index];
                                      return Center(
                                        child: Container(
                                          color: index % 2 == 0
                                              ? Color.fromARGB(
                                                  255, 238, 242, 250)
                                              : Colors.white,
                                          width: screenwidht,
                                          // height: screenHeight * 0.20,
                                          // width: screenWidth * 0.90,
                                          // decoration:
                                          //     BoxDecoration(border: Border.all(color: Colors.grey)),
                                          child: Row(
                                            children: [
                                              Container(
                                                 width: screenwidht*0.83,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(1.0),
                                                        child: Row(
                                                          // mainAxisAlignment:
                                                          //     MainAxisAlignment
                                                          //         .spaceBetween,
                                                          children: [
                                                            Container(
                                                              // color: Colors.blue,
                                                              width: screenwidht*0.5,
                                                              // width: screenwidht * 0.47,
                                                              child: Row(
                                                                children: [
                                                                  // Icon(
                                                                  //   Icons.person,
                                                                  //   color: Color
                                                                  //       .fromARGB(
                                                                  //           255,
                                                                  //           98,
                                                                  //           96,
                                                                  //           96),
                                                                  // ),
                                                                   Text(
                                                                      'Patient Id : ',
                                                                       style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),),
                                                                      Text(
                                                                      '${data['p_id'].toString()}')
                                                                  // Helper().isvalidElement(
                                                                  //         data[
                                                                  //             'customer_name'])
                                                                  //     ? Text(
                                                                  //         '${data['customer_name'].toString()}')
                                                                  //     : Text(''),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.calendar_month,
                                                                    color: custom_color.appcolor,
                                                                    // color: Color
                                                                    //     .fromARGB(
                                                                    //         255,
                                                                    //         98,
                                                                    //         96,
                                                                    //         96),
                                                                  ),
                                                                  //  Text(
                                                                  //     'Date ')
                                                                  Text(
                                                                      ' ${data['date'].toString().substring(0, 10)}')
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(1.0),
                                                        child: Container(
                                                          child: Row(
                                                            children: [
                                                              // Icon(
                                                              //   Icons
                                                              //       .calendar_month,
                                                              //   color: Color
                                                              //       .fromARGB(
                                                              //           255,
                                                              //           98,
                                                              //           96,
                                                              //           96),
                                                              // ),
                                                               Text(
                                                                  'Name : ', style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),),
                                                              Text(
                                                                  ' ${data['p_name'].toString()}')
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                      //  color: Colors.blue,
                                                      //  width: screenwidht*0.45,
                                                       child: Row(
                                                         children: [
                                                           Text(
                                                             'Mobile No : ',
                                                             style: TextStyle(
                                                                 fontWeight:
                                                                     FontWeight
                                                                         .bold),
                                                           ),
                                                           Text(
                                                               '${data['phone'].toString()}')
                                                         ],
                                                       ),
                                                         ),
                                                       Container(
                                                      //    color: Colors.red,
                                                      //  width: screenwidht*0.4,
                                                       // width: screenwidht * 0.55,
                                                       child: Row(
                                                         children: [
                                                           Text(
                                                             'Treatment Charge (₹) : ',
                                                             style: TextStyle(
                                                                 fontWeight: FontWeight.bold),
                                                           ),
                                                           Text(
                                                               '${data['treatment_charge'].toString()}')
                                                         ],
                                                       ),
                                                         ),
                                                       Padding(
                                                        padding:
                                                            const EdgeInsets.all(1.0),
                                                        child: Row(
                                                          // mainAxisAlignment:
                                                          //     MainAxisAlignment
                                                          //         .spaceBetween,
                                                          children: [
                                                            Container(
                                                                // color: Colors.blue,
                                                              width: screenwidht*0.5,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'Dis : ',
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.bold),
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
                                                                    'Paid (₹) : ',
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.bold),
                                                                  ),
                                                                  Text(
                                                                      '${data['paid'].toString()}')
                                                                ],
                                                              ),
                                                            ),
                                                            // Container(
                                                            //   child: Row(
                                                            //     children: [
                                                            //       Text(
                                                            //         'Paid : ',
                                                            //         style: TextStyle(
                                                            //             fontWeight: FontWeight.bold),
                                                            //       ),
                                                            //       Text(
                                                            //           '${data['paid'].toString()}')
                                                            //     ],
                                                            //   ),
                                                            // ),
                                                           
                                                          ],
                                                        ),
                                                      ),
                                                       Padding(
                                                        padding:
                                                            const EdgeInsets.all(1.0),
                                                        child: Row(
                                                          // mainAxisAlignment:
                                                          //     MainAxisAlignment
                                                          //         .spaceBetween,
                                                          children: [
                                                             Container(
                                                              // color: Colors.blue,
                                                              width: screenwidht*0.5,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'Bal (₹) : ',
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.bold),
                                                                  ),
                                                                  Text(
                                                                      '${data['balance'].toString()}')
                                                                ],
                                                              ),
                                                            ),
                                                            // Container(
                                                            //   // width: screenwidht * 0.55,
                                                            //   child: Row(
                                                            //     children: [
                                                            //       Text(
                                                            //         'Bal : ',
                                                            //         style: TextStyle(
                                                            //             fontWeight: FontWeight.bold),
                                                            //       ),
                                                            //       // Text(
                                                            //       //     '${data['balance'].toString()}')
                                                            //     ],
                                                            //   ),
                                                            // ),
                                                          
                                                            
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                               PopupMenuButton(
                                              itemBuilder: (context) => [
                                              
                                              data['balance'] !=0? PopupMenuItem(
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
                                                                      .dollarSign,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                                Text(
                                                                  '  Pay',
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
                                                        await storage.setItem('treatment_bill',data);
                                                        //  Nator.push(context, MaterialPageRoute(builder: (context)=>PendingPayment()));
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TreatmentBillPay()));
                                                      }),
                                                    ):
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
                                                                      .dollarSign,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                                Text(
                                                                  '  Paid',
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
                                                        await storage.setItem('treatment_bill',data);
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TreatmentBillPaid()));
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
                            // Text('No data'),
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
  
  gertreatmentbill() async {
    var formatter = new DateFormat('yyyy-MM-dd');
    var data = {
      "from_date": fromdateInputController.text.toString(),
      "to_date": todateInputController.text.toString(),
     
    };
    // this.setState(() {
    //   isLoading = true;
    // });
    treatment_report = await billingapi().getDocTreatmentBillList(accesstoken, data);
    if (Helper().isvalidElement(treatment_report) &&
        Helper().isvalidElement(treatment_report['status']) &&
        treatment_report['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      treatment_report = treatment_report['list'];
    
      this.setState(() {
        isLoading = true;
         filterItems(searchText.text);
      });
    }
  }
   void filterItems(String text) {
   
    if (text.isEmpty) {
      setState(() {
        treatment_reportList = treatment_report;
      });
    } else if (text.length >= 3) {
      setState(() {
        treatment_reportList = treatment_report
            .where(
              (item) => item['p_name']
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()),
              // item['phone']
              //     .toString()
              //     .toLowerCase()
              //     .contains(text.toLowerCase())
            )
            .toList();
      });
    }
  }
}
