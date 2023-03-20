import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Dashboardpage.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({super.key});

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  TextEditingController searchText = TextEditingController();
  TextEditingController fees = TextEditingController();
  TextEditingController labnameController = TextEditingController();
  TextEditingController testnameController = TextEditingController();
  TextEditingController medicineController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController grandtotalController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController receivedController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController changeController = TextEditingController();

  var searchList;

  String treatmentDropdownvalue = 'Select Treatment';
  String patternDropdownvalue = 'pattern';
  String prescriptionDropdownvalue = 'Prescription';
  var select_button = 'treatment';
  var Medicine = 'Medicine';
  var total;
  var count;
  var cal;
  double grand_total = 0.0;
  double balance=0;

  var treatment = ['Select Treatment', 'Ferver', 'Head Ache'];
  // var pattern = ['pattern', '0-0-0', '1-1-1', '1-0-1'];
  var demo = {
    {"name": "pattern", "value": "0"},
    {"name": "0-0-1", "value": "1"},
    {"name": "0-1-0", "value": "2"},
    {"name": "0-1-1", "value": "3"},
    {"name": "1-0-0", "value": "4"},
    {"name": "1-0-1", "value": "5"},
    {"name": "1-1-0", "value": "2"},
    {"name": "1-1-1", "value": "3"},
    {"name": "0-0-2", "value": "2"},
    {"name": "0-2-0", "value": "2"},
    {"name": "2-0-0", "value": "2"},
    {"name": "2-2-0", "value": "4"},
    {"name": "0-2-2", "value": "4"},
    {"name": "2-0-2", "value": "4"},
    {"name": "2-2-2", "value": "6"},
  };
  var Prescription = ['Prescription', 'BF', 'AF'];
  List treatmentList = [];
  List testList = [];
  List medicineList = [];
  List table_list = [];
  @override
  void initState() { 
    super.initState();
    grandtotalController.text=grand_total.toString();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 50;
    double screenWidth = MediaQuery.of(context).size.width;
    return new WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dashboardpage()),
        );
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // resizeToAvoidBottomInset: false,
        // resizeToAvoidBottomInset: false,

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 8, 122, 135),
            title: const Text(
              'Prescription',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            // actions: [
            //   IconButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const Dashboardpage()),
            //         );
            //       },
            //       icon: Icon(
            //         Icons.people_alt_outlined,
            //         color: Colors.black,
            //       )),
            // ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              children: [
                Card(
                    child: Container(
                  height: screenHeight * 0.08,
                  width: screenWidth,
                  // color:Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 5, right: 5),
                    child: Container(
                      // height: screenHeight * 0.06,
                      width: screenWidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 8, 122, 135)),
                          borderRadius: BorderRadius.all(Radius.circular(1))),
                      child: Row(
                        children: [
                          Container(
                              width: screenWidth * 0.1,
                              height: screenHeight,
                              child: Icon(Icons.search,
                                  color: Color.fromARGB(255, 8, 122, 135))),
                          Container(
                            width: screenWidth * 0.7,
                            child: TextField(
                              controller: searchText,
                              onChanged: (text) {
                                print(text);

                                this.setState(() {});

                                // searchList = StaffList.where((element) {
                                //   var List =
                                //       element['name'].toString().toLowerCase();
                                //   return List.contains(text.toLowerCase());
                                //   // return true;
                                // }).toList();
                                // this.setState(() {});
                              },
                              decoration: new InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                hintText: 'Search Patient list...',
                              ),
                            ),
                          ),
                          searchText.text.isNotEmpty
                              ? Container(
                                  width: screenWidth * 0.1,
                                  height: screenHeight,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        searchText.text = '';
                                        searchList = '';
                                      });
                                    },
                                  ))
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                )),
                Container(
                    child: Column(
                  children: [
                    Card(
                      child: ListTile(
                        title: Row(
                          children: [
                            Icon(Icons.people,
                                color: Color.fromARGB(255, 8, 122, 135)),
                            Text(
                              '    Patient name',
                            ),
                          ],
                        ),
                        subtitle: Text('           9874563210'),
                        trailing: IconButton(
                          onPressed: () {
                            // setState(() {
                            //   treatmentList.remove(data);
                            // });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    // ListTile(title: Text('Test name'),
                    // trailing: IconButton(onPressed: (){} ,icon: Icon(Icons.add)),),
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: Container(
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              color: select_button == "treatment"
                                  ? Colors.blue
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              "Treatment",
                              style: TextStyle(
                                  color: select_button == "treatment"
                                      ? Colors.white
                                      : Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          onTap: () {
                            this.setState(() {
                              select_button = "treatment";
                              // billList();
                            });
                          },
                        ),
                        InkWell(
                          child: Container(
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              color: select_button == "test"
                                  ? Colors.blue
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              "TEST",
                              style: TextStyle(
                                  color: select_button == "test"
                                      ? Colors.white
                                      : Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          onTap: () {
                            this.setState(() {
                              select_button = "test";
                              // billList();
                            });
                          },
                        ),
                        InkWell(
                          child: Container(
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              color: select_button == "medicine"
                                  ? Colors.blue
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              "Medicine",
                              style: TextStyle(
                                  color: select_button == "medicine"
                                      ? Colors.white
                                      : Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          onTap: () {
                            this.setState(() {
                              select_button = "medicine";
                              // billList();
                            });
                          },
                        ),
                        InkWell(
                          child: Container(
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              color: select_button == "injection"
                                  ? Colors.blue
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              "Injection",
                              style: TextStyle(
                                  color: select_button == "injection"
                                      ? Colors.white
                                      : Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          onTap: () {
                            this.setState(() {
                              select_button = "injection";
                              // billList();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                select_button == "treatment"
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.65,
                          child: SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    height: screenHeight * 0.08,
                                    width: screenWidth,
                                    // color:Colors.amber,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5, left: 0, right: 0),
                                      child: Container(
                                        // height: screenHeight * 0.06,
                                        width: screenWidth,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            // border: Border.all(
                                            //     color: Color.fromARGB(255, 12, 12, 12)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Container(
                                            //     width: screenWidth * 0.1,
                                            //     height: screenHeight,
                                            //     child: Icon(Icons.search,
                                            //         color: Color.fromARGB(255, 8, 122, 135))),
                                            Container(
                                              width: screenWidth * 0.7,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: DropdownButtonFormField(
                                                  value: treatmentDropdownvalue,
                                                  autovalidateMode:
                                                      AutovalidateMode.always,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty ||
                                                        value == "Title") {
                                                      return 'please select Title';
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Treatment',
                                                    border:
                                                        OutlineInputBorder(),
                                                    //icon: Icon(Icons.numbers),
                                                  ),
                                                  items: treatment
                                                      .map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(items),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      treatmentDropdownvalue =
                                                          newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            Container(
                                                width: screenWidth * 0.1,
                                                height: screenHeight,
                                                color: Colors.grey,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  ),
                                                  onPressed: () {
                                                    // setState(() {
                                                    //   searchText.text = '';
                                                    //   searchList = '';
                                                    // });

                                                    // child:
                                                    // showModalBottomSheet(
                                                    //     context: context,
                                                    //     isScrollControlled: true,
                                                    //     shape: const RoundedRectangleBorder(
                                                    //       borderRadius: BorderRadius.only(
                                                    //         topRight: Radius.circular(25.0),
                                                    //         topLeft: Radius.circular(25.0),
                                                    //       ),
                                                    //     ),
                                                    //     builder: (context) {
                                                    //       return SizedBox(
                                                    //         height: 300,
                                                    //         width: MediaQuery.of(context)
                                                    //             .size
                                                    //             .width,
                                                    //         child: const Center(
                                                    //           child: Text(
                                                    //             "Flutter Frontend",
                                                    //             style: TextStyle(
                                                    //               color: Colors.black,
                                                    //               fontSize: 25,
                                                    //               fontWeight: FontWeight.bold,
                                                    //             ),
                                                    //           ),
                                                    //         ),
                                                    //       );
                                                    //     });
                                                  },
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 180,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Fees',
                                              border: OutlineInputBorder(),
                                              // icon: Icon(Icons.numbers),
                                            ),
                                            controller: fees,
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                          ),
                                        ),
                                        SizedBox(
                                          // width: 100,
                                          child: TextButton(
                                              onPressed: () async {
                                                var data = {
                                                  "treatment":
                                                      treatmentDropdownvalue
                                                          .toString(),
                                                  "fees": fees.text.toString(),
                                                };

                                                print(data);

                                                print(data);
                                                print(treatmentList);
                                                print(treatmentList
                                                    .contains(data));
                                                if (treatmentList
                                                    .contains(data)) {
                                                  treatmentList.remove(data);
                                                } else {
                                                  treatmentList.add(data);
                                                }
                                                print(treatmentList);
                                                setState(() {
                                                  fees.clear();
                                                  treatmentDropdownvalue =
                                                      'Select Treatment';
                                                });
                                              },
                                              child: Text(
                                                "ADD TREATMENT",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color.fromARGB(
                                                              255, 10, 132, 87)),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(4.0),
                                                          side: BorderSide(color: Colors.blue))))),

                                          // TextFormField(
                                          //   decoration: const InputDecoration(
                                          //     labelText: 'Clinic Notes',
                                          //     border: OutlineInputBorder(),
                                          //     //icon: Icon(Icons.numbers),
                                          //   ),

                                          //   // controller: addressController,

                                          // ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Helper().isvalidElement(treatmentList) &&
                                        treatmentList.length > 0
                                    ? Container(
                                        width: screenWidth,
                                        child: Text(
                                          '  Treatment List :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      )
                                    : Container(),
                                Container(
                                    padding: const EdgeInsets.all(5),
                                    // height: screenHeight * 0.6,
                                    width: screenWidth,
                                    child: Helper()
                                            .isvalidElement(treatmentList)
                                        ? ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: treatmentList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final data = treatmentList[index];
                                              return Container(
                                                  child: Column(
                                                children: [
                                                  Card(
                                                    child: ListTile(
                                                      title: Text(
                                                        '${data['treatment'].toString()}',
                                                      ),
                                                      subtitle: Text(
                                                          '${"₹ " + data['fees'].toString()}'),
                                                      trailing: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            treatmentList
                                                                .remove(data);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // ListTile(title: Text('Test name'),
                                                  // trailing: IconButton(onPressed: (){} ,icon: Icon(Icons.add)),),
                                                  Divider(
                                                    height: 0.1,
                                                  )
                                                ],
                                              ));
                                            })
                                        : Container()),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                select_button == "test"
                    ? Container(
                        height: screenHeight * 0.7,
                        child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: screenWidth,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        // width: 180,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            labelText: 'Lab Name',
                                            border: OutlineInputBorder(),
                                            // icon: Icon(Icons.numbers),
                                          ),
                                          controller: labnameController,
                                          // keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        // width: 180,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            labelText: 'Test Name',
                                            border: OutlineInputBorder(),
                                            // icon: Icon(Icons.numbers),
                                          ),
                                          controller: testnameController,
                                          // keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: TextButton(
                                            onPressed: () async {
                                              var test = {
                                                "lab_name": labnameController
                                                    .text
                                                    .toString(),
                                                "test_name": testnameController
                                                    .text
                                                    .toString(),
                                              };

                                              print(test);

                                              print(test);
                                              print(testList);
                                              print(testList.contains(test));
                                              if (testList.contains(test)) {
                                                testList.remove(test);
                                              } else {
                                                testList.add(test);
                                              }
                                              print(testList);
                                              setState(() {
                                                labnameController.clear();
                                                testnameController.clear();
                                              });
                                            },
                                            child: Text(
                                              "ADD TEST",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        Color.fromARGB(
                                                            255, 10, 132, 87)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                4.0),
                                                        side: BorderSide(color: Colors.blue))))),

                                        // TextFormField(
                                        //   decoration: const InputDecoration(
                                        //     labelText: 'Clinic Notes',
                                        //     border: OutlineInputBorder(),
                                        //     //icon: Icon(Icons.numbers),
                                        //   ),

                                        //   // controller: addressController,

                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Helper().isvalidElement(testList) &&
                                      select_button == 'test' &&
                                      testList.length > 0
                                  ? Container(
                                      width: screenWidth,
                                      child: Text(
                                        '  Test List :',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    )
                                  : Container(),
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  // height: screenHeight * 0.6,
                                  width: screenWidth,
                                  child: Helper().isvalidElement(testList) &&
                                          select_button == 'test'
                                      ? ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: testList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final data = testList[index];
                                            return Container(
                                                child: Column(
                                              children: [
                                                Card(
                                                  child: ListTile(
                                                    title: Text(
                                                      'Lab Name: ${data['lab_name'].toString()}',
                                                    ),
                                                    subtitle: Text(
                                                        'Test Name: ${data['test_name'].toString()}'),
                                                    trailing: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          testList.remove(data);
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // ListTile(title: Text('Test name'),
                                                // trailing: IconButton(onPressed: (){} ,icon: Icon(Icons.add)),),
                                                Divider(
                                                  height: 0.1,
                                                )
                                              ],
                                            ));
                                          })
                                      : Container()),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                select_button == "medicine"
                    ? Container(
                        height: screenHeight * 0.7,
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          //  reverse: true,

                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    child: Column(
                                  children: [
                                    SizedBox(
                                      width: screenWidth,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: 'Medicine Name',
                                          border: OutlineInputBorder(),
                                          // icon: Icon(Icons.numbers),
                                        ),
                                        controller: medicineController,
                                        // keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.455,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Price',
                                              border: OutlineInputBorder(),
                                              // icon: Icon(Icons.numbers),
                                            ),
                                            controller: priceController,
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.455,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Day',
                                              border: OutlineInputBorder(),
                                              // icon: Icon(Icons.numbers),
                                            ),
                                            controller: dayController,
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.455,
                                          child: DropdownButtonFormField(
                                            // validator: (value) => validateDrops(value),
                                            // decoration: InputDecoration(
                                            //     enabledBorder: InputBorder.none,
                                            //     border: UnderlineInputBorder(
                                            //         borderSide: BorderSide(
                                            //             color: Colors.white))),
                                            decoration:
                                                InputDecoration.collapsed(
                                                    hintText: ''),

                                            isExpanded: true,
                                            hint: Text(
                                              'Select Pattern',
                                            ),
                                            // value:patternDropdownvalue,
                                            onChanged: (item) async {
                                              patternDropdownvalue =
                                                  item.toString();
                                              var data =
                                                  item.toString().split('&*');
                                              count = data[0];

                                              // selectedPharmacyDetails =
                                              //     item.toString().split('&*');
                                              // data = {
                                              //   'mobile_no': storage
                                              //       .getItem('user_mobileno'),
                                              //   'shop_id':
                                              //       selectedPharmacyDetails[0]
                                              // };
                                              // setState(() {
                                              //   selectedList = null;
                                              // });
                                              // await getcustomerlist(data);
                                              // setState(() {
                                              //     pharmacyDropdownvalue = item;
                                              // });
                                              // data = {
                                              //   'mobile_no': storage
                                              //       .getItem('user_mobileno'),
                                              //   'shop_id': item
                                              // };
                                              // await getcustomerlist(data);
                                              // setState(() {
                                              //   // customerdropdown='';
                                              // });
                                            },
                                            items: demo
                                                .map<DropdownMenuItem<String>>(
                                                    (item) {
                                              return DropdownMenuItem(
                                                child: Text(
                                                  item['name'].toString(),
                                                ),
                                                value:
                                                    item['value'].toString() +
                                                        '&*' +
                                                        item['name'].toString(),
                                              );
                                            }).toList(),
                                          ),
                                          // child: DropdownButtonFormField(
                                          //   // value: patternDropdownvalue,
                                          //   // autovalidateMode: AutovalidateMode.always,
                                          //   // validator: (value) {
                                          //   //   if (value == null ||
                                          //   //       value.isEmpty ||
                                          //   //       value == "Title") {
                                          //   //     return 'please select Title';
                                          //   //   }
                                          //   //   return null;
                                          //   // },
                                          //   decoration: const InputDecoration(
                                          //     labelText: 'Prescription',
                                          //     border: OutlineInputBorder(),
                                          //     //icon: Icon(Icons.numbers),
                                          //   ),
                                          //   items: demo.map((String items) {
                                          //     return DropdownMenuItem(
                                          //       value: items['value'],
                                          //       child: Text(items['name']),
                                          //     );
                                          //   }).toList(),
                                          //   onChanged: (String? newValue) {
                                          //     setState(() {
                                          //       patternDropdownvalue = newValue!;
                                          //     });
                                          //   },
                                          // ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.455,
                                          child: DropdownButtonFormField(
                                            value: prescriptionDropdownvalue,
                                            autovalidateMode:
                                                AutovalidateMode.always,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  value == "Title") {
                                                return 'please select Title';
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              labelText: 'Prescription',
                                              border: OutlineInputBorder(),
                                              //icon: Icon(Icons.numbers),
                                            ),
                                            items: Prescription.map(
                                                (String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                prescriptionDropdownvalue =
                                                    newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 180,
                                          child: TextButton(
                                              onPressed: () async {
                                                // var data = {
                                                //   "treatment": titleDropdownvalue.toString(),
                                                //   "fees": fees.text.toString(),
                                                // };

                                                // print(data);

                                                // print(data);
                                                // print(treatmentList);
                                                // print(treatmentList.contains(data));
                                                // if (treatmentList.contains(data)) {
                                                //   treatmentList.remove(data);
                                                // } else {
                                                //   treatmentList.add(data);
                                                // }
                                                // print(treatmentList);
                                                // setState(() {
                                                //   fees.clear();
                                                //   titleDropdownvalue = 'Select Treatment';
                                                // });
                                              },
                                              child: Text(
                                                "Add Command",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color.fromARGB(
                                                              255, 10, 132, 87)),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(4.0),
                                                          side: BorderSide(color: Colors.blue))))),
                                        ),
                                        SizedBox(
                                          width: 180,
                                          child: TextButton(
                                              onPressed: () async {
                                                tableCalCulation();
                                                // total = 0.0;
                                                // var price = double.parse(
                                                //     priceController.text);
                                                // var day = double.parse(
                                                //     dayController.text);
                                                // var number =
                                                //     double.parse(count);
                                                // setState(() {
                                                //   total =
                                                //       (number * price) * day;
                                                //   // cal={
                                                //   //   "total":total.toString(),

                                                //   // };
                                                // });

                                                var data = {
                                                  "medicine": medicineController
                                                      .text
                                                      .toString(),
                                                  "price": priceController.text
                                                      .toString(),
                                                  "day": dayController.text
                                                      .toString(),
                                                  "pattern":
                                                      patternDropdownvalue
                                                          .toString(),
                                                  "total_qty": count.toString(),
                                                  "prescription":
                                                      prescriptionDropdownvalue
                                                          .toString(),
                                                  "total": total.toString(),
                                                  // "Test":testList,
                                                  // "Treatment":treatmentList,
                                                  // "List":Map.from(treatmentList as Map),
                                                };

                                                print(data);
                                                print(medicineList);
                                                print(medicineList
                                                    .contains(data));
                                                if (table_list.contains(data)) {
                                                  table_list.remove(data);
                                                } else {
                                                  table_list.add(data);
                                                  grand_total=0;

                                                
                                                  for (var value
                                                      in table_list) {
                                                    grand_total = grand_total +
                                                        double.parse(
                                                            value['total']);
                                                  }
                                                  // return grand_total;
                                                  grandtotalController.text=grand_total.toString();

                                                  //  medicineList.addAll(cal);
                                                  // tableCalCulation();

                                                  //  medicineList.addAll(treatmentList);
                                                  // //  medicineList.asMap()
                                                }
                                                print(table_list);
                                                setState(() {
                                                  medicineController.clear();
                                                  priceController.clear();
                                                  dayController.clear();
                                                  patternDropdownvalue = 'null';
                                                  prescriptionDropdownvalue =
                                                      'Prescription';
                                                });
                                              },
                                              child: Text(
                                                "Add",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color.fromARGB(
                                                              255, 10, 132, 87)),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(4.0),
                                                          side: BorderSide(color: Colors.blue))))),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                )),
                              ),
                              Helper().isvalidElement(table_list) &&
                                      table_list.length > 0
                                  ? Container(
                                      padding: const EdgeInsets.all(5),
                                      // height: screenHeight * 0.6,
                                      width: screenWidth,
                                      child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: table_list.length,
                                          // itemCount: testList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final data = table_list[index];
                                            return Container(
                                              child: Card(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Medicine :',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${data['medicine'].toString()}",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Days : ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${data['day'].toString()}",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'BF/AF: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${data['prescription'].toString()}",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Mor:',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "00",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Noon: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "00 ",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Night: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "00 ",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Total Qty: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${data['total_qty'].toString()}",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Price: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${data['price'].toString()} ",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Total: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${data['total'].toString()} ",
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),

                                                    // Card(
                                                    //   child: ListTile(
                                                    //     title: Text(
                                                    //       'Lab Name: ${data['lab_name'].toString()}',
                                                    //     ),
                                                    //     subtitle: Text(
                                                    //         'Test Name: ${data['test_name'].toString()}'),
                                                    //     trailing: IconButton(
                                                    //       onPressed: () {
                                                    //         setState(() {
                                                    //           testList.remove(data);
                                                    //         });
                                                    //       },
                                                    //       icon: Icon(
                                                    //         Icons.close,
                                                    //         color: Colors.red,
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // ListTile(title: Text('Test name'),
                                                    // trailing: IconButton(onPressed: (){} ,icon: Icon(Icons.add)),),
                                                  ],
                                                ),
                                              )),
                                            );
                                          }),
                                    )
                                  : Container(),
                              //  Container(height: screenHeight*0.5,),

                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.455,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: 'Discount',
                                          border: OutlineInputBorder(),
                                          // icon: Icon(Icons.numbers),
                                        ),
                                        controller:discountController,
                                         onChanged: (text) {
                                           double finaldiscountvalue = discountController.text.isNotEmpty
        ? double.parse(discountController.text)
        : 0.0;
                                          // var finaldiscountvalue = double.parse(
                                              // discountController.text);
                                          // balanceController.text=grand_total.toString();
                                          balance=grand_total-finaldiscountvalue;
                                           balanceController.text=balance.toString();
                                         

                                        },
                                        // autofocus: true,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.455,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: 'Grant Total',
                                          border: OutlineInputBorder(),
                                          // icon: Icon(Icons.numbers),
                                        ),
                                        controller: grandtotalController,
                                        // grandtotalController=
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      //   ],),
                                      // )
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.455,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: 'Recieved',
                                                border: OutlineInputBorder(),
                                                // icon: Icon(Icons.numbers),
                                              ),
                                              controller: receivedController,
                                              // autofocus: true,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.455,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: 'Balance',
                                                border: OutlineInputBorder(),
                                                // icon: Icon(Icons.numbers),
                                              ),
                                              controller: balanceController,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.455,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: 'Change',
                                                border: OutlineInputBorder(),
                                                // icon: Icon(Icons.numbers),
                                              ),
                                              controller: changeController,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                            ),
                                          ),
                                          //   SizedBox(
                                          //   width:  screenWidth*0.455,
                                          //   child: TextFormField(
                                          //     decoration: const InputDecoration(

                                          //       labelText: 'Day',
                                          //       border: OutlineInputBorder(),
                                          //       // icon: Icon(Icons.numbers),
                                          //     ),
                                          //     controller: dayController,
                                          //     keyboardType: TextInputType.numberWithOptions(decimal: true),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        width: screenWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextButton(
                                              onPressed: () async {
                                                // var data = {
                                                //   "treatment": titleDropdownvalue.toString(),
                                                //   "fees": fees.text.toString(),
                                                // };

                                                // print(data);

                                                // print(data);
                                                // print(treatmentList);
                                                // print(treatmentList.contains(data));
                                                // if (treatmentList.contains(data)) {
                                                //   treatmentList.remove(data);
                                                // } else {
                                                //   treatmentList.add(data);
                                                // }
                                                // print(treatmentList);
                                                // setState(() {
                                                //   fees.clear();
                                                //   titleDropdownvalue = 'Select Treatment';
                                                // });
                                              },
                                              child: Text(
                                                "Prescription",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color.fromARGB(
                                                              255, 10, 132, 87)),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(4.0),
                                                          side: BorderSide(color: Colors.blue))))),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  tableCalCulation() {
    total = 0.0;
    var price = double.parse(priceController.text);
    var day = double.parse(dayController.text);
    var number = double.parse(count);
    setState(() {
      total = (number * price) * day;
      // cal={
      //   "total":total.toString(),

      // };
    });
  }
}
