import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/BillingWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../Common/colors.dart' as Customcolor;

class Cancelledbill extends StatefulWidget {
  const Cancelledbill({super.key});

  @override
  State<Cancelledbill> createState() => _CancelledbillState();
}

class _CancelledbillState extends State<Cancelledbill> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  final DateFormate = "dd-MM-yyyy";
  TextEditingController fromdateInputController = TextEditingController();
  TextEditingController todateInputController = TextEditingController();


var accesstoken;
  bool isLoading = false;
  var cancellbill;


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
      getcancelledlist();
    } else {
      todateInputController.text = DateFormat(DateFormate).format(pickedDate!);
      // todateInputController.text = pickedDate.toString().split(' ')[0];
    getcancelledlist();
    }
  }

 

  void initState() {
    super.initState();
    accesstoken = storage.getItem('userResponse')['access_token'];
    fromdateInputController.text = Helper().getCurrentDate()  ;
    todateInputController.text = Helper().getCurrentDate();
    getcancelledlist();
    
    // print('ddd');
  }
  @override
  Widget build(BuildContext context) {
    // final cancelstart = canceldateRange.start;
    // final cancelend = canceldateRange.end;
     var screenHeight = MediaQuery.of(context).size.height;
    var screenwidht = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Cancelled Bill List'),
      backgroundColor: Customcolor.appcolor,
      ),
      body: Container(
         child:
                Column(
                  children: [
                    SizedBox(height: 10,),
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
                  height: screenHeight * 0.7596,
                        child: 
                        
                        Helper().isvalidElement(cancellbill) &&
                                          cancellbill.length > 0? 
                    
                                        
                                          ListView.builder(
                          itemCount: cancellbill.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = cancellbill[index];
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              // width: screenwidht * 0.47,
                                              child: Row(
                                                children: [
                                                 Icon(Icons.person,color:Color.fromARGB(255, 98, 96, 96),),
                                                    Helper().isvalidElement(data['customer_name'])  ? Text(
                                                      '${data['customer_name'].toString()}')  : Text(''),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                 Icon(Icons.phone,color:Color.fromARGB(255, 98, 96, 96),),
                                                  Text('${data['cus_phone'].toString()}')
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                           
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(Icons.calendar_month,color:Color.fromARGB(255, 98, 96, 96),),
                                                  Text('${data['date'].toString().substring(0,10)}')
                                                ],
                                              ),
                                            ),
                                              Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Discount :',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text('${data['discount'].toString()}')
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                       
                                     
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              // width: screenwidht * 0.55,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Fess :',
                                                    // style: TextStyle(
                                                    //     fontWeight: FontWeight.bold),
                                                  ),
                                                  Text('${data['grand_total'].toString()}')
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Paid :',
                                                    // style: TextStyle(
                                                    //     fontWeight: FontWeight.bold),
                                                  ),
                                                  Text('${data['grand_total'] - data['balance']}')
                                                ],
                                              ),
                                            ),
                                             Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Status :',
                                                    // style: TextStyle(
                                                    //     fontWeight: FontWeight.bold),
                                                  ),
                                                  Text('${data['pay_status'].toString()}')
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }):Container()
                          // :
                          // Text('Nodata'),
                      ),
                    )
                  ],
                ),
      ),
    );
  }
  //  Future pendingpickDateRange() async {
  //   DateTimeRange? newDateRange = await showDateRangePicker(
  //     context: context,
  //     initialDateRange: canceldateRange,
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
  //     canceldateRange = newDateRange ?? canceldateRange;

  //     // if (newDateRange == null) return;
  //     // setState(() => dateRange = newDateRange);
  //   });
  //   // getPatientRegisterReportList();
  //   // this.setState(() {});
  // }
  getcancelledlist()async{
 var formatter = new DateFormat('yyyy-MM-dd');
    var data = {
      "from_date": fromdateInputController.text.toString(),
      "to_date": todateInputController.text.toString(),
      "status_type": "Cancelled",
    };
    // this.setState(() {
    //   isLoading = true;
    // });
    cancellbill = await billingapi().getpendinglist(accesstoken, data);
    if (Helper().isvalidElement(cancellbill) &&
        Helper().isvalidElement(cancellbill['status']) &&
        cancellbill['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      cancellbill = cancellbill['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isLoading = false;
      });
    }
  }
}
