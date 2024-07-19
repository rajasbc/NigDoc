// import 'package:flutter/material.dart';
// import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
// // import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Dashboardpage.dart';
// import 'package:nigdoc/AppWidget/common/utils.dart';

// class AddPrescription extends StatefulWidget {
//   const AddPrescription({super.key});

//   @override
//   State<AddPrescription> createState() => _AddPrescriptionState();
// }

// class _AddPrescriptionState extends State<AddPrescription> {
//   TextEditingController searchText = TextEditingController();
//   TextEditingController fees = TextEditingController();
//   TextEditingController labnameController = TextEditingController();
//   TextEditingController testnameController = TextEditingController();
//   TextEditingController medicineController = TextEditingController();
//   TextEditingController priceController = TextEditingController();
//   TextEditingController dayController = TextEditingController();
//   TextEditingController grandtotalController = TextEditingController();
//   TextEditingController discountController = TextEditingController();
//   TextEditingController receivedController = TextEditingController();
//   TextEditingController balanceController = TextEditingController();
//   TextEditingController changeController = TextEditingController();
//   var searchList;
//   String titleDropdownvalue = 'Select Treatment';
//   String patternDropdownvalue = 'pattern';
//   String prescriptionDropdownvalue = 'Prescription';
//   var select_button = 'treatment';

//   var title = ['Select Treatment', 'Ferver', 'Head Ache'];
//   var pattern = ['pattern', '0-0-0', '1-1-1', '1-0-1'];
//   // List pattern = [
//   //   {"name": "pattern", "value": "0"},
//   //  {"name": "0-0-1", "value": "1"},
//   //   {"name": "0-1-0", "value": "2"},
//   //  {"name": "0-1-1", "value": "3"},
//   //  {"name": "1-0-0", "value": "4"},
//   //  {"name": "1-0-1", "value": "5"},
//   //  {"name": "1-1-0", "value": "2"},
//   //  {"name": "1-1-1", "value": "3"},
//   //  {"name": "0-0-2", "value": "2"},
//   //  {"name": "0-2-0", "value": "2"},
//   //  {"name": "2-0-0", "value": "2"},
//   //  {"name": "2-2-0", "value": "4"},
//   //  {"name": "0-2-2", "value": "4"},
//   //  {"name": "2-0-2", "value": "4"},
//   //  {"name": "2-2-2", "value": "6"},
//   // ];
//   var Prescription = ['Prescription', 'BF', 'AF'];
//   List treatmentList = [];
//   List testList = [];
//   List medicineList = [];
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height - 50;
//     double screenWidth = MediaQuery.of(context).size.width;
//     return new WillPopScope(
//         onWillPop: () async {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => Dash()),
//           );
//           // if (Platform.isAndroid) {
//           //   exit(0);
//           // } else if (Platform.isIOS) {
//           //   exit(0);
//           // }
//           // exit(0);
//           return true;
//         },
//         child: Scaffold(
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(50),
//             child: AppBar(
//               title: const Text('Add Prescription'),
//               backgroundColor: Color.fromARGB(255, 8, 122, 135),
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Dash()),
//                   );
//                 },
//                 icon: Icon(Icons.arrow_back),
//               ),
//             ),
//           ),
//           body: Container(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Column(children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: screenHeight * 0.08,
//                       width: screenWidth,
//                       // color:Colors.amber,
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             top: 5, bottom: 5, left: 5, right: 5),
//                         child: Container(
//                           // height: screenHeight * 0.06,
//                           width: screenWidth,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(
//                                   color: Color.fromARGB(255, 8, 122, 135)),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20))),
//                           child: Row(
//                             children: [
//                               Container(
//                                   width: screenWidth * 0.1,
//                                   height: screenHeight,
//                                   child: Icon(Icons.search,
//                                       color: Color.fromARGB(255, 8, 122, 135))),
//                               Container(
//                                 width: screenWidth * 0.65,
//                                 child: TextField(
//                                   controller: searchText,
//                                   onChanged: (text) {
//                                     print(text);

