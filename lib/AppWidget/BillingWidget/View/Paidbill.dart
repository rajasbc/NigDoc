import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Paidbill extends StatefulWidget {
  const Paidbill({super.key});

  @override
  State<Paidbill> createState() => _PaidbillState();
}

class _PaidbillState extends State<Paidbill> {
  late DateTime date;

  DateTimeRange paiddateRange = DateTimeRange(
    start: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 7),
    end:
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  );
  @override
  Widget build(BuildContext context) {
    final paidstart = paiddateRange.start;
    final paidend = paiddateRange.end;
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
            Container(
              height: screenHeight * 0.07,
              width: screenwidht * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: screenwidht * 0.45,
                    child: Row(
                      children: [
                        Container(
                          width: screenwidht * 0.10,
                          child: Text('From:'),
                        ),
                        Container(
                            width: screenwidht * 0.30,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue)),
                              onPressed: () {
                                pendingpickDateRange();
                              },
                              child: Text(
                                '${paidstart.year}/${paidstart.month}/${paidstart.day}',
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    width: screenwidht * 0.45,
                    child: Row(
                      children: [
                        Container(
                          width: screenwidht * 0.07,
                          child: Text('To:'),
                        ),
                        Container(
                          width: screenwidht * 0.30,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue)),
                            onPressed: () {
                              pendingpickDateRange();
                            },
                            child: Text(
                                '${paidend.year}/${paidend.month}/${paidend.day}'),
                          ),
                        )
                      ],
                    ),
                  )
                ],
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

  Future pendingpickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: paiddateRange,
      firstDate: DateTime(2019),
      lastDate: DateTime(2024),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.blue, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      paiddateRange = newDateRange ?? paiddateRange;

      // if (newDateRange == null) return;
      // setState(() => dateRange = newDateRange);
    });
    // getPatientRegisterReportList();
    // this.setState(() {});
  }
}
