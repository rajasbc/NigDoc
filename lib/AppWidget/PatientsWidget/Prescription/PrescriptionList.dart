import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/Api.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Prescription/PrescriptionDetails.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Prescription/Print.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class Prescription_List extends StatefulWidget {
  const Prescription_List({super.key});

  @override
  State<Prescription_List> createState() => _Prescription_ListState();
}

class _Prescription_ListState extends State<Prescription_List> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  TextEditingController Predetailscontoller = TextEditingController();
  TextEditingController todateInputController = TextEditingController();
  TextEditingController fromdateInputController = TextEditingController();

  //  int? _PrintSelected;
  // String _print = "";
  int? _printSelected;
  String _printVal = "";

  String _headerSelected = "";
  String _headerval = "";
  var userResponse;
  var accesstoken;
  var prescription;
  bool isLoading = false;
  String DoctorDropdownvalue = 'All';
  var DoctorList;
  List prescriptionList = [];
  List presc_list = [];
  var reoportbillid;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  final DateFormate = "yyyy-MM-dd";
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
        firstDate: DateTime(
            DateTime.now().year - 3, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day));

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    if (checkfield == "from") {
      // var formatter = new DateFormat('dd-MM-yyyy');
      fromdateInputController.text =
          DateFormat(DateFormate).format(pickedDate!);

      // fromdateInputController.text = pickedDate.toString().split(' ')[0];
      getprescriptionist();
      get();
      // getdoctorlist();
    } else {
      todateInputController.text = DateFormat(DateFormate).format(pickedDate!);

      getprescriptionist();
      get();
      // getdoctorlist();
    }
  }

  @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken = userResponse['access_token'];
    fromdateInputController.text = Helper().getCurrentDate();
    todateInputController.text = Helper().getCurrentDate();
    getdoctorlist();
    getprescriptionist();
    // getMediAndLabNameList();
    // getPrescriptionList();

    // gettreatmentlist();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> data = {'customer_name': ''};
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Setting()));
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Prescription List',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Setting()));
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            backgroundColor: custom_color.appcolor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Container(
                    // height: screenHeight * 0.60,
                    child: Column(
                      children: [
                        // Container(
                        //   child: Text('data'),

                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: screenWidth,
                            height: screenHeight * 0.06,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: screenWidth * 0.45,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'From',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
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
                                  width: screenWidth * 0.45,
                                  child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'To',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: screenHeight * 0.06,
                            width: screenWidth * 0.95,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))
                                // border: OutlineInputBorder()
                                ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Helper().isvalidElement(DoctorList) &&
                                      DoctorList.length > 0
                                  ? DropdownButtonFormField(
                                      menuMaxHeight: 300,
                                      // validator: (value) => validateDrops(value),
                                      // isExpanded: true,
                                      decoration: InputDecoration.collapsed(
                                          hintText: ''),
                                      isExpanded: true,
                                      hint: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0, left: 8, right: 8),
                                        child: Text(
                                          // 'Select Doctor * ',
                                          DoctorDropdownvalue,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 112, 107, 107)),
                                        ),
                                      ),
                                      // value:' _selectedState[i]',
                                      onChanged: (selecteddoctor) {
                                        setState(() {
                                          DoctorDropdownvalue =
                                              selecteddoctor.toString();

                                          get();
                                          // selectedDoctor = selectedDoctor;
                                          // print("Stae value");
                                          // print(newValue);
                                          // _selectedState[i]= newValue;
                                          // getMyDistricts(newValue, i);
                                        });
                                      },
                                      items: DoctorList.map<
                                          DropdownMenuItem<String>>((item) {
                                        return new DropdownMenuItem(
                                          child:
                                              new Text(item['name'].toString()),
                                          value: item['id'].toString(),
                                        );
                                      }).toList(),
                                    )
                                  : DropdownButtonFormField(
                                      // validator: (value) => validateDrops(value),
                                      // isExpanded: true,
                                      hint: Text('No Doctor List'),
                                      // value:' _selectedState[i]',
                                      onChanged: (Pharmacy) {
                                        setState(() {});
                                      },
                                      items: [].map<DropdownMenuItem<String>>(
                                          (item) {
                                        return new DropdownMenuItem(
                                          child: new Text(''),
                                          value: '',
                                        );
                                      }).toList(),
                                    ),
                            ),
                          ),
                        ),
                        Helper().isvalidElement(presc_list) &&
                                presc_list.length > 0
                            ? Container(
                                // color: Colors.amber,
                                height: screenHeight * 0.75,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: presc_list.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var data = presc_list[index];
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Container(
                                            color: index % 2 == 0
                                                ? custom_color.lightcolor
                                                : Colors.white,
                                            width: screenWidth,
                                            height: screenHeight * 0.09,
                                            // width: screenWidth * 0.90,
                                            // decoration:
                                            //     BoxDecoration(border: Border.all(color: Colors.grey)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: screenWidth * 0.75,
                                                    // color: Colors.red,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          child: Row(
                                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                // color: Colors.amber,
                                                                width:
                                                                    screenWidth *
                                                                        0.43,
                                                                height:
                                                                    screenWidth *
                                                                        0.07,
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      'Pre Id : ${data['presc_id']}',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                // color: Colors.purple,
                                                                //  width: screenWidth * 0.35,
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      'Date : ${data['setdate']}',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          child: Row(
                                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    screenWidth *
                                                                        0.43,
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      'Dr Name : ${data['doc_name'] == null ? data['username'] : data['doc_name']}',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                // color: Colors.red,
                                                                width:
                                                                    screenWidth *
                                                                        0.32,
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      'Name : ${data['customer_name']}',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        

                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          child: Row(
                                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    screenWidth *
                                                                        0.45,
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      'Mobile No : ${data['phone']}',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                  SizedBox(
                                                    width: screenWidth * 0.04,
                                                  ),
                                                  Column(
                                                    children: [
                                                      PopupMenuButton(
                                                          itemBuilder:
                                                              (context) => [
                                                                    PopupMenuItem(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.view_agenda,
                                                                            color:
                                                                                custom_color.appcolor,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 10),
                                                                            child:
                                                                                Text(
                                                                              'View Prescription',
                                                                              style: TextStyle(fontSize: 16),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => PrescriptionDetails(select_prescription: data)));
                                                                      },
                                                                      //                                 onTap: () {
                                                                      //                                 showDialog ( context: context,
                                                                      // builder: (_) => AlertDialog(
                                                                      //       backgroundColor: Colors.white,
                                                                      //       surfaceTintColor: Colors.white,
                                                                      //       insetPadding: EdgeInsets.all(5.0),
                                                                      //       // contentPadding: EdgeInsets.zero,
                                                                      //       clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                      //       shape: RoundedRectangleBorder(
                                                                      //           borderRadius:
                                                                      //               BorderRadius.all(Radius.circular(15.0))),
                                                                      //       content: Builder(
                                                                      //         builder: (context) {
                                                                      //           // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                                                      //           var height = MediaQuery.of(context).size.height;
                                                                      //           var width = MediaQuery.of(context).size.width;
                                                                      //           return Container(
                                                                      //             color: Colors.white,
                                                                      //             // height: height - 200,
                                                                      //             width: width,
                                                                      //             child: SingleChildScrollView(
                                                                      //               physics: const BouncingScrollPhysics(),
                                                                      //               child: Container(
                                                                      //                 child: Column(
                                                                      //                   children: [
                                                                      //                     // Text('Add New Customer'),
                                                                      //                      Text('Prescription Details ',
                                                                      //                                 style: TextStyle(
                                                                      //                                   fontSize: 20,
                                                                      //                                     fontWeight:
                                                                      //                                         FontWeight.bold)),

                                                                      //                     SizedBox(
                                                                      //                       height: 5,
                                                                      //                     ),
                                                                      //                      ListView.builder(
                                                                      //                                             shrinkWrap: true,
                                                                      //                                             physics: NeverScrollableScrollPhysics(),
                                                                      //                                             itemCount: 1,
                                                                      //                                             itemBuilder: (BuildContext context, int index){

                                                                      //                                               return Center(
                                                                      //                                                 child:Container(
                                                                      //                                                   height: 122,
                                                                      //                                                   width: 500,
                                                                      //                                                   color: index % 2 == 0
                                                                      //                                                   ? custom_color.lightcolor
                                                                      //                                                   : Colors.white,
                                                                      //                      child: Row(
                                                                      //                      children: [
                                                                      //                      Container(
                                                                      //                       width: screenWidth*0.75,
                                                                      //                       // color: Colors.red,
                                                                      //                       child: Column(
                                                                      //                         children: [
                                                                      //                           Padding(
                                                                      //                             padding: const EdgeInsets.all(0.0),
                                                                      //                             child: Row(
                                                                      //                               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      //                               children: [
                                                                      //                                 Container(
                                                                      //                                   // color: Colors.amber,
                                                                      //                                   width: screenWidth * 0.45,
                                                                      //                                   height: screenWidth*0.07,
                                                                      //                                   child: Row(
                                                                      //                                     children: [
                                                                      //                                       Text(
                                                                      //                                         'Pre Date :',
                                                                      //                                         style: TextStyle(
                                                                      //                                             fontWeight:
                                                                      //                                                 FontWeight.bold),
                                                                      //                                       ),

                                                                      //                                     ],
                                                                      //                                   ),
                                                                      //                                 ),
                                                                      //                                 Container(
                                                                      //                                   //  width: screenWidth * 0.35,
                                                                      //                                   child: Row(
                                                                      //                                     children: [
                                                                      //                                       Text(
                                                                      //                                         'Dr Name :',
                                                                      //                                         style: TextStyle(
                                                                      //                                             fontWeight:
                                                                      //                                                 FontWeight.bold),
                                                                      //                                       ),
                                                                      //                                     ],
                                                                      //                                   ),
                                                                      //                                 ),
                                                                      //                               ],
                                                                      //                             ),
                                                                      //                           ),
                                                                      //                           Padding(
                                                                      //                             padding: const EdgeInsets.all(0.0),
                                                                      //                             child: Row(
                                                                      //                               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      //                               children: [
                                                                      //                                 Container(
                                                                      //                                   width: screenWidth * 0.45,
                                                                      //                                   child: Row(
                                                                      //                                     children: [
                                                                      //                                       Text(
                                                                      //                                         'Ref Name :',
                                                                      //                                         style: TextStyle(
                                                                      //                                             fontWeight:
                                                                      //                                                 FontWeight.bold),
                                                                      //                                       ),
                                                                      //                                     ],
                                                                      //                                   ),
                                                                      //                                 ),
                                                                      //                                 Container(
                                                                      //                                   //  width: screenWidth * 0.35,
                                                                      //                                   child: Row(
                                                                      //                                     children: [
                                                                      //                                       Text(
                                                                      //                                         'Med Name:',
                                                                      //                                         style: TextStyle(
                                                                      //                                             fontWeight:
                                                                      //                                                 FontWeight.bold),
                                                                      //                                       ),
                                                                      //                                     ],
                                                                      //                                   ),
                                                                      //                                 )
                                                                      //                               ],
                                                                      //                             ),
                                                                      //                           ),

                                                                      //                           Padding(
                                                                      //                             padding: const EdgeInsets.all(0.0),
                                                                      //                             child: Row(
                                                                      //                               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      //                               children: [
                                                                      //                                 Container(
                                                                      //                                   width: screenWidth * 0.45,
                                                                      //                                   child: Row(
                                                                      //                                     children: [
                                                                      //                                       Text(
                                                                      //                                         'No.Of.Date :',
                                                                      //                                         style: TextStyle(
                                                                      //                                             fontWeight:
                                                                      //                                                 FontWeight.bold),
                                                                      //                                       ),
                                                                      //                                     ],
                                                                      //                                   ),
                                                                      //                                 ),
                                                                      //                                 Container(
                                                                      //                                   width: screenWidth * 0.30,
                                                                      //                                   child: Row(
                                                                      //                                     children: [
                                                                      //                                       Text(
                                                                      //                                         'Method :',
                                                                      //                                         style: TextStyle(
                                                                      //                                             fontWeight:
                                                                      //                                                 FontWeight.bold),
                                                                      //                                       ),
                                                                      //                                     ],
                                                                      //                                   ),
                                                                      //                                 ),
                                                                      //                               ],
                                                                      //                             ),
                                                                      //                           ),
                                                                      //                           Padding(
                                                                      //                             padding: const EdgeInsets.all(0.0),
                                                                      //                             child: Row(
                                                                      //                               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      //                               children: [
                                                                      //                                 Container(
                                                                      //                                   width: screenWidth * 0.45,
                                                                      //                                   child: Row(
                                                                      //                                     children: [
                                                                      //                                       Text(
                                                                      //                                         ' Before/After Food :',
                                                                      //                                         style: TextStyle(
                                                                      //                                             fontWeight:
                                                                      //                                                 FontWeight.bold),
                                                                      //                                       ),
                                                                      //                                     ],
                                                                      //                                   ),
                                                                      //                                 ),

                                                                      //                               ],
                                                                      //                             ),
                                                                      //                           ),

                                                                      //                         ],
                                                                      //                       ),
                                                                      //                     ),
                                                                      //                          ],
                                                                      //                    ),

                                                                      //                                               ),

                                                                      //                                               );

                                                                      //                                               }
                                                                      //                                               )

                                                                      //                   ],
                                                                      //                 ),
                                                                      //               ),
                                                                      //             ),
                                                                      //           );
                                                                      //         },
                                                                      //       ),
                                                                      //       ));

                                                                      //                                 },
                                                                    ),
                                                                    PopupMenuItem(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.print,
                                                                            color:
                                                                                custom_color.appcolor,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 10),
                                                                            child:
                                                                                Text(
                                                                              'Print Prescription',
                                                                              style: TextStyle(fontSize: 16),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => Prescriptionprint(select_print: data)));
                                                                        //                                   showDialog(context: context, builder: ((context) => AlertDialog(
                                                                        //                                     actions: [
                                                                        //                                         Padding(padding: EdgeInsets.all(10)),
                                                                        //                                         Container(
                                                                        //                                           height: screenHeight*0.04,
                                                                        //                                           width: screenWidth*0.14,
                                                                        //                                         ),

                                                                        //                                         Center(
                                                                        //                                           child: Container(
                                                                        //                                           child: Text('Choose Size & Formet',
                                                                        //                                           style: TextStyle(fontSize: 20,
                                                                        //                                           fontWeight: FontWeight.bold),),
                                                                        //                                           ),
                                                                        //                                         ),

                                                                        //                               SizedBox(height: screenHeight*0.02,),

                                                                        //     Row(
                                                                        //     // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                        //     children: [
                                                                        //       Container(
                                                                        //        // width: screenWidth * 0.50,
                                                                        //         width: screenWidth*0.20,
                                                                        //         child: Text(
                                                                        //           'Print',
                                                                        //           style: TextStyle(
                                                                        //               fontWeight: FontWeight.bold, fontSize: 17),
                                                                        //         ),
                                                                        //       ),
                                                                        //       SizedBox(width: screenWidth*0.02,),
                                                                        //       Container(
                                                                        //         child: Row(
                                                                        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                        //           children: [
                                                                        //             Container(
                                                                        //                width:screenWidth*0.20,
                                                                        //               child: Row(
                                                                        //                 children: [
                                                                        //                   Radio<int>(
                                                                        //                     value: 1,
                                                                        //                     groupValue: _printSelected,
                                                                        //                     activeColor: Colors.blue,
                                                                        //                     onChanged: (value) {

                                                                        //                       setState(() {
                                                                        //                          _printSelected = value as int;
                                                                        //                          _printVal = 'A4';
                                                                        //                         print(_printVal);
                                                                        //                       });
                                                                        //                     },
                                                                        //                   ),
                                                                        //                   const Text("A4"),

                                                                        //                 ],
                                                                        //               ),
                                                                        //             ),
                                                                        //             Row(
                                                                        //               children: [
                                                                        //                 Container(
                                                                        //                   width: screenWidth*0.18,
                                                                        //                   child: Radio(
                                                                        //                     value: 2,
                                                                        //                     groupValue: _printSelected,
                                                                        //                     activeColor: Colors.blue,
                                                                        //                     onChanged: (value) {

                                                                        //                       setState(() {
                                                                        //                          _printSelected = value as int;
                                                                        //                          _printVal = 'A5';
                                                                        //                         print(_printVal);
                                                                        //                       });
                                                                        //                     },
                                                                        //                   ),

                                                                        //                 ),
                                                                        //                 const Text("A5"),
                                                                        //               ],
                                                                        //             ),
                                                                        //           ],
                                                                        //         ),
                                                                        //       )
                                                                        //     ],
                                                                        //   ),

                                                                        //    Row(
                                                                        //     // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                        //     children: [
                                                                        //       Container(
                                                                        //        // width: screenWidth * 0.50,
                                                                        //         width: screenWidth*0.20,
                                                                        //         child: Text(
                                                                        //           'Header',
                                                                        //           style: TextStyle(
                                                                        //               fontWeight: FontWeight.bold, fontSize: 17),
                                                                        //         ),
                                                                        //       ),
                                                                        //       SizedBox(width: screenWidth*0.02,),
                                                                        //       Container(
                                                                        //         child: Row(
                                                                        //           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                        //           children: [
                                                                        //             Container(
                                                                        //                width:screenWidth*0.20,
                                                                        //               child: Row(
                                                                        //                 children: [
                                                                        //                   Radio(
                                                                        //                     value: 'yes',
                                                                        //                     groupValue: _headerSelected,
                                                                        //                     activeColor: Colors.blue,
                                                                        //                     onChanged: (value) {
                                                                        //                       setState(() {
                                                                        //                          _headerSelected = value.toString();
                                                                        //                         //  _headerval = 'Yes';

                                                                        //                       });
                                                                        //                     },
                                                                        //                   ),
                                                                        //                   const Text("Yes"),
                                                                        //                 ],
                                                                        //               ),
                                                                        //             ),
                                                                        //             // SizedBox(width: screenWidth*0.01,),
                                                                        //             Container(
                                                                        //               child: Row(
                                                                        //                 children: [
                                                                        //                   Container(
                                                                        //                     width: screenWidth*0.18,
                                                                        //                     child:
                                                                        //                      Radio(
                                                                        //                       value: "no",
                                                                        //                       groupValue: _headerSelected,
                                                                        //                       activeColor: Colors.blue,
                                                                        //                       onChanged: (value) {

                                                                        //                         setState(() {

                                                                        //                            _headerSelected=value.toString();

                                                                        //                         });
                                                                        //                         setState(() {

                                                                        //                         });
                                                                        //                       },
                                                                        //                     ),
                                                                        //                   ),
                                                                        //                   const Text("No"),
                                                                        //                 ],
                                                                        //               ),
                                                                        //             ),
                                                                        //           ],
                                                                        //         ),
                                                                        //       )
                                                                        //     ],
                                                                        //   ),

                                                                        //    SizedBox(height: screenHeight*0.04,),
                                                                        // Row(
                                                                        //   children: [

                                                                        //        Container(
                                                                        //         width: screenWidth*0.30,
                                                                        //          child: ElevatedButton(

                                                                        //          style: ButtonStyle(
                                                                        //             backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                                                        //             shape: WidgetStateProperty.all<RoundedRectangleBorder>(

                                                                        //             RoundedRectangleBorder(
                                                                        //             borderRadius: BorderRadius.circular(10),

                                                                        //              ),

                                                                        //              )

                                                                        //              ),
                                                                        //          child:Text('Cancel',
                                                                        //          style: TextStyle(fontSize: 20,color: Colors.white),),
                                                                        //          onPressed: (() {
                                                                        //          Navigator.push(context, MaterialPageRoute(builder: (context)=>Prescription_List()));

                                                                        //          }),),
                                                                        //        ),
                                                                        //        SizedBox(width: screenWidth*0.04,),
                                                                        //  Container(
                                                                        //   width: screenWidth*0.32,
                                                                        //    child: ElevatedButton(
                                                                        //    style: ButtonStyle(
                                                                        //         backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                                                        //         shape: WidgetStateProperty.all<RoundedRectangleBorder>(

                                                                        //         RoundedRectangleBorder(
                                                                        //         borderRadius: BorderRadius.circular(10),

                                                                        //          ),

                                                                        //          )

                                                                        //          ),
                                                                        //      child:Text('Confirm',
                                                                        //      style: TextStyle(fontSize: 20,color: Colors.white),),
                                                                        //      onPressed: (() {
                                                                        //     reoportbillid =
                                                                        //     data['presc_id'].toString();

                                                                        //      Codec<String, String>
                                                                        //       stringToBase64 =
                                                                        //       utf8.fuse(base64);
                                                                        //        final encoded =
                                                                        //      base64.encode(utf8.encode(reoportbillid));
                                                                        //     _launchInBrowser(Uri.parse('https://nigdoc.com/users/patient_checkup.php?pre=${encoded}=&size=${Helper().isvalidElement(_printSelected)&& _printSelected == 1 ?"a4":"a5"}&header=${Helper().isvalidElement(_headerSelected)&& _headerSelected == 1 ?"yes":"no"}'));

                                                                        //      }),),
                                                                        //  ),
                                                                        //        SizedBox(height: screenHeight*0.04,),
                                                                        //    ],
                                                                        //  ),

                                                                        //                                     ],
                                                                        //                                   )));
                                                                      },
                                                                    ),
                                                                    PopupMenuItem(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.cancel,
                                                                            color:
                                                                                custom_color.appcolor,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 10),
                                                                            child:
                                                                                Text(
                                                                              'Cancel',
                                                                              style: TextStyle(fontSize: 16),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => Prescription_List()));
                                                                        getprescriptionist();
                                                                      },
                                                                    )
                                                                  ]),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Container(
                                child: Text('no data'),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  getprescriptionist() async {
    // var formatter = new DateFormat('yyyy-mm-dd');
    var formatter = new DateFormat('yyyy-MM-dd');
    var data = {
      "from_date": fromdateInputController.text.toString(),
      "to_date": todateInputController.text.toString(),
      "doctor_id": DoctorDropdownvalue,
      'id': DoctorDropdownvalue,
      // "status_type": "Pending",
    };
    // this.setState(() {
    //   isLoading = true;
    // });
    prescription = await PatientApi().getprescriptionist(accesstoken, data);
    if (Helper().isvalidElement(prescription) &&
        Helper().isvalidElement(prescription['status']) &&
        prescription['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      prescriptionList = prescription['list'];
      for (var data in prescriptionList) {
        if (DoctorDropdownvalue == 'All') {
          presc_list.add(data);
        }
      }
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isLoading = true;
      });
    }
  }

  getdoctorlist() async {
    //  prescription.clear();
    var doctorlist = await api().getdoctorlist(accesstoken);
    if (Helper().isvalidElement(doctorlist) &&
        Helper().isvalidElement(doctorlist['status']) &&
        doctorlist['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      DoctorList = doctorlist['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isLoading = true;
      });
    }
  }

  List test_List = [];
  get() {
    // prescription.clear();
    if (DoctorDropdownvalue.isNotEmpty) {
      presc_list.clear();
      for (var data in prescriptionList) {
        if (DoctorDropdownvalue == data['doctor_id'].toString()) {
          presc_list.add(data);
        }
      }
    }
    // else{
    //    presc_list.clear();
    //   for(var data in prescriptionList){
    //          if(DoctorDropdownvalue == 'All'){
    //           presc_list.add(data);
    //          }
    //   }
    // }
  }
}
