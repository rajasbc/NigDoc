import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/AppWidget/common/Colors.dart';
import 'package:nigdoc/AppWidget/BillingWidget/Api.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/Pendingbilllist.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineList.dart';
import 'package:nigdoc/AppWidget/common/Colors.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/Collections/Collections.dart';
import 'package:nigdoc/Collections/RegisterReport.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;


class RegisterReportPay extends StatefulWidget {
  const RegisterReportPay({super.key});

  @override
  State<RegisterReportPay> createState() => _RegisterReportPayState();
}

class _RegisterReportPayState extends State<RegisterReportPay> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  TextEditingController receivedController = TextEditingController();
  TextEditingController discountcontroller = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();
  final FocusNode receivedFocusNode = FocusNode();
  final FocusNode discountFocusNode = FocusNode();
  final FocusNode OTPFocusNode = FocusNode();
  var p_name;
  var total_amount;
  var discount;
  var bill_amount;
  var bill_date;
  var bill_no;
  var paid;
  var bill_id;
  var OTP;
  var verify_otp;
  double remain_balance = 0.0;
  var remain_balance1;
  String payDropdownvalue = 'Cash';
  var pay = [
    'Cash',
    'Card',
    'Net Banking',
    'G pay',
    'Phone pe',
    'PAYTM',
    'Amazon Pay',
    'Due',
  ];
  var access_token;
  var userResponse;
  var route;
  var def_amount;
  var id;
  var patient_id;
  var register_reportpay;
  bool isLoading = false;
  bool loding = false;

  late Timer timer;
  int start = 10;
  bool send_otp = false;
  bool resend_otp = true;
  @override
  void initState() {
    super.initState();
    init();
    // var result = widget.value;
  }

  init() async {
    await storage.ready;
    userResponse = await storage.getItem('userResponse');
    access_token = userResponse['access_token'];
    var payment = await storage.getItem('register_report');
    
    setState(() {
      id = payment['id'].toString();
      patient_id = payment['p_id'].toString();
      p_name = payment['p_name'].toString();
      // bill_no = payment['presc_id'].toString();
      bill_date = payment['reg_date'].toString();
      total_amount = payment['paid'].toString();
      bill_amount = payment['balance'].toString();
       bill_amount = payment['balance'].toString();
      def_amount = payment['consulting_fees'].toString();
    
    });
    await gerRegisterReportPay();
    setState(() {
      
    });
  }
  gerRegisterReportPay() async {
    
    var data = {
      "id": id.toString(),
    };
    // this.setState(() {
    //   isLoading = true;
    // });
    register_reportpay = await billingapi().getRegisterReportPayList(access_token, data);
    if (Helper().isvalidElement(register_reportpay) &&
        Helper().isvalidElement(register_reportpay['status']) &&
        register_reportpay['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      register_reportpay = register_reportpay['list'];
    
      this.setState(() {
        isLoading = true;
      });
    }
  }
  void dispose(){
    receivedFocusNode.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
     Map<String, String> bill_date = {'reg_date': ''};
    return WillPopScope(
      onWillPop: () async {
       
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Registerreport()),
        );
        return true;
      },
      child: Scaffold(
        backgroundColor:appcolor,
          body: SafeArea(
            child: Container(
              color:Colors.white,
              child: Column(
                children: [
                  Appbar(),
                  Expanded(
                    child: SingleChildScrollView(
                      
                      child: Column(
                        children: [
                      
                          // renderlist(screenHeight, screenWidth),
                          patient(screenHeight,screenWidth),
                          total(screenHeight,screenWidth),
                          BillPayList(screenHeight,screenWidth),
                          renderlist(screenHeight, screenWidth),

                        ],
                      ),
                    ),
                  )
    
                  // Text(widget.value),
                ],
              ),
            ),
          ),
        ),
    );
    
  }

  Widget Appbar() {
    return Container(
      color: appcolor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color:Colors.white,
                  ),
                  onTap: () async {
                   
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Registerreport()),
        );

      
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const DashboardWidget()),
                    // );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Register Report Bill Pay',
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.42),
                  ),
                ),
              ],
            ),
            // InkWell(
            //   onTap: () {
            //     showAlert(context);
            //   },
            //   child: Icon(
            //     Icons.settings,
            //     color: Colors.white,
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  renderlist(screenHeight, screenWidth) {
    return Container(
     
      child: Column(
        children: [
          // SizedBox(
          //   width: screenWidth,
          //   height: screenHeight * 0.10,
          //   // color: Colors.amber,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Container(
                        
          //               child: Row(
          //                 children: [
          //                   const Text(
          //                     'Name : ',
          //                     style: TextStyle(fontSize: 18),
          //                   ),
          //                    Text(
          //                     '$p_name',
          //                     style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             Container(
          //               child: Row(
          //                 children: [
          //                   const Text(
          //                     'Date : ',
          //                     style: TextStyle(fontSize: 18),
          //                   ),
          //                    Text(
          //                     '${bill_date.toString().substring(0, 10)}',
          //                     style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
               
              
          //     ],
          //   ),
          // ),
          // Container(
          //   // height: screenHeight*0.2,
          //   // color: Colors.amber,
          //   child: Padding(
          //     padding: const EdgeInsets.all(5.0),
          //     child: Container(
                  
          //            child:   ListView.builder(
          //                 // itemCount: register_report.length,
          //                  itemCount: 1,
          //                  shrinkWrap: true,
          //                 itemBuilder:
          //                     (BuildContext context, int index) {
          //                   // var data = register_report[index];
          //                   return Center(
          //                     child: Container(
          //                       color: index % 2 == 0
          //                           ? Color.fromARGB(
          //                               255, 238, 242, 250)
          //                           : Colors.white,
          //                       width: screenWidth,
          //                       // height: screenHeight * 0.20,
          //                       // width: screenWidth * 0.90,
          //                       // decoration:
          //                       //     BoxDecoration(border: Border.all(color: Colors.grey)),
          //                       child: Row(
          //                         children: [
          //                           Container(
          //                             // color: Colors.green,
          //                              width: screenWidth*0.95,
          //                             child: Padding(
          //                               padding: const EdgeInsets.all(4.0),
          //                               child: Column(
          //                                 children: [
          //                                   Padding(
          //                                     padding:
          //                                         const EdgeInsets.all(1.0),
          //                                     child: Row(
          //                                       // mainAxisAlignment:
          //                                       //     MainAxisAlignment
          //                                       //         .spaceBetween,
          //                                       children: [
          //                                         Container(
          //                                           // color: Colors.amber,
          //                                            width: screenWidth*0.4,
          //                                           child: Row(
          //                                             children: [
          //                                               Icon(
          //                                                 Icons.calendar_month,
          //                                                 // color: custom_color.appcolor,
          //                                                 // color: Color
          //                                                 //     .fromARGB(
          //                                                 //         255,
          //                                                 //         98,
          //                                                 //         96,
          //                                                 //         96),
          //                                               ),
          //                                               //  Text(
          //                                               //     'Date '),
          //                                               Text(
          //                     '  ${bill_date.toString().substring(0, 10)}',
          //                     // style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          //                   ),
          //                                             ],
          //                                           ),
          //                                         ),
          //                                         Container(
          //                                           // color: Colors.blue,
          //                                            width: screenWidth*0.5,
          //                                           child: Row(
          //                                             children: [
          //                                               // Icon(
          //                                               //   Icons.calendar_month,
          //                                               //   // color: custom_color.appcolor,
          //                                               //   // color: Color
          //                                               //   //     .fromARGB(
          //                                               //   //         255,
          //                                               //   //         98,
          //                                               //   //         96,
          //                                               //   //         96),
          //                                               // ),
          //                                                Text(
          //                                                   'Description :', style: TextStyle(
          //                                                     fontWeight: FontWeight.bold),),
          //                                               Text(
          //                                                   ' Total Fees')
          //                                             ],
          //                                           ),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                   Padding(
          //                                     padding:
          //                                         const EdgeInsets.all(1.0),
          //                                     child: Container(
          //                                       child: Row(
          //                                         children: [
                                                  
          //                                            Text(
          //                                               'Mode of Pay : ', style: TextStyle(
          //                                                 fontWeight:
          //                                                     FontWeight
          //                                                         .bold),),
          //                                           // Text(
          //                                           //     ' ${data['p_name'].toString()}')
          //                                         ],
          //                                       ),
          //                                     ),
          //                                   ),
          //                                   Padding(
          //                                     padding:
          //                                         const EdgeInsets.all(1.0),
          //                                     child: Row(
          //                                       // mainAxisAlignment:
          //                                       //     MainAxisAlignment
          //                                       //         .spaceBetween,
          //                                       children: [
          //                                          Container(
          //                                           // color: Colors.blue,
          //                                            width: screenWidth*0.4,
          //                                           child: Row(
          //                                             children: [
          //                                               Text(
          //                                                 'Amt : ',
          //                                                 style: TextStyle(
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .bold),
          //                                               ),
          //                                               Text(
          //                                                   def_amount)
          //                                             ],
          //                                           ),
          //                                         ),
          //                                         Container(
          //                                           // color: Colors.blue,
          //                                            width: screenWidth*0.5,
          //                                           // width: screenwidht * 0.55,
          //                                           child: Row(
          //                                             children: [
          //                                               Text(
          //                                                 'Total Dis : ',
          //                                                 style: TextStyle(
          //                                                     fontWeight: FontWeight.bold),
          //                                               ),
          //                                               // Text(
          //                                               //     '${data['extra_fees'].toString()}')
          //                                             ],
          //                                           ),
          //                                         ),
                                                
                                             
          //                                       ],
          //                                     ),
          //                                   ),
          //                                    Padding(
          //                                     padding:
          //                                         const EdgeInsets.all(1.0),
          //                                     child: Row(
          //                                       mainAxisAlignment:
          //                                           MainAxisAlignment
          //                                               .spaceBetween,
          //                                       children: [
          //                                         Container(
          //                                           child: Row(
          //                                             children: [
          //                                               Text(
          //                                                 'Bal : ',
          //                                                 style: TextStyle(
          //                                                     fontWeight: FontWeight.bold),
          //                                               ),
          //                                               // Text(
          //                                               //     '${data['total_fees'].toString()}')
          //                                             ],
          //                                           ),
          //                                         ),
                                                 
          //                                       ],
          //                                     ),
          //                                   ),
                                           
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
                                     
          //                         ],
          //                       ),
          //                     ),
          //                   );
          //                 })
          //             // : Center(
          //             //     child: Text('No Data Found'),
          //             //   )
                  
          //         ),
          //   ),
          // ),
          // Container(
          //   // height: screenHeight*0.2,
          //   color: Colors.amber,
          //   child: Padding(
          //     padding: const EdgeInsets.all(5.0),
          //     child: Container(
          //         // height: screenHeight * 0.7596,
          //         child: Helper().isvalidElement(register_reportpay) &&
          //                 register_reportpay.length > 0
          //             ? 
          //               ListView.builder(
          //                 itemCount: register_reportpay.length,
          //                 physics: AlwaysScrollableScrollPhysics(),
          //                 //  itemCount: 2,
          //                  shrinkWrap: true,
          //                 itemBuilder:
          //                     (BuildContext context, int index) {
          //                   var data = register_reportpay[index];
          //                   return Center(
          //                     child: Container(
          //                       color: index % 2 == 0
          //                           ? Color.fromARGB(
          //                               255, 238, 242, 250)
          //                           : Colors.white,
          //                       width: screenWidth,
          //                       // height: screenHeight * 0.20,
          //                       // width: screenWidth * 0.90,
          //                       // decoration:
          //                       //     BoxDecoration(border: Border.all(color: Colors.grey)),
          //                       child: Row(
          //                         children: [
          //                           Container(
          //                              width: screenWidth*0.95,
          //                             child: Padding(
          //                               padding: const EdgeInsets.all(4.0),
          //                               child: Column(
          //                                 children: [
          //                                   Padding(
          //                                     padding:
          //                                         const EdgeInsets.all(1.0),
          //                                     child: Row(
          //                                       // mainAxisAlignment:
          //                                       //     MainAxisAlignment
          //                                       //         .spaceBetween,
          //                                       children: [
          //                                         Container(
          //                                           // color: Colors.yellow,
          //                                            width: screenWidth*0.4,
          //                                           child: Row(
          //                                             children: [
          //                                               Icon(
          //                                                 Icons.calendar_month,
          //                                                 // color: custom_color.appcolor,
          //                                                 // color: Color
          //                                                 //     .fromARGB(
          //                                                 //         255,
          //                                                 //         98,
          //                                                 //         96,
          //                                                 //         96),
          //                                               ),
          //                                               //  Text(
          //                                               //     'Date '),
          //                                               Text(
          //                                                   '  ${data['date'].toString().substring(0, 10)}')
          //                                             ],
          //                                           ),
          //                                         ),
          //                                         Container(
          //                                           // color: Colors.blue,
          //                                            width: screenWidth*0.5,
          //                                           child: Row(
          //                                             children: [
          //                                               // Icon(
          //                                               //   Icons.calendar_month,
          //                                               //   // color: custom_color.appcolor,
          //                                               //   // color: Color
          //                                               //   //     .fromARGB(
          //                                               //   //         255,
          //                                               //   //         98,
          //                                               //   //         96,
          //                                               //   //         96),
          //                                               // ),
          //                                                Text(
          //                                                   'Description :', style: TextStyle(
          //                                                     fontWeight: FontWeight.bold),),
          //                                               Text(
          //                                                   ' ${data['description'].toString().substring(0, 10)}')
          //                                             ],
          //                                           ),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                   Padding(
          //                                     padding:
          //                                         const EdgeInsets.all(1.0),
          //                                     child: Container(
          //                                       child: Row(
          //                                         children: [
                                                  
          //                                            Text(
          //                                               'Mode of Payt : ', style: TextStyle(
          //                                                 fontWeight:
          //                                                     FontWeight
          //                                                         .bold),),
          //                                           Text(
          //                                               ' ${data['payment_mode'].toString()}')
          //                                         ],
          //                                       ),
          //                                     ),
          //                                   ),
          //                                   Padding(
          //                                     padding:
          //                                         const EdgeInsets.all(1.0),
          //                                     child: Row(
          //                                       // mainAxisAlignment:
          //                                       //     MainAxisAlignment
          //                                       //         .spaceBetween,
          //                                       children: [
          //                                          Container(
          //                                           // color: Colors.deepOrange,
          //                                            width: screenWidth*0.4,
          //                                           child: Row(
          //                                             children: [
          //                                               Text(
          //                                                 'Amt : ',
          //                                                 style: TextStyle(
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .bold),
          //                                               ),
          //                                               Text(
          //                                                   '${data['amount'].toString()}')
          //                                             ],
          //                                           ),
          //                                         ),
          //                                         Container(
          //                                           // color: Colors.blue,
          //                                            width: screenWidth*0.5,
          //                                           // width: screenwidht * 0.55,
          //                                           child: Row(
          //                                             children: [
          //                                               Text(
          //                                                 'Total Dis : ',
          //                                                 style: TextStyle(
          //                                                     fontWeight: FontWeight.bold),
          //                                               ),
          //                                               Text(
          //                                                   '${data['discount'].toString()}.00')
          //                                             ],
          //                                           ),
          //                                         ),
                                                
                                             
          //                                       ],
          //                                     ),
          //                                   ),
          //                                    Padding(
          //                                     padding:
          //                                         const EdgeInsets.all(1.0),
          //                                     child: Row(
          //                                       mainAxisAlignment:
          //                                           MainAxisAlignment
          //                                               .spaceBetween,
          //                                       children: [
          //                                         Container(
          //                                           child: Row(
          //                                             children: [
          //                                               Text(
          //                                                 'Bal : ',
          //                                                 style: TextStyle(
          //                                                     fontWeight: FontWeight.bold),
          //                                               ),
          //                                               Text(
          //                                                   '${data['balance'].toString()}')
          //                                             ],
          //                                           ),
          //                                         ),
                                                 
          //                                       ],
          //                                     ),
          //                                   ),
                                           
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
                                     
          //                         ],
          //                       ),
          //                     ),
          //                   );
          //                 })
          //             : Center(
          //                 child: Text(''),
          //               )
                  
          //         ),
          //   ),
          // ),
          Container(
            height: screenHeight * 0.05,
            width: screenWidth,
            color: appcolor,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Payment Details',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // color: Colors.amber,
          ),
         
          
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.1,
            // color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: const Text(
                          'Total Paid :',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.3,
                        child: Text(
                          '$total_amount.00',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: const Text(
                          'Bill Amount : ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
      
                      SizedBox(
                        width: screenWidth * 0.3,
                        child: Text(
                          // '${ Helper().isvalidElement(discount) ? discount : '0'}',
                          '${Helper().isvalidElement(bill_amount) && bill_amount != "" ? bill_amount : '0'}',
                          // '$discount',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      // Text('Bill Date :'),
                    ],
                  ),
                ),
      
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       SizedBox(
                //         width: screenWidth * 0.5,
                //         child: const Text(
                //           'Paid: ',
                //           style: TextStyle(fontSize: 18),
                //         ),
                //       ),
      
                //       SizedBox(
                //         width: screenWidth * 0.3,
                //         child: Text(
                //           '${ Helper().isvalidElement(paid) ? paid : '0'}',
                //           // '$discount',
                //           style: const TextStyle(fontSize: 18),
                //         ),
                //       ),
                //       // Text('Bill Date :'),
                //     ],
                //   ),
                // ),
      
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       SizedBox(
                //         width: screenWidth * 0.5,
                //         child: const Text(
                //           'Balance Bill Amount :',
                //           style: TextStyle(fontSize: 18),
                //         ),
                //       ),
                //       SizedBox(
                //         width: screenWidth * 0.3,
                //         child: Text(
                //           '$test_bill_amount ',
                //           style: const TextStyle(fontSize: 18),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.05,
            width: screenWidth,
            color: appcolor,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Bill Transaction Details',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // color: Colors.amber,
          ),
          SizedBox(
            width: screenWidth,
            // height: screenHeight * 0.3 ,
            // color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       SizedBox(
                //         width: screenWidth * 0.5,
                //         child: const Text(
                //           'Total Paid :',
                //           style: TextStyle(fontSize: 18),
                //         ),
                //       ),
                //       SizedBox(
                //         width: screenWidth * 0.3,
                //         child: Text(
                //           '$paid',
                //           style: const TextStyle(fontSize: 18),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: const Text(
                          'Discount :',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.3,
                        child: SizedBox(
                          // width: screenWidth ,
                          child: TextFormField(
                            onChanged: (value) {
                              calculationdiscount();
                            },
                            // autocorrect: false,
                            keyboardType: TextInputType.number,
      
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: appcolor,
                                  width: 3.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: appcolor,
                                  width: 3.0,
                                ),
                              ),
                              // labelText: "Patient Name",
                              border: const OutlineInputBorder(),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            controller: discountcontroller,
                            focusNode: discountFocusNode,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: const Text(
                          'After Final Discount :',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.3,
                        child: Text(
                          '${Helper().isvalidElement(bill_amount) && bill_amount != "" ? bill_amount : '0.00'}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: const Text(
                          'Payment Method : ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
      
                      Container(
                        // width: screenWidth * 0.3,
                        // color: Colors.amber,
                        child: SizedBox(
                            height: screenHeight * 0.07,
                            width: screenWidth * 0.3,
                            child: DropdownButtonFormField(
                              menuMaxHeight: 200,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color:appcolor,
                                    width: 3.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: appcolor,
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              isExpanded: true,
                              hint: Helper().isvalidElement(payDropdownvalue)
                                  ? Text(
                                      payDropdownvalue,
                                    )
                                  : const Text(
                                      'Select payment',
                                    ),
                              // value:patternDropdownvalue,
                              onChanged: (item) async {
                                payDropdownvalue = item!;
                              },
                              items: pay.map<DropdownMenuItem<String>>((item) {
                                return DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item.toString(),
                                    ));
                              }).toList(),
                            )),
                      ),
                      // Text('Bill Date :'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: const Text(
                          'Amount Received :',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.3,
                        child: SizedBox(
                          // width: screenWidth ,
                          child: TextFormField(
                            onChanged: (value) {
                              calculation();
                            },
                            // autocorrect: false,
                            keyboardType: TextInputType.number,
      
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: appcolor,
                                  width: 3.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: appcolor,
                                  width: 3.0,
                                ),
                              ),
                              // labelText: "Patient Name",
                              border: const OutlineInputBorder(),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            controller: receivedController,
                            focusNode: receivedFocusNode,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: const Text(
                          'Remaining Balance :',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.3,
                        child: Text(
                          '${remain_balance.toInt()}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                
               discountcontroller.text.isNotEmpty ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: const Text(
                          'OTP :',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.3,
                        child: SizedBox(
                          // width: screenWidth ,
                          child: TextFormField(
                            onChanged: (value) {
                              // calculation();
                            },
                            // autocorrect: false,
                            keyboardType: TextInputType.number,
      
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: appcolor,
                                  width: 3.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: appcolor,
                                  width: 3.0,
                                ),
                              ),
                              // labelText: "Patient Name",
                              border: const OutlineInputBorder(),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            controller: otpcontroller,
                            focusNode: OTPFocusNode,
                          ),
                        ),
                      ),
                     
                    ],
                  ),
                ):Container(),
                SizedBox(height: screenHeight*0.02,),
             OTP != null ? Container(
              child: Column(children: [
           
            Text('Session Timeout :${start} sec'),
          ])):Container(),
          SizedBox(height: screenHeight*0.02,),
            discountcontroller.text.isNotEmpty ? Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  // start !=0 ? 
                  send_otp  == false ?   Container(
                        width: screenWidth*0.40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                
                                RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),))),
                          onPressed: (){
                              Sendotp();
                        }, child: Text('Send OTP',style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),)),
                      ): Container(),
      
                     resend_otp  == false ?
                    //  start ==0 ? 
                     Container( 
                        width: screenWidth*0.40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                
                                RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),))),
                          onPressed: (){
                              Resendotp();
                    //            setState(() {
                    //    resend_otp = true;
                    //    OTP = true;
                    //  });
                        }, child: Text('Resend',style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),)),
                      ):Container(),
                      // :collection(),
      
                      Container(
                        width: screenWidth*0.40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                
                                RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),))),
                          onPressed: (){
                            if(otpcontroller.text != OTP){
                              Fluttertoast.showToast(
                      msg:
                          'The OTP You Entered is Invalid. Please Enter The Correct OTP',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white);
                      setState(() {
                        // resend_otp = true;
                        loding = true;
                      //  OTP = true;
                     });
                            }else{
                              NigDocToast().showSuccessToast('message');
                             resend_otp = true;
                             verify_otp ='success';
                            }
      
                        }, child: Text('Verify',style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),)),
                      )
                    ],
                  ),
                ):Container()
      
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
         discountcontroller.text.isEmpty ? Container(
            decoration: BoxDecoration(
                color: appcolor,
                // border: Border.all(color: Colors.blueAccent),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            width: screenWidth * 0.9,
            height: screenHeight * 0.05,
            child: TextButton(
                onPressed: () async {
                 pendingPaybill();
                },
                child: const Text(
                  'To Pay',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
          ):Container(),
          verify_otp =='success' ? Container(
            decoration: BoxDecoration(
                color: appcolor,
                // border: Border.all(color: Colors.blueAccent),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            width: screenWidth * 0.9,
            height: screenHeight * 0.05,
            child: TextButton(
                onPressed: () async {
                 pendingPaybill();
                },
                child: const Text(
                  'To Pay',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
          ):Container(),
        ],
      ),
    );
  }

  calculation() {
    double receiveAmount = receivedController.text.isNotEmpty
        ? double.parse(receivedController.text)
        : 0;
    if (double.parse(bill_amount.toString()) >= receiveAmount) {
      setState(() {
        remain_balance = double.parse(bill_amount.toString()) - receiveAmount;
      });
    } else {
    
      setState(() {
        receivedController.clear();
        remain_balance = double.parse(bill_amount);
      });
      // calculation();
    }
  }
   calculationdiscount() {
    double disAmount = discountcontroller.text.isNotEmpty
        ? double.parse(discountcontroller.text)
        : 0;
    if (double.parse(bill_amount) >= disAmount) {
      setState(() {
        bill_amount = double.parse(bill_amount) - disAmount;
      });
    } else {
     
      setState(() {
        discountcontroller.clear();
        bill_amount = double.parse(bill_amount);
      });
      // calculation();
    }
  }

  pendingPaybill() async {
    if (receivedController.text.isEmpty) {
                          receivedFocusNode.requestFocus();
      Fluttertoast.showToast(
                      msg: 'Please enter the amount',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white);
     
    } else {
      var data = {
        
        'id': id.toString(),
        "patient_id":patient_id.toString(),
        'discount':discountcontroller.text.toString(),
        'amt_received': receivedController.text.toString(),
        'payment_mode':payDropdownvalue,
        'final_amt': bill_amount.toString(),
        'otp':otpcontroller.text.toString(),
       
      };
      print(data);
      var getvalue = await billingapi().DocRegisterReportPay(access_token, data);
      print(getvalue);
      if (getvalue['message'] == 'payment successfully') {
          Fluttertoast.showToast(
                      msg: 'payment successfully',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.green,
                      textColor: Colors.white);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Registerreport()),
        );

      }else{
          Fluttertoast.showToast(
                      msg: 'Please try again later',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white);

      }
    }
  }
  Sendotp()async{
    var data = {
        
        'discount': discountcontroller.text.toString(),
      };
       var sendotp = await billingapi().DocRegisterReportSendOTP(access_token, data);
      print(sendotp);
      if (sendotp['message'] == 'Success') {
          Fluttertoast.showToast(
                      msg: 'successfully',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.green,
                      textColor: Colors.white);

                      OTP =sendotp['otp'].toString();
                      print(OTP);
                      start=10;
                       startTimer();
                  setState(() {
                    send_otp = true;
                    resend_otp = false;
                    // OTP = true;
                  });

      }else{
          Fluttertoast.showToast(
                      msg: 'Please try again later',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white);

      }

  }
  Resendotp()async{
    var data = {
        
        'discount': discountcontroller.text.toString(),
      };
       var sendotp = await billingapi().DocRegisterReportSendOTP(access_token, data);
      print(sendotp);
      if (sendotp['message'] == 'Success') {
          Fluttertoast.showToast(
                      msg: 'successfully',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.green,
                      textColor: Colors.white);

                      OTP =sendotp['otp'].toString();
                      print(OTP);
                      start=10;
                       startTimer();
                  setState(() {
                    send_otp = true;
                    resend_otp = false;
                    // OTP = true;
                  });

      }else{
          Fluttertoast.showToast(
                      msg: 'Please try again later',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white);

      }

  }
startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
            // timerLoading = false;
            // otpbox.set(['1', '2', '3', '4']);
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }
  patient(screenHeight,screenWidth){
return Card(
  color: Colors.white,
  child: SizedBox(
              width: screenWidth,
              height: screenHeight * 0.10,
              // color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          
                          child: Row(
                            children: [
                              const Text(
                                'Name : ',
                                style: TextStyle(fontSize: 18),
                              ),
                               Text(
                                '$p_name',
                                style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              const Text(
                                'Date : ',
                                style: TextStyle(fontSize: 18),
                              ),
                               Text(
                                '${bill_date.toString().substring(0, 10)}',
                                style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
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
);
  }
  total(screenHeight,screenWidth){
    return Container(
   child: Column(
    children: [
      Row(
                                  children: [
                                    Container(
                                      // color: Colors.green,
                                       width: screenWidth*0.95,
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
                                                    // color: Colors.amber,
                                                     width: screenWidth*0.4,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.calendar_month,
                                                          // color: custom_color.appcolor,
                                                          // color: Color
                                                          //     .fromARGB(
                                                          //         255,
                                                          //         98,
                                                          //         96,
                                                          //         96),
                                                        ),
                                                        //  Text(
                                                        //     'Date '),
                                                        Text(
                              '  ${bill_date.toString().substring(0, 10)}',
                              // style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                            ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    // color: Colors.blue,
                                                     width: screenWidth*0.5,
                                                    child: Row(
                                                      children: [
                                                        // Icon(
                                                        //   Icons.calendar_month,
                                                        //   // color: custom_color.appcolor,
                                                        //   // color: Color
                                                        //   //     .fromARGB(
                                                        //   //         255,
                                                        //   //         98,
                                                        //   //         96,
                                                        //   //         96),
                                                        // ),
                                                         Text(
                                                            'Description :', style: TextStyle(
                                                              fontWeight: FontWeight.bold),),
                                                        Text(
                                                            ' Total Fees')
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
                                                  
                                                     Text(
                                                        'Mode of Pay : ', style: TextStyle(
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),),
                                                    // Text(
                                                    //     ' ${data['p_name'].toString()}')
                                                  ],
                                                ),
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
                                                     width: screenWidth*0.4,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Amt : ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                            def_amount)
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    // color: Colors.blue,
                                                     width: screenWidth*0.5,
                                                    // width: screenwidht * 0.55,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Total Dis : ',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        // Text(
                                                        //     '${data['extra_fees'].toString()}')
                                                      ],
                                                    ),
                                                  ),
                                                
                                             
                                                ],
                                              ),
                                            ),
                                             Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Bal : ',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        // Text(
                                                        //     '${data['total_fees'].toString()}')
                                                      ],
                                                    ),
                                                  ),
                                                 
                                                ],
                                              ),
                                            ),
                                           
                                          ],
                                        ),
                                      ),
                                    ),
                                     
                                  ],
      ),
    ],
   ),
    );
  
  }
  BillPayList(screenHeight,screenWidth){
 return Padding(
   padding: const EdgeInsets.all(5.0),
   child: Container(
       // height: screenHeight * 0.7596,
       child: Helper().isvalidElement(register_reportpay) &&
               register_reportpay.length > 0
           ? 
             ListView.builder(
               itemCount: register_reportpay.length,
               physics: NeverScrollableScrollPhysics(),
               //  itemCount: 2,
                shrinkWrap: true,
               itemBuilder:
                   (BuildContext context, int index) {
                 var data = register_reportpay[index];
                 return Center(
                   child: Container(
                     color: index % 2 == 0
                         ? Color.fromARGB(
                             255, 238, 242, 250)
                         : Colors.white,
                     width: screenWidth,
                     // height: screenHeight * 0.20,
                     // width: screenWidth * 0.90,
                     // decoration:
                     //     BoxDecoration(border: Border.all(color: Colors.grey)),
                     child: Row(
                       children: [
                         Container(
                            width: screenWidth*0.95,
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
                                         // color: Colors.yellow,
                                          width: screenWidth*0.4,
                                         child: Row(
                                           children: [
                                             Icon(
                                               Icons.calendar_month,
                                               // color: custom_color.appcolor,
                                               // color: Color
                                               //     .fromARGB(
                                               //         255,
                                               //         98,
                                               //         96,
                                               //         96),
                                             ),
                                             //  Text(
                                             //     'Date '),
                                             Text(
                                                 '  ${data['date'].toString().substring(0, 10)}')
                                           ],
                                         ),
                                       ),
                                       Container(
                                         // color: Colors.blue,
                                          width: screenWidth*0.5,
                                         child: Row(
                                           children: [
                                             // Icon(
                                             //   Icons.calendar_month,
                                             //   // color: custom_color.appcolor,
                                             //   // color: Color
                                             //   //     .fromARGB(
                                             //   //         255,
                                             //   //         98,
                                             //   //         96,
                                             //   //         96),
                                             // ),
                                              Text(
                                                 'Description :', style: TextStyle(
                                                   fontWeight: FontWeight.bold),),
                                             Text(
                                                 ' ${data['description'].toString().substring(0, 10)}')
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
                                       
                                          Text(
                                             'Mode of Payt : ', style: TextStyle(
                                               fontWeight:
                                                   FontWeight
                                                       .bold),),
                                         Text(
                                             ' ${data['payment_mode'].toString()}')
                                       ],
                                     ),
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
                                         // color: Colors.deepOrange,
                                          width: screenWidth*0.4,
                                         child: Row(
                                           children: [
                                             Text(
                                               'Amt : ',
                                               style: TextStyle(
                                                   fontWeight:
                                                       FontWeight
                                                           .bold),
                                             ),
                                             Text(
                                                 '${data['amount'].toString()}')
                                           ],
                                         ),
                                       ),
                                       Container(
                                         // color: Colors.blue,
                                          width: screenWidth*0.5,
                                         // width: screenwidht * 0.55,
                                         child: Row(
                                           children: [
                                             Text(
                                               'Total Dis : ',
                                               style: TextStyle(
                                                   fontWeight: FontWeight.bold),
                                             ),
                                             Text(
                                                 '${data['discount'].toString()}.00')
                                           ],
                                         ),
                                       ),
                                     
                                  
                                     ],
                                   ),
                                 ),
                                  Padding(
                                   padding:
                                       const EdgeInsets.all(1.0),
                                   child: Row(
                                     mainAxisAlignment:
                                         MainAxisAlignment
                                             .spaceBetween,
                                     children: [
                                       Container(
                                         child: Row(
                                           children: [
                                             Text(
                                               'Bal : ',
                                               style: TextStyle(
                                                   fontWeight: FontWeight.bold),
                                             ),
                                             Text(
                                                 '${data['balance'].toString()}')
                                           ],
                                         ),
                                       ),
                                      
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
               child: Text(''),
             )
       
       ),
 );
  }
}