//                                     this.setState(() {});

//                                     // searchList = StaffList.where((element) {
//                                     //   var List =
//                                     //       element['name'].toString().toLowerCase();
//                                     //   return List.contains(text.toLowerCase());
//                                     //   // return true;
//                                     // }).toList();
//                                     // this.setState(() {});
//                                   },
//                                   decoration: new InputDecoration(
//                                     filled: true,
//                                     border: InputBorder.none,
//                                     fillColor: Colors.white,
//                                     hintText: 'Search Patient list...',
//                                   ),
//                                 ),
//                               ),
//                               searchText.text.isNotEmpty
//                                   ? Container(
//                                       width: screenWidth * 0.1,
//                                       height: screenHeight,
//                                       child: IconButton(
//                                         icon: Icon(
//                                           Icons.close,
//                                           color: Colors.red,
//                                         ),
//                                         onPressed: () {
//                                           setState(() {
//                                             searchText.text = '';
//                                             searchList = '';
//                                           });
//                                         },
//                                       ))
//                                   : Container(),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 2,
//                   ),
//                   SizedBox(
//                     width: screenWidth * 0.95,
//                     // height:screenHeight * 0.15,
//                     child: Padding(
//                       padding: const EdgeInsets.all(3.0),
//                       child: InkWell(
//                         splashColor: Colors.white,
//                         child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(5),
//                                   topRight: Radius.circular(5),
//                                   bottomLeft: Radius.circular(5),
//                                   bottomRight: Radius.circular(5)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: 3,
//                                   blurRadius: 4,
//                                   offset: Offset(
//                                       0, 3), // changes position of shadow
//                                 ),
//                               ],
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'PRABU',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 18),
//                                       ),
//                                       SizedBox(
//                                         height: 20,
//                                         child: TextButton(
//                                           onPressed: () {
//                                             // Navigator.push(
//                                             //   context,
//                                             //   MaterialPageRoute(
//                                             //       builder:
//                                             //           (context) =>
//                                             //               BillingPay()),
//                                             // );
//                                           },
//                                           style: TextButton.styleFrom(
//                                             minimumSize: Size.zero, // Set this
//                                             padding:
//                                                 EdgeInsets.zero, // and this
//                                           ),
//                                           child: Text(
//                                             'Add Patient   ',
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.red,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Gender :',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13),
//                                           ),
//                                           Text(
//                                             "male",
//                                             style: TextStyle(fontSize: 15),
//                                           )
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Mob : ',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13),
//                                           ),
//                                           Text(
//                                             "9876543210",
//                                             style: TextStyle(fontSize: 15),
//                                           )
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Age : ',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13),
//                                           ),
//                                           Text(
//                                             "25 ",
//                                             style: TextStyle(fontSize: 15),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Blood Grp: ',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13),
//                                           ),
//                                           Text(
//                                             " B +ve",
//                                             style: TextStyle(fontSize: 15),
//                                           )
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Height: ',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13),
//                                           ),
//                                           Text(
//                                             "000",
//                                             style: TextStyle(fontSize: 15),
//                                           )
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Weight: ',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13),
//                                           ),
//                                           Text(
//                                             "000",
//                                             style: TextStyle(fontSize: 15),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Bp: ',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13),
//                                           ),
//                                           Text(
//                                             " B +ve",
//                                             style: TextStyle(fontSize: 15),
//                                           )
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Sugar: ',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13),
//                                           ),
//                                           Text(
//                                             "000",
//                                             style: TextStyle(fontSize: 15),
//                                           )
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Temp: ',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13),
//                                           ),
//                                           Text(
//                                             "000",
//                                             style: TextStyle(fontSize: 15),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Pulse: ',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13),
//                                           ),
//                                           Text(
//                                             " B +ve",
//                                             style: TextStyle(fontSize: 15),
//                                           )
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'SpO2: ',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13),
//                                           ),
//                                           Text(
//                                             "000",
//                                             style: TextStyle(fontSize: 15),
//                                           )
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Vaccination: ',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13),
//                                           ),
//                                           Text(
//                                             "000",
//                                             style: TextStyle(fontSize: 15),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'vaccination info: ',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13),
//                                           ),
//                                           Text(
//                                             "erty",
//                                             style: TextStyle(fontSize: 15),
//                                           )
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Reason: ',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 13),
//                                           ),
//                                           Text(
//                                             "erty",
//                                             style: TextStyle(fontSize: 15),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             )),
//                         onTap: () {},
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Padding(
//                     padding: const EdgeInsets.all(3.0),
//                     child: Container(
//                       height: screenHeight * 0.08,
//                       width: screenWidth,
//                       // color:Colors.amber,
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             top: 5, bottom: 5, left: 0, right: 0),
//                         child: Container(
//                           // height: screenHeight * 0.06,
//                           width: screenWidth,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               // border: Border.all(
//                               //     color: Color.fromARGB(255, 12, 12, 12)),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(4))),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               // Container(
//                               //     width: screenWidth * 0.1,
//                               //     height: screenHeight,
//                               //     child: Icon(Icons.search,
//                               //         color: Color.fromARGB(255, 8, 122, 135))),
//                               Container(
//                                 width: screenWidth * 0.8,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(0.0),
//                                   child: DropdownButtonFormField(
//                                     value: titleDropdownvalue,
//                                     autovalidateMode: AutovalidateMode.always,
//                                     validator: (value) {
//                                       if (value == null ||
//                                           value.isEmpty ||
//                                           value == "Title") {
//                                         return 'please select Title';
//                                       }
//                                       return null;
//                                     },
//                                     decoration: const InputDecoration(
//                                       labelText: 'Treatment',
//                                       border: OutlineInputBorder(),
//                                       //icon: Icon(Icons.numbers),
//                                     ),
//                                     items: title.map((String items) {
//                                       return DropdownMenuItem(
//                                         value: items,
//                                         child: Text(items),
//                                       );
//                                     }).toList(),
//                                     onChanged: (String? newValue) {
//                                       setState(() {
//                                         titleDropdownvalue = newValue!;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                   width: screenWidth * 0.1,
//                                   height: screenHeight,
//                                   color: Colors.grey,
//                                   child: IconButton(
//                                     icon: Icon(
//                                       Icons.add,
//                                       color: Colors.black,
//                                     ),
//                                     onPressed: () {
//                                       // setState(() {
//                                       //   searchText.text = '';
//                                       //   searchList = '';
//                                       // });

