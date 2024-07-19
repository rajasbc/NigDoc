import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/AppWidget/common/Colors.dart';
import 'package:nigdoc/AppWidget/BillingWidget/Api.dart';
import 'package:nigdoc/AppWidget/BillingWidget/View/Pendingbilllist.dart';
import 'package:nigdoc/AppWidget/common/Colors.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';


class PendingPayment extends StatefulWidget {
  const PendingPayment({super.key});

  @override
  State<PendingPayment> createState() => _PendingPaymentState();
}

class _PendingPaymentState extends State<PendingPayment> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  TextEditingController receivedController = TextEditingController();
  var p_name;
  var total_amount;
  var discount;
  var test_bill_amount;
  var bill_date;
  var bill_no;
  var paid;
  var bill_id;
  double remain_balance = 0.0;
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
    var payment = await storage.getItem('pendingAmount');
    
    setState(() {
      p_name = payment['customer_name'].toString();
      bill_no = payment['presc_id'].toString();
      bill_date = payment['setdate'].toString();
      total_amount = payment['grand_total'].toString();
      discount = payment['discount'].toString();
      test_bill_amount = payment['balance'].toString();
      paid = payment['paid'].toString();
      bill_id = payment['id'].toString();
      remain_balance= double.parse(test_bill_amount);
    });
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
       
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Pendingbilllist()),
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
    )
    ;
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
          MaterialPageRoute(builder: (context) => const Pendingbilllist()),
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
                    'Pending Bill Pay',
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
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.15,
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
                              'Name :',
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
                              'Bill Date : ',
                              style: TextStyle(fontSize: 18),
                            ),
                             Text(
                              '$bill_date',
                              style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            const Text(
                              'Bill No : ',
                              style: TextStyle(fontSize: 18),
                            ),
                             Text(
                              '$bill_no',
                              style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                            ),
                            
                          ],
                        ),
                      ),
                      // Text('Bill Date :'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.07,
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
            height: screenHeight * 0.17,
            // color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: const Text(
                          'Total Bill Amount :',
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: const Text(
                          'Discount: ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),

                      SizedBox(
                        width: screenWidth * 0.3,
                        child: Text(
                          '$discount',
                          style: const TextStyle(fontSize: 18),
                        ),
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
                          'Balance Bill Amount :',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.3,
                        child: Text(
                          '$test_bill_amount ',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.07,
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
            height: screenHeight * 0.3,
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
                          'Payment Method: ',
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
                          'Balance Received :',
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
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: appcolor,
                // border: Border.all(color: Colors.blueAccent),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            width: screenWidth * 0.9,
            height: screenHeight * 0.06,
            child: TextButton(
                onPressed: () async {
                 pendingPaybill();
                },
                child: const Text(
                  'To pay',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ],
      ),
    );
  }

  calculation() {
    double receiveAmount = receivedController.text.isNotEmpty
        ? double.parse(receivedController.text)
        : 0;
    if (double.parse(test_bill_amount) >= receiveAmount) {
      setState(() {
        remain_balance = double.parse(test_bill_amount) - receiveAmount;
      });
    } else {
      // NigLabsToast()
      //     .showErrorToast('Received amount is more than balance amount');
      setState(() {
        receivedController.clear();
        remain_balance = double.parse(test_bill_amount);
      });
      // calculation();
    }
  }

  pendingPaybill() async {
    if (receivedController.text.isEmpty) {
      Fluttertoast.showToast(
                      msg: 'Please enter the amount',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white);
     
    } else {
      var data = {
        'prescription_id': bill_id.toString(),
        'dent_presc_id':bill_no.toString(),
        'balance': remain_balance.toInt(),
        'pay_amt': receivedController.text.toString(),
        'payment_mode': payDropdownvalue
      };
      print(data);
      var getvalue = await billingapi().pendingpayment(access_token, data);
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
          MaterialPageRoute(builder: (context) => Pendingbilllist()),
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
}
