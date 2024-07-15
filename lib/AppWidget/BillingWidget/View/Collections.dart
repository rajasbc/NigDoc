import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Collections extends StatefulWidget {
  const Collections({super.key});

  @override
  State<Collections> createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
late DateTime date;

  DateTimeRange pendingdateRange = DateTimeRange(
    start: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 7),
    end:
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  );
   DateTimeRange paiddateRange = DateTimeRange(
    start: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 7),
    end:
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  );
  DateTimeRange canceldateRange = DateTimeRange(
    start: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 7),
    end:
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  );
   String active_tab = 'Pending';

  @override
  Widget build(BuildContext context) {
    final pendingstart = pendingdateRange.start;
    final pendingend = pendingdateRange.end;
    final paidstart = paiddateRange.start;
    final paidend = paiddateRange.end;
    final cancelstart = canceldateRange.start;
    final cancelend = canceldateRange.end;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenwidht = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Bill List'),),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
               decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: screenwidht * 0.30,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  active_tab == 'Pending'
                                      ? Colors.blue[50]
                                      : Colors.white)),
                          child: Text(
                            "PENDING",
                          ),
                          onPressed: () => {
                            this.setState(() {
                              active_tab = 'Pending';
                              // personal_check = !personal_check;
                            })
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenwidht * 0.30,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  active_tab == 'paid'
                                      ? Colors.blue[50]
                                      : Colors.white)),
                          child: Text(
                            "PAID",
                          ),
                          onPressed: () => {
                            this.setState(() {
                              active_tab = 'paid';
                              // personal_check = !personal_check;
                            })
                          },
                        ),
                      ),
                    ),
                     SizedBox(
                      width: screenwidht * 0.30,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  active_tab == 'Cancel'
                                      ? Colors.blue[50]
                                      : Colors.white)),
                          child: Text(
                            "CANCEL",
                          ),
                          onPressed: () => {
                            this.setState(() {
                              active_tab = 'Cancel';
                              // personal_check = !personal_check;
                            })
                          },
                        ),
                      ),
                    ),
                  ],
                ),
            ),
            SizedBox(height: 10,),

            active_tab=='Pending'?Container(
              child:
                Column(
                  children: [
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
                                        '${pendingstart.year}/${pendingstart.month}/${pendingstart.day}',
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
                                    child:
                                        Text('${pendingend.year}/${pendingend.month}/${pendingend.day}'),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: screenHeight*0.70,
                      child: 
                      
                      // Helper().isvalidElement(Stafflist) &&
                      //                   Stafflist.length > 0? 

                                      
                                        ListView.builder(
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          // var data = Stafflist[index];
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: index % 2 == 0
                                    ? Color.fromARGB(255, 210, 225, 231)
                                    : Colors.white,
                                width: screenwidht,
                                // height: screenHeight * 0.20,
                                // width: screenWidth * 0.90,
                                // decoration:
                                //     BoxDecoration(border: Border.all(color: Colors.grey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: screenwidht * 0.50,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Name :',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text("khan")
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Phone :',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold),
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
                                              width: screenwidht * 0.55,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Prescription Id :',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text('45')
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Date :',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text('4-02-23023')
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                       Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              // width: screenwidht * 0.55,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Patient Id :',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text('45')
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Fess(₹) :',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text('23443')
                                                ],
                                              ),
                                            ),
                                             Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Discount(₹) :',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text('23442')
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              // width: screenwidht * 0.55,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Paid(₹) :',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text('0.50')
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Recieved(₹) :',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text('0.50')
                                                ],
                                              ),
                                            ),
                                             Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Balance(₹) :',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text('0.50')
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
                            ),
                          );
                        })
                        // :
                        // Text('Nodata'),
                    )
                  ],
                ),
            )
            : active_tab=='paid'?Container(
               child:
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
                                    paidpickDateRange();
                                   
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
                                  paidpickDateRange();
                                },
                                child:
                                    Text('${paidend.year}/${paidend.month}/${paidend.day}'),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
            ):Container(
               child:
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
                                    cancelpickDateRange();
                                   
                                  },
                                  child: Text(
                                    '${cancelstart.year}/${cancelstart.month}/${cancelstart.day}',
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
                                  cancelpickDateRange();
                                },
                                child:
                                    Text('${cancelend.year}/${cancelend.month}/${cancelend.day}'),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                
            )
          ],
        ),
      ),
    );
  }
   Future pendingpickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: pendingdateRange,
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
                foregroundColor: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      pendingdateRange = newDateRange ?? pendingdateRange;

      // if (newDateRange == null) return;
      // setState(() => dateRange = newDateRange);
    });
    // getPatientRegisterReportList();
    // this.setState(() {});
  }
  Future paidpickDateRange() async {
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
                foregroundColor: Colors.red, // button text color
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
  Future cancelpickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: canceldateRange,
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
                foregroundColor: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      canceldateRange = newDateRange ?? canceldateRange;

      // if (newDateRange == null) return;
      // setState(() => dateRange = newDateRange);
    });
    // getPatientRegisterReportList();
    // this.setState(() {});
  }
}
