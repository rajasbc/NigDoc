import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';


class Paidbill extends StatefulWidget {
  const Paidbill({super.key});

  @override
  State<Paidbill> createState() => _PaidbillState();
}

class _PaidbillState extends State<Paidbill> {

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
                primary: Colors.blue,
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: Colors.blue, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.blue, // button text color
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
      // getbendingbilllist();
    } else {
      todateInputController.text = DateFormat(DateFormate).format(pickedDate!);
      // todateInputController.text = pickedDate.toString().split(' ')[0];
      // getbendingbilllist();
    }
  }
  @override
  Widget build(BuildContext context) {
    // final paidstart = paiddateRange.start;
    // final paidend = paiddateRange.end;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenwidht = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Paid Bill List'),
      ),
      body: Container(
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
                            color: Colors.blue,
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
                              color: Colors.blue,
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
            Container(
                height: screenHeight * 0.78,
                child:

                    // Helper().isvalidElement(Stafflist) &&
                    //                   Stafflist.length > 0?

                    ListView.builder(
                        itemCount: 8,
                        itemBuilder: (BuildContext context, int index) {
                          // var data = Stafflist[index];
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: index % 2 == 0
                                      ? Color.fromARGB(255, 190, 196, 199)
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
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: screenwidht * 0.47,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Name:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text("khan")
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Phone:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text('87654323456')
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
                                                width: screenwidht * 0.47,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Prescription Id:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text('45')
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Date:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text('4-02-23023')
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 1,
                                              top: 1,
                                              bottom: 1,
                                              right: 28),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                // width: screenwidht * 0.55,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'PatientId:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text('45')
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Fess(₹):',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text('23443')
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Discount(₹):',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text('23442')
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 1,
                                              top: 1,
                                              bottom: 1,
                                              right: 28),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                // width: screenwidht * 0.55,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Paid(₹):',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text('0.50')
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Recieved(₹):',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text('0.50')
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Balance(₹):',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text('0.50')
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: screenwidht * 0.47,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Paaid Details:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text('.................')
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Invoice:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text('.............')
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                // width: screenwidht * 0.47,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Invoice Prescription :',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text('.........')
                                                  ],
                                                ),
                                              ),
                                              // Container(
                                              //   child: Row(
                                              //     children: [
                                              //       Text(
                                              //         'Invoice:',
                                              //         style: TextStyle(
                                              //             fontWeight: FontWeight.bold),
                                              //       ),
                                              //       Text('.............')
                                              //     ],
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                // :
                // Text('Nodata'),
                )
          ],
        ),
      ),
    );
  }

  // Future pendingpickDateRange() async {
  //   DateTimeRange? newDateRange = await showDateRangePicker(
  //     context: context,
  //     initialDateRange: paiddateRange,
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
  //     paiddateRange = newDateRange ?? paiddateRange;

  //     // if (newDateRange == null) return;
  //     // setState(() => dateRange = newDateRange);
  //   });
  //   // getPatientRegisterReportList();
  //   // this.setState(() {});
  // }
}
