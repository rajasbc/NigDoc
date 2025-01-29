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


class RegisterReportPaid extends StatefulWidget {
  const RegisterReportPaid({super.key});

  @override
  State<RegisterReportPaid> createState() => _RegisterReportPaidState();
}

class _RegisterReportPaidState extends State<RegisterReportPaid> {
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
  int start = 60;
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
                    'Register Report Bill Paid',
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
                          'Total Paid (₹) :',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.3,
                        child: Text(
                          '$total_amount',
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
                          'Bal Amt (₹) : ',
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
      
              
              ],
            ),
          ),
          
        ],
      ),
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
                                                        'Pay Method : ', style: TextStyle(
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
                                                          'Amt (₹) : ',
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
                                                          'Total Dis (₹) : ',
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
                                                          'Bal (₹) : ',
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
                                             'Pay Method : ', style: TextStyle(
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
                                               'Amt (₹) : ',
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
                                               'Total Dis (₹) : ',
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
                                               'Bal (₹) : ',
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