//                                       // child:
//                                       // showModalBottomSheet(
//                                       //     context: context,
//                                       //     isScrollControlled: true,
//                                       //     shape: const RoundedRectangleBorder(
//                                       //       borderRadius: BorderRadius.only(
//                                       //         topRight: Radius.circular(25.0),
//                                       //         topLeft: Radius.circular(25.0),
//                                       //       ),
//                                       //     ),
//                                       //     builder: (context) {
//                                       //       return SizedBox(
//                                       //         height: 300,
//                                       //         width: MediaQuery.of(context)
//                                       //             .size
//                                       //             .width,
//                                       //         child: const Center(
//                                       //           child: Text(
//                                       //             "Flutter Frontend",
//                                       //             style: TextStyle(
//                                       //               color: Colors.black,
//                                       //               fontSize: 25,
//                                       //               fontWeight: FontWeight.bold,
//                                       //             ),
//                                       //           ),
//                                       //         ),
//                                       //       );
//                                       //     });
//                                     },
//                                   )),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 2,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Container(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(
//                             width: 180,
//                             child: TextFormField(
//                               decoration: const InputDecoration(
//                                 labelText: 'Fees',
//                                 border: OutlineInputBorder(),
//                                 // icon: Icon(Icons.numbers),
//                               ),
//                               controller: fees,
//                               keyboardType: TextInputType.numberWithOptions(
//                                   decimal: true),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 4,
//                           ),
//                           InkWell(
//                             child: Container(
//                               width: screenWidth * 0.20,
//                               height: screenHeight * 0.05,
//                               decoration: BoxDecoration(
//                                 border:
//                                     Border.all(width: 2, color: Colors.white),
//                                 color: select_button == "treatment"
//                                     ? Colors.blue
//                                     : Colors.white,
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),
//                                     topRight: Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10)),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.3),
//                                     spreadRadius: 3,
//                                     blurRadius: 3,
//                                     offset: Offset(
//                                         0, 1), // changes position of shadow
//                                   ),
//                                 ],
//                               ),
//                               child: Center(
//                                   child: Text(
//                                 "Treatment",
//                                 style: TextStyle(
//                                     color: select_button == "treatment"
//                                         ? Colors.white
//                                         : Colors.blue,
//                                     fontWeight: FontWeight.bold),
//                               )),
//                             ),
//                             onTap: () {
//                               this.setState(() {
//                                 select_button = "treatment";
//                                 // billList();
//                               });
//                             },
//                           ),
//                           InkWell(
//                             child: Container(
//                               width: screenWidth * 0.20,
//                               height: screenHeight * 0.05,
//                               decoration: BoxDecoration(
//                                 border:
//                                     Border.all(width: 2, color: Colors.white),
//                                 color: select_button == "test"
//                                     ? Colors.blue
//                                     : Colors.white,
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),
//                                     topRight: Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10)),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.3),
//                                     spreadRadius: 3,
//                                     blurRadius: 3,
//                                     offset: Offset(
//                                         0, 1), // changes position of shadow
//                                   ),
//                                 ],
//                               ),
//                               child: Center(
//                                   child: Text(
//                                 "TEST",
//                                 style: TextStyle(
//                                     color: select_button == "test"
//                                         ? Colors.white
//                                         : Colors.blue,
//                                     fontWeight: FontWeight.bold),
//                               )),
//                             ),
//                             onTap: () {
//                               this.setState(() {
//                                 select_button = "test";
//                                 // billList();
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   SizedBox(
//                     // width: 100,
//                     child: TextButton(
//                         onPressed: () async {
//                           var data = {
//                             "treatment": titleDropdownvalue.toString(),
//                             "fees": fees.text.toString(),
//                           };

//                           print(data);

//                           print(data);
//                           print(treatmentList);
//                           print(treatmentList.contains(data));
//                           if (treatmentList.contains(data)) {
//                             treatmentList.remove(data);
//                           } else {
//                             treatmentList.add(data);
//                           }
//                           print(treatmentList);
//                           setState(() {
//                             fees.clear();
//                             titleDropdownvalue = 'Select Treatment';
//                           });
//                         },
//                         child: Text(
//                           "ADD TREATMENT",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         style: ButtonStyle(
//                             backgroundColor: WidgetStateProperty.all<Color>(
//                                 Color.fromARGB(255, 10, 132, 87)),
//                             shape: WidgetStateProperty.all<
//                                     RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(4.0),
//                                     side: BorderSide(color: Colors.blue))))),

//                     // TextFormField(
//                     //   decoration: const InputDecoration(
//                     //     labelText: 'Clinic Notes',
//                     //     border: OutlineInputBorder(),
//                     //     //icon: Icon(Icons.numbers),
//                     //   ),

//                     //   // controller: addressController,

//                     // ),
//                   ),
//                   Helper().isvalidElement(treatmentList) &&
//                           treatmentList.length > 0
//                       ? Container(
//                           width: screenWidth,
//                           child: Text(
//                             '  Treatment List :',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 18),
//                           ),
//                         )
//                       : Container(),
//                   Container(
//                       padding: const EdgeInsets.all(5),
//                       // height: screenHeight * 0.6,
//                       width: screenWidth,
//                       child: Helper().isvalidElement(treatmentList)
//                           ? ListView.builder(
//                               physics: NeverScrollableScrollPhysics(),
//                               shrinkWrap: true,
//                               itemCount: treatmentList.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 final data = treatmentList[index];
//                                 return Container(
//                                     child: Column(
//                                   children: [
//                                     Card(
//                                       child: ListTile(
//                                         title: Text(
//                                           '${data['treatment'].toString()}',
//                                         ),
//                                         subtitle: Text(
//                                             '${"₹ " + data['fees'].toString()}'),
//                                         trailing: IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               treatmentList.remove(data);
//                                             });
//                                           },
//                                           icon: Icon(
//                                             Icons.close,
//                                             color: Colors.red,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     // ListTile(title: Text('Test name'),
//                                     // trailing: IconButton(onPressed: (){} ,icon: Icon(Icons.add)),),
//                                     Divider(
//                                       height: 0.1,
//                                     )
//                                   ],
//                                 ));
//                               })
//                           : Container()),
//                   select_button == 'test'
//                       ? Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Container(
//                             width: screenWidth,
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                   // width: 180,
//                                   child: TextFormField(
//                                     decoration: const InputDecoration(
//                                       labelText: 'Lab Name',
//                                       border: OutlineInputBorder(),
//                                       // icon: Icon(Icons.numbers),
//                                     ),
//                                     controller: labnameController,
//                                     // keyboardType: TextInputType.numberWithOptions(decimal: true),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 SizedBox(
//                                   // width: 180,
//                                   child: TextFormField(
//                                     decoration: const InputDecoration(
//                                       labelText: 'Test Name',
//                                       border: OutlineInputBorder(),
//                                       // icon: Icon(Icons.numbers),
//                                     ),
//                                     controller: testnameController,
//                                     // keyboardType: TextInputType.numberWithOptions(decimal: true),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 4,
//                                 ),
//                                 SizedBox(
//                                   width: 100,
//                                   child: TextButton(
//                                       onPressed: () async {
//                                         var test = {
//                                           "lab_name":
//                                               labnameController.text.toString(),
//                                           "test_name": testnameController.text
//                                               .toString(),
//                                         };

//                                         print(test);

//                                         print(test);
//                                         print(testList);
//                                         print(testList.contains(test));
//                                         if (testList.contains(test)) {
//                                           testList.remove(test);
//                                         } else {
//                                           testList.add(test);
//                                         }
//                                         print(testList);
//                                         setState(() {
//                                           labnameController.clear();
//                                           testnameController.clear();
//                                         });
//                                       },
//                                       child: Text(
//                                         "ADD TEST",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       style: ButtonStyle(
//                                           backgroundColor:
//                                               WidgetStateProperty.all<Color>(
//                                                   Color.fromARGB(
//                                                       255, 10, 132, 87)),
//                                           shape: WidgetStateProperty.all<
//                                                   RoundedRectangleBorder>(
//                                               RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           4.0),
//                                                   side: BorderSide(color: Colors.blue))))),

//                                   // TextFormField(
//                                   //   decoration: const InputDecoration(
//                                   //     labelText: 'Clinic Notes',
//                                   //     border: OutlineInputBorder(),
//                                   //     //icon: Icon(Icons.numbers),
//                                   //   ),

//                                   //   // controller: addressController,

//                                   // ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       : Container(),
//                   Helper().isvalidElement(testList) && testList.length > 0
//                       ? Container(
//                           width: screenWidth,
//                           child: Text(
//                             '  Test List :',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 18),
//                           ),
//                         )
//                       : Container(),
//                   Container(
//                       padding: const EdgeInsets.all(5),
//                       // height: screenHeight * 0.6,
//                       width: screenWidth,
//                       child: Helper().isvalidElement(testList)
//                           ? ListView.builder(
//                               physics: NeverScrollableScrollPhysics(),
//                               shrinkWrap: true,
//                               itemCount: testList.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 final data = testList[index];
//                                 return Container(
//                                     child: Column(
//                                   children: [
//                                     Card(
//                                       child: ListTile(
//                                         title: Text(
//                                           'Lab Name: ${data['lab_name'].toString()}',
//                                         ),
//                                         subtitle: Text(
//                                             'Test Name: ${data['test_name'].toString()}'),
//                                         trailing: IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               testList.remove(data);
//                                             });
//                                           },
//                                           icon: Icon(
//                                             Icons.close,
//                                             color: Colors.red,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     // ListTile(title: Text('Test name'),
//                                     // trailing: IconButton(onPressed: (){} ,icon: Icon(Icons.add)),),
//                                     Divider(
//                                       height: 0.1,
//                                     )
//                                   ],
//                                 ));
//                               })
//                           : Container()),
//                   Container(
//                       child: Column(
//                     children: [
//                       SizedBox(
//                         width: screenWidth,
//                         child: TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Medicine Name',
//                             border: OutlineInputBorder(),
//                             // icon: Icon(Icons.numbers),
//                           ),
//                           controller: medicineController,
//                           // keyboardType: TextInputType.numberWithOptions(decimal: true),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(
//                             width: screenWidth * 0.455,
//                             child: TextFormField(
//                               decoration: const InputDecoration(
//                                 labelText: 'Price',
//                                 border: OutlineInputBorder(),
//                                 // icon: Icon(Icons.numbers),
//                               ),
//                               controller: priceController,
//                               keyboardType: TextInputType.numberWithOptions(
//                                   decimal: true),
//                             ),
//                           ),
//                           SizedBox(
//                             width: screenWidth * 0.455,
//                             child: TextFormField(
//                               decoration: const InputDecoration(
//                                 labelText: 'Day',
//                                 border: OutlineInputBorder(),
//                                 // icon: Icon(Icons.numbers),
//                               ),
//                               controller: dayController,
//                               keyboardType: TextInputType.numberWithOptions(
//                                   decimal: true),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(
//                             width: screenWidth * 0.455,
//                             child: DropdownButtonFormField(
//                               value: patternDropdownvalue,
//                               autovalidateMode: AutovalidateMode.always,
//                               validator: (value) {
//                                 if (value == null ||
//                                     value.isEmpty ||
//                                     value == "Title") {
//                                   return 'please select Title';
//                                 }
//                                 return null;
//                               },
//                               decoration: const InputDecoration(
//                                 labelText: 'Prescription',
//                                 border: OutlineInputBorder(),
//                                 //icon: Icon(Icons.numbers),
//                               ),
//                               items: pattern.map((String items) {
//                                 return DropdownMenuItem(
//                                   value: items,
//                                   child: Text(items),
//                                 );
//                               }).toList(),
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   patternDropdownvalue = newValue!;
//                                 });
//                               },
//                             ),
//                           ),
//                           SizedBox(
//                             width: screenWidth * 0.455,
//                             child: DropdownButtonFormField(
//                               value: prescriptionDropdownvalue,
//                               autovalidateMode: AutovalidateMode.always,
//                               validator: (value) {
//                                 if (value == null ||
//                                     value.isEmpty ||
//                                     value == "Title") {
//                                   return 'please select Title';
//                                 }
//                                 return null;
//                               },
//                               decoration: const InputDecoration(
//                                 labelText: 'Prescription',
//                                 border: OutlineInputBorder(),
//                                 //icon: Icon(Icons.numbers),
//                               ),
//                               items: Prescription.map((String items) {
//                                 return DropdownMenuItem(
//                                   value: items,
//                                   child: Text(items),
//                                 );
//                               }).toList(),
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   prescriptionDropdownvalue = newValue!;
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(
//                             width: 180,
//                             child: TextButton(
//                                 onPressed: () async {
//                                   // var data = {
//                                   //   "treatment": titleDropdownvalue.toString(),
//                                   //   "fees": fees.text.toString(),
//                                   // };

//                                   // print(data);

//                                   // print(data);
//                                   // print(treatmentList);
//                                   // print(treatmentList.contains(data));
//                                   // if (treatmentList.contains(data)) {
//                                   //   treatmentList.remove(data);
//                                   // } else {
//                                   //   treatmentList.add(data);
//                                   // }
//                                   // print(treatmentList);
//                                   // setState(() {
//                                   //   fees.clear();
//                                   //   titleDropdownvalue = 'Select Treatment';
//                                   // });
//                                 },
//                                 child: Text(
//                                   "Add Command",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 style: ButtonStyle(
//                                     backgroundColor:
//                                         WidgetStateProperty.all<Color>(
//                                             Color.fromARGB(255, 10, 132, 87)),
//                                     shape: WidgetStateProperty.all<
//                                             RoundedRectangleBorder>(
//                                         RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(4.0),
//                                             side: BorderSide(
//                                                 color: Colors.blue))))),
//                           ),
//                           SizedBox(
//                             width: 180,
//                             child: TextButton(
//                                 onPressed: () async {
//                                   var data = {
//                                     "medicine":
//                                         medicineController.text.toString(),
//                                     "price": priceController.text.toString(),
//                                     "day": dayController.text.toString(),
//                                     "pattern": patternDropdownvalue.toString(),
//                                     "prescription":
//                                         prescriptionDropdownvalue.toString(),
//                                     // "Test":testList,
//                                     // "Treatment":treatmentList,
//                                     // "List":Map.from(treatmentList as Map),
//                                   };

//                                   print(data);
//                                   print(medicineList);
//                                   print(medicineList.contains(data));
//                                   if (medicineList.contains(data)) {
//                                     medicineList.remove(data);
//                                   } else {
//                                     medicineList.add(data);

//                                     //  medicineList.addAll(treatmentList);
//                                     // //  medicineList.asMap()
//                                   }
//                                   print(medicineList);
//                                   setState(() {
//                                     medicineController.clear();
//                                     priceController.clear();
//                                     dayController.clear();
//                                     // patternDropdownvalue = '0-0-0';
//                                     prescriptionDropdownvalue = 'Prescription';
//                                   });
//                                 },
//                                 child: Text(
//                                   "Add",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 style: ButtonStyle(
//                                     backgroundColor:
//                                         WidgetStateProperty.all<Color>(
//                                             Color.fromARGB(255, 10, 132, 87)),
//                                     shape: WidgetStateProperty.all<
//                                             RoundedRectangleBorder>(
//                                         RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(4.0),
//                                             side: BorderSide(
//                                                 color: Colors.blue))))),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                     ],
//                   )),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: DataTable(
//                           headingRowColor: MaterialStateColor.resolveWith(
//                               (states) => Colors.grey),
//                           border:
//                               TableBorder.all(color: Colors.black, width: 1.5),
//                           // Datatable widget that have the property columns and rows.
//                           columns: [
//                             // Set the name of the column
//                             DataColumn(
//                                 label: Text(
//                               'Medicine',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             )),
//                             DataColumn(
//                               label: Text(
//                                 'Days',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             DataColumn(
//                               label: Text(
//                                 'Mor/noon/eve/ngt',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             DataColumn(
//                               label: Text(
//                                 'BF/AF',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             DataColumn(
//                               label: Text(
//                                 'Dose',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),

//                             DataColumn(
//                               label: Text(
//                                 'total qty',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             DataColumn(
//                               label: Text(
//                                 'price',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             DataColumn(
//                               label: Text(
//                                 'Amount',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             DataColumn(
//                               label: Text(
//                                 'Action',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],

//                           rows: List.generate(medicineList.length, (index) {
//                             // Post post = medicineList.getPostByIndex(index);
//                             var data = medicineList[index];
//                             return DataRow(
//                               cells: <DataCell>[
//                                 DataCell(
//                                   Text('${data['medicine']}'),
//                                 ),
//                                 DataCell(
//                                   Text('${data['day']}'),
//                                 ),
//                                 DataCell(
//                                   Text('${data['pattern']}'),
//                                 ),
//                                 DataCell(
//                                   Text('${data['prescription']}'),
//                                 ),
//                                 DataCell(
//                                   Text('${data['prescription']}'),
//                                 ),
//                                 DataCell(
//                                   Text('${data['medicine']}'),
//                                 ),
//                                 DataCell(
//                                   Text('${data['price']}'),
//                                 ),
//                                 DataCell(
//                                   Text('${data['medicine']}'),
//                                 ),
//                                 DataCell(
//                                   IconButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         medicineList.remove(data);
//                                       });
//                                     },
//                                     icon: Icon(
//                                       Icons.delete,
//                                       color: Colors.red,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           }),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50,
//                   ),
//                   SizedBox(height: 5),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: screenWidth * 0.455,
//                         child: TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Grand Total',
//                             border: OutlineInputBorder(),
//                             // icon: Icon(Icons.numbers),
//                           ),
//                           controller: grandtotalController,
//                           keyboardType:
//                               TextInputType.numberWithOptions(decimal: true),
//                         ),
//                       ),
//                       SizedBox(
//                         width: screenWidth * 0.455,
//                         child: TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Discount',
//                             border: OutlineInputBorder(),
//                             // icon: Icon(Icons.numbers),
//                           ),
//                           controller: discountController,
//                           keyboardType:
//                               TextInputType.numberWithOptions(decimal: true),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 5),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: screenWidth * 0.455,
//                         child: TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Recieved',
//                             border: OutlineInputBorder(),
//                             // icon: Icon(Icons.numbers),
//                           ),
//                           controller: receivedController,
//                           keyboardType:
//                               TextInputType.numberWithOptions(decimal: true),
//                         ),
//                       ),
//                       SizedBox(
//                         width: screenWidth * 0.455,
//                         child: TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Balance',
//                             border: OutlineInputBorder(),
//                             // icon: Icon(Icons.numbers),
//                           ),
//                           controller: balanceController,
//                           keyboardType:
//                               TextInputType.numberWithOptions(decimal: true),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   SizedBox(height: 5),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: screenWidth * 0.455,
//                         child: TextFormField(
//                           decoration: const InputDecoration(
//                             labelText: 'Change',
//                             border: OutlineInputBorder(),
//                             // icon: Icon(Icons.numbers),
//                           ),
//                           controller: changeController,
//                           keyboardType:
//                               TextInputType.numberWithOptions(decimal: true),
//                         ),
//                       ),
//                       //   SizedBox(
//                       //   width:  screenWidth*0.455,
//                       //   child: TextFormField(
//                       //     decoration: const InputDecoration(

//                       //       labelText: 'Day',
//                       //       border: OutlineInputBorder(),
//                       //       // icon: Icon(Icons.numbers),
//                       //     ),
//                       //     controller: dayController,
//                       //     keyboardType: TextInputType.numberWithOptions(decimal: true),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 7,
//                   ),
//                   Container(
//                     width: screenWidth,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextButton(
//                           onPressed: () async {
//                             // var data = {
//                             //   "treatment": titleDropdownvalue.toString(),
//                             //   "fees": fees.text.toString(),
//                             // };

//                             // print(data);

//                             // print(data);
//                             // print(treatmentList);
//                             // print(treatmentList.contains(data));
//                             // if (treatmentList.contains(data)) {
//                             //   treatmentList.remove(data);
//                             // } else {
//                             //   treatmentList.add(data);
//                             // }
//                             // print(treatmentList);
//                             // setState(() {
//                             //   fees.clear();
//                             //   titleDropdownvalue = 'Select Treatment';
//                             // });
//                           },
//                           child: Text(
//                             "Prescription",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           style: ButtonStyle(
//                               backgroundColor: WidgetStateProperty.all<Color>(
//                                   Color.fromARGB(255, 10, 132, 87)),
//                               shape: WidgetStateProperty.all<
//                                       RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(4.0),
//                                       side: BorderSide(color: Colors.blue))))),
//                     ),
//                   )
//                 ]),
//               ),
//             ),
//           ),
//         ));
//   }
// }
