import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/Api.dart';
import 'package:nigdoc/AppWidget/Notification/AppoinmentList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/Shop/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class Addappoinment extends StatefulWidget {
  const Addappoinment({super.key});

  @override
  State<Addappoinment> createState() => _AddappoinmentState();
}

class _AddappoinmentState extends State<Addappoinment> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  final DateFormate = "yyyy-MM-dd";
  TextEditingController dateController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController mobilenocontroller = TextEditingController();
  TextEditingController alternatenocontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController bloodgroupcontroller = TextEditingController();
  TextEditingController heightcontroller = TextEditingController();
  TextEditingController weightcontroller = TextEditingController();
  TextEditingController sugarcontroller = TextEditingController();
  TextEditingController bpcontroller = TextEditingController();
  TextEditingController pulsecontroller = TextEditingController();
  TextEditingController tempcontroller = TextEditingController();
  TextEditingController spo2controller = TextEditingController();
  TextEditingController bmicontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();
  TextEditingController slottimecontroller = TextEditingController();

final FocusNode ageFocusNode = FocusNode();
final FocusNode mobileFocusNode = FocusNode();
final FocusNode nameFocusNode = FocusNode();


   void dispose() {
    ageFocusNode.dispose();
    mobileFocusNode.dispose();
    nameFocusNode.dispose();
 
  }

  
 var appointmentSelected = 1;
 String ApponitmentVal = "Call";

 var adultSelected =1 ;
 String adultVal = "Adult";


  String selected_title = 'Mr';
var title =[
     'Mr',
     'Mrs',
     'Ms',
     'Master',
     'Miss',
     'Smt',
     'Dr',
     'Born Baby',
     'Baby'

];
String selected_gender = 'Male';
var gender =[
  'Male',
  'Female',
  'Others'
];
String selected_height = 'Ft';
var height =[
'Ft',
'Cm',
'In'
];
String selected_weight = 'Pounds';
var weight =[
'Pounds',
'Kg',
];
String selected_temp = 'F';
var temp =[
'F',
'C',
'K'
];
  // String selected_slot = '10:00 AM to 01.00 PM';
// var slot =[
//      '10:00 AM to 01.00 PM',
//      '06:05 PM to 10.00 PM',
//      '10:00 AM to 06.00 PM',
//      '10:00 AM to 02.00 PM',
//      '10:00 AM to 07.00 AM',
     

// ];
var selected_slot;
var doctordropdown;
List DoctorList = [];
var patient_detail;
bool patient = true;
var cid;
List slot_time1=[];
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
                onPrimary: Colors.white, 
                onSurface: custom_color.appcolor, 
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: custom_color.appcolor, 
                ),
              ),
            ),
            child: child!,
          );
        },
        initialDate: currentDate,
        firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 15));


    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    if (checkfield == "Date") {
      // var formatter = new DateFormat('dd-MM-yyyy');
      dateController.text =
          DateFormat(DateFormate).format(pickedDate!);

      // getcancelledlist();
    } else {
      dateController.text = DateFormat(DateFormate).format(pickedDate!);
     
      // getcancelledlist();
    }
  }
  // DateTime currentDate1 = DateTime.now();
Future<void> selectDateslot(BuildContext context, String data) async {
  var checkfield = data;

  // Display date picker
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: custom_color.appcolor,
            onPrimary: Colors.white,
            onSurface: custom_color.appcolor,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: custom_color.appcolor,
            ),
          ),
        ),
        child: child!,
      );
    },
    initialDate: currentDate,
    firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 15),
  );

  if (pickedDate != null) {
 
    final DateTime finalDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      currentDate.hour,
      currentDate.minute,
      currentDate.second,
    );

    setState(() {
      currentDate = finalDateTime; 
    });

   
    String formattedDateTime = DateFormat("$DateFormate  HH:mm:ss").format(finalDateTime);
    slottimecontroller.text = formattedDateTime;

  }
}

  Future<void> selectDOB(BuildContext context, data) async {
    var checkfield = data;
    // print(data);
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: custom_color.appcolor,
                onPrimary: Colors.white, 
                onSurface: custom_color.appcolor, 
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: custom_color.appcolor, 
                ),
              ),
            ),
            child: child!,
          );
        },
        initialDate: currentDate,
        firstDate: DateTime(DateTime.now().year-100, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));


    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    if (checkfield == "DOB") {
      // var formatter = new DateFormat('dd-MM-yyyy');
      dobController.text =
          DateFormat(DateFormate).format(pickedDate!);

      // getcancelledlist();
    } else {
      dobController.text = DateFormat(DateFormate).format(pickedDate!);
     
      // getcancelledlist();
    }
  }
  var accesstoken;
  var userResponse;
  bool isLoading = false;
  var Patient_data_list;
   var selectedpatient;
   var config;
   var appoinment_slot_time;
   void initState() {
    int1();
     
   
    super.initState();
  }
  int1()async{
    accesstoken = storage.getItem('userResponse')['access_token'];
    userResponse = storage.getItem('userResponse');
    // accesstoken=userResponse['access_token'];
    dateController.text = Helper().getCurrentDate();
    await getclinicconfig();
    await getPatientList();
    await getdoctorlist();
  
  }
   getclinicconfig() async {
   var clinicconfig = await ShopApi().getclinicconfig(accesstoken);
    if (Helper().isvalidElement(clinicconfig) &&
        Helper().isvalidElement(clinicconfig['status']) &&
        clinicconfig['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      config = clinicconfig['list'];
      appoinment_slot_time = config[0]['appoinment_slot_time'];
    
   
    }
  }
  //  getdoctorlist() async {
   
  //  var doctorlist = await PatientApi().getSlotTimeDoctorList(accesstoken);
  //   if (Helper().isvalidElement(doctorlist) &&
  //       Helper().isvalidElement(doctorlist['status']) &&
  //       doctorlist['status'] == 'Token is Expired') {
  //     Helper().appLogoutCall(context, 'Session expeired');
  //   } else {
  //     DoctorList=doctorlist['doctor'];
    

  //     this.setState(() {
  //       isLoading = true;
  //     });
  //   }
  // }
   getdoctorlist() async {
    
    var formatter = new DateFormat('yyyy-MM-dd');
    var data = {
      "date": dateController.text.toString(),
     
    };
    // this.setState(() {
    //   isLoading = true;
    // });
    var doctorlis = await PatientApi().getSlotTimeDoctorList(accesstoken, data);
    if (Helper().isvalidElement(doctorlis) &&
        Helper().isvalidElement(doctorlis['status']) &&
        doctorlis['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      DoctorList = doctorlis['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isLoading = true;
      });
    }
  }
  getPatientList() async {
    var List = await PatientApi().getpatientlist(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        Patient_data_list = List['Customer_list'];
        isLoading = true;
        // filterItems(searchText.text);
        // var values = MediAndLabNameList;
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }
//   getSlotTime() async {
//   var formatter = DateFormat('yyyy-MM-dd');
//   var data = {
//     "date": dateController.text.toString(),
//     'id': doctordropdown.toString(),
//   };

//   try {
//     var list = await PatientApi().getSlotTime(accesstoken, data);

//     if (list is Map<String, dynamic> &&
//         Helper().isvalidElement(list['status']) &&
//         list['status'] == 'Token is Expired') {
//       Helper().appLogoutCall(context, 'Session expired');
//       return;
//     }

//     // if (list is Map<String, dynamic>) {
//     //   var extractedList = list['list']; 
//     //   print(extractedList);
//     //   if (extractedList is List<dynamic>) {
//     //     slot_time1 = extractedList;
//     //   } else {
//     //     print('Expected a List<dynamic>, but got ${extractedList.runtimeType}');
//     //   }
//     // } else {
//     //   print('Unexpected response type: ${list.runtimeType}');
//     // }
//     if (list is Map<String, dynamic>) {
//   var extractedList = list['list']; 
//   print(extractedList);

//   if (extractedList is List<dynamic>) {
   
//     slot_time1 = extractedList;
//   } else if (extractedList is Map) {
   
//     slot_time1 = extractedList.values.map((entry) {
//       return {"time": entry};
//     }).toList();
//     print(slot_time1);
//   } else {
   
//     slot_time1 = []; 
//   }
// } else {
 
//   slot_time1 = []; 
// }

// print('Assigned slot_time1: $slot_time1');


//     setState(() {
//       isLoading = true;
//     });
//   } catch (e) {
//     print('Error fetching slot times: $e');
//   }
// }

  getSlotTime() async {
    
    var formatter = new DateFormat('yyyy-MM-dd');
    var data = {
      "date": dateController.text.toString(),
      'doctor_id':doctordropdown.toString()
     
    };
    // this.setState(() {
    //   isLoading = true;
    // });
    var list = await PatientApi().getSlotTime(accesstoken, data);
    if (Helper().isvalidElement(list) &&
        Helper().isvalidElement(list['status']) &&
        list['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      // var ll=list;
      slot_time1 = list['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isLoading = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidht = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AppointmentList()));
      },
      child: Scaffold(
       appBar: AppBar(
          title: Text(
            'Add Appointments',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: custom_color.appcolor,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentList(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Container(
                
                child: Column(
                  children: [
                    SizedBox(height: screenHeight*0.02,),
                     appoinment_slot_time == "automatic"?  Container(
                                // width: screenWidht * 0.45,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: '',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    labelText: 'Date',
                                    suffixIcon: Icon(
                                      Icons.date_range,
                                      color: custom_color.appcolor,
                                    ),
                                  ),
                                  controller: dateController,
                                  readOnly: true,
                                  onTap: () async {
                                    selectDate(context, 'Date');
                                  },
                                ),
                              ):Container(),
                          
                   SizedBox(height: screenHeight*0.02,),
                  
                                SizedBox(
              // width: screenWidht * 0.95,
              child: DoctorList.length>0?DropdownButtonFormField(
                menuMaxHeight: 300,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  isExpanded: true,
                  hint: Text(
                    'Doctor *',
                  ),
                  // value:patternDropdownvalue,
                  onChanged: (item) async {
                    setState(() {
                   slot_time1=[];
                   });
                    
              
                    doctordropdown = item;
                    await getSlotTime();
                   setState(() {
                   
                   });
                  
                  },
                  items: DoctorList
                      .map(
                          (value) => DropdownMenuItem<String>(
                                value: value['id'].toString(),
                                child: Text(value["d_name"].toString()),
                              ))
                      .toList()
              
                  ):DropdownButtonFormField(
                menuMaxHeight: 300,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  isExpanded: true,
                  hint: Text(
                    'Doctor *',
                  ),
                  // value:patternDropdownvalue,
                  onChanged: (item) async {
              
                    doctordropdown = item;
                  
                  
                  },
                 items: [].map<
                         DropdownMenuItem<
                        String>>((item) {
                            return new DropdownMenuItem(
                           child:
                             new Text(''),
                            value: '',
                           );
                       }).toList(),
                  )),
                  SizedBox(height: screenHeight*0.02,),
                 appoinment_slot_time == "automatic"?  Container(
                               height: screenHeight * 0.06,
                              //  width: screenWidht * 0.20,
                              //  decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                              //  borderRadius: BorderRadius.circular(5.0)
                              //      // border: OutlineInputBorder()
                              //      ),
                               child: Center(
                                 child:slot_time1.length>0? DropdownButtonFormField<dynamic>(
                                //  menuMaxHeight: 300,
                                   decoration: InputDecoration(
                                                   enabledBorder: OutlineInputBorder(
                                                     borderRadius: BorderRadius.circular(5.0),
                                                     borderSide: BorderSide(
                                                       color: Colors.grey,
                                                       width: 1.0,
                                                     ),
                                                   ),
                                                   focusedBorder: OutlineInputBorder(
                                                     borderRadius: BorderRadius.circular(5.0),
                                                     borderSide: BorderSide(
                                                       color: Colors.grey,
                                                       width: 1.0,
                                                     ),
                                                   ),
                                                 ),
                                                
                                   isExpanded: true,
                                   hint: Padding(
                                   padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
                                    //  child: Text(
                                    //    selected_title, 
                                    //  ),
                                    child: Text(
                                       'Slot Time', 
                                     ),
                                   ),
                                  
                                   onChanged: (selected) {
                                     var selected_slot1=selected.toString();
                                     selected_slot=selected_slot1;
                                     setState(() {
                                      
                                     });
                                   },
                                   items:slot_time1
                                                     .map(
                                                         (value) => DropdownMenuItem(
                                                               value: value['time'].toString(),
                                                               child: Text(value["time"].toString()),
                                                             ))
                                                     .toList()
                                 ):DropdownButtonFormField(
                                               menuMaxHeight: 300,
                                                 decoration: InputDecoration(
                                                   enabledBorder: OutlineInputBorder(
                                                     borderRadius: BorderRadius.circular(5.0),
                                                     borderSide: BorderSide(
                                                       color: Colors.grey,
                                                       width: 1.0,
                                                     ),
                                                   ),
                                                   focusedBorder: OutlineInputBorder(
                                                     borderRadius: BorderRadius.circular(5.0),
                                                     borderSide: BorderSide(
                                                       color: Colors.grey,
                                                       width: 1.0,
                                                     ),
                                                   ),
                                                 ),
                                                 isExpanded: true,
                                                 hint: Text(
                                                   'Slot Time',
                                                 ),
                                                 // value:patternDropdownvalue,
                                                 onChanged: (item) async {
                                             
                                                   selected_slot = item!;
                                                 
                                                 
                                                 },
                                                items: [].map<
                                                        DropdownMenuItem<
                                                       String>>((item) {
                                                           return new DropdownMenuItem(
                                                          child:
                                                            new Text(''),
                                                           value: '',
                                                          );
                                                      }).toList(),
                                                 )),
                               ):
                                Container(
                                // width: screenWidht * 0.45,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: '',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    labelText: 'Slot Time',
                                    suffixIcon: Icon(
                                      Icons.date_range,
                                      color: custom_color.appcolor,
                                    ),
                                  ),
                                  controller: slottimecontroller,
                                  readOnly: true,
                                  onTap: () async {
                                    selectDateslot(context, 'Slot Time');
                                  },
                                ),
                              ),
                             
                              SizedBox(height: screenHeight*0.02,),
                             Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: screenWidht * 0.50,
                    child: Text(
                      'Appointment',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: appointmentSelected,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      appointmentSelected = value!;
                      ApponitmentVal = 'Call';
                      print(ApponitmentVal);
                    });
                  },
                ),
                const Text("Call"),
              ],
                        ),
                        Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: appointmentSelected,
                  activeColor: Color.fromRGBO(33, 150, 243, 1),
                  onChanged: (value) {
                    setState(() {
                      appointmentSelected = value!;
                      ApponitmentVal = 'Visit';
                      print(ApponitmentVal);
                    });
                  },
                ),
                const Text("Visit"),
              ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
                             SizedBox(height: screenHeight*0.02,),
                   
                     Container(
                           height: screenHeight * 0.06,
                          //  width: screenWidht * 0.30,
                           decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                           borderRadius: BorderRadius.circular(5.0)
                               // border: OutlineInputBorder()
                               ),
                           child: Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: Center(
                               child: DropdownButtonFormField(
                               menuMaxHeight: 300,
                                 decoration: InputDecoration.collapsed(hintText: ''),
                                 isExpanded: true,
                                 hint: Padding(
                                 padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
                                   child: Text(
                                     selected_title, 
                                   ),
                                 ),
                                
                                 onChanged: (selected) {
                                   selected_title=selected.toString();
                                   setState(() {
                                    
                                   });
                                 },
                                 items: title.map<DropdownMenuItem<String>>((item) {
                                   return new DropdownMenuItem(
                                     child: Padding(
                                       padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
                                       child: new Text(item,style: TextStyle(fontSize: 16),),
                                     ),
                                     value: item.toString(),
                                   );
                                 }).toList(),
                               ),
                             ),
                           ),
                         ),
                        //  Container(
                        //   height: screenHeight * 0.06,
                        //   width: screenWidht * 0.46,
                        //   child: TextField(
                        //     controller: namecontroller,
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(),
                        //       labelText: 'Name *'
                            
                        //     ),
                        //   ),
                        //  )
                        SizedBox(height: screenHeight*0.02,),
                         patient? Container(
                            height: screenHeight * 0.06,
                          // width: screenWidht * 0.60,
                                     child: Helper().isvalidElement(selectedpatient)
                                             ? Rendernamedata(screenHeight, screenWidht)
                                             : rendernameAutoComplete(screenHeight, screenWidht),
                                   ):Container(
                                     height: screenHeight * 0.07,
                                //  width: screenWidht * 0.60,
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                   border: Border.all(color: custom_color.appcolor,width: 2.0,),
                                 ),
                                 child: Row(
                                   children: [
                                     Container(
                                       width: screenWidht*0.75,
                                       child: Center(
                                         child: Center(
                                           child: TextFormField(
                                            focusNode: nameFocusNode,
                                             decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Patient Name'),
                                             controller: namecontroller,
                                             // focusNode: nameFocusNode,
                                             // focusNode: focusNode,
                                             onChanged: (text) {
                      namecontroller.text = text;
                                             },
                                           ),
                                         ),
                                       ),
                                     ),
                                     Container(
                                       width: screenWidht * 0.10,
                      height: screenHeight,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: custom_color.error_color,
                          ),
                          onPressed: () {
                            setState(() {
                             
                              namecontroller.clear();
                              agecontroller.clear();
                              // referredbyController.clear();
                              mobilenocontroller.clear();
                              patient = true;
                              patient_detail=null;
                            });
                          },
                        ),
                      )
                                     )
                                   ],
                                 ),
                                   ),
                         SizedBox(height: screenHeight*0.02,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Container(
                                   height: screenHeight * 0.06,
                                   width: screenWidht * 0.46,
                                   decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                                   borderRadius: BorderRadius.circular(5.0)
                                       // border: OutlineInputBorder()
                                       ),
                                   child: Padding(
                                     padding: const EdgeInsets.all(10.0),
                                     child: Center(
                                       child: DropdownButtonFormField(
                                       menuMaxHeight: 300,
                                         decoration: InputDecoration.collapsed(hintText: ''),
                                         isExpanded: true,
                                         hint: Padding(
                                         padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
                                           child: Text(
                                             selected_gender, 
                                           ),
                                         ),
                                        
                                         onChanged: (selectedgender) {
                                           selected_gender=selectedgender.toString();
                                           setState(() {
                                            
                                           });
                                         },
                                         items: gender.map<DropdownMenuItem<String>>((item) {
                                           return new DropdownMenuItem(
                                             child: Padding(
                                               padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
                                               child: new Text(item,style: TextStyle(fontSize: 16),),
                                             ),
                                             value: item.toString(),
                                           );
                                         }).toList(),
                                       ),
                                     ),
                                   ),
                                 ),
                                  Container(
                                width: screenWidht * 0.46,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: '',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    labelText: 'DOB',
                                    suffixIcon: Icon(
                                      Icons.date_range,
                                      color: custom_color.appcolor,
                                    ),
                                  ),
                                  controller: dobController,
                                  readOnly: true,
                                  onTap: () async {
                                    selectDOB(context, 'DOB');
                                  },
                                ),
                              ),
                           ],
                         ),
                         SizedBox(height: screenHeight*0.02,),
                             Container(
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   Row(
                                     children: [
                                       Radio(
                                         value: 1,
                                         groupValue: adultSelected,
                                         activeColor: Colors.blue,
                                         onChanged: (value) {
                                           setState(() {
                                             adultSelected = value!;
                                             adultVal = 'Adult';
                                             print(ApponitmentVal);
                                           });
                                         },
                                       ),
                                       const Text("Adult"),
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       Radio(
                                         value: 2,
                                         groupValue: adultSelected,
                                         activeColor: Color.fromRGBO(33, 150, 243, 1),
                                         onChanged: (value) {
                                           setState(() {
                                             adultSelected = value!;
                                             adultVal = 'Peado';
                                             print(adultVal);
                                           });
                                         },
                                       ),
                                       const Text("Peado"),
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                             SizedBox(height: screenHeight*0.02,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                  // height: screenHeight * 0.06,
                                  width: screenWidht * 0.46,
                                  child: TextFormField(
                                    maxLength: 10,
                                     keyboardType:TextInputType.number,
                                    focusNode: mobileFocusNode,
                                    controller: mobilenocontroller,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Mobile No *'
                                    
                                    ),
                                  ),
                                    ),
                                      
                              Container(
                              // height: screenHeight * 0.06,
                              width: screenWidht * 0.46,
                              child: TextFormField(
                                maxLength: 10,
                                keyboardType:TextInputType.number,
                                controller: alternatenocontroller,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Alternate Mobile No'
                                
                                ),
                              ),
                             ),
                                ],
                              ),
                           
                             SizedBox(height: screenHeight*0.02,),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(
                                  // height: screenHeight * 0.06,
                                  width: screenWidht * 0.46,
                                  child: TextFormField(
                                     keyboardType:TextInputType.number,
                                     focusNode: ageFocusNode,
                                    controller: agecontroller,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Age *'
                                    
                                    ),
                                  ),
                                 ),
                                  Container(
                              // height: screenHeight * 0.06,
                              width: screenWidht * 0.46,
                              child: TextFormField(
                                // keyboardType:TextInputType.number,
                                controller: bloodgroupcontroller,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Blood Group'
                                
                                ),
                              ),
                             ),
                               ],
                             ), 
                             SizedBox(height: screenHeight*0.02,),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(
                                  // height: screenHeight * 0.06,
                                  width: screenWidht * 0.46,
                                  child: TextFormField(
                                     keyboardType:TextInputType.number,
                                    controller: heightcontroller,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Height'
                                    
                                    ),
                                  ),
                                 ),
                                  Container(
                               height: screenHeight * 0.06,
                               width: screenWidht * 0.46,
                               decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                               borderRadius: BorderRadius.circular(5.0)
                                   // border: OutlineInputBorder()
                                   ),
                               child: Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: Center(
                                   child: DropdownButtonFormField(
                                   menuMaxHeight: 300,
                                     decoration: InputDecoration.collapsed(hintText: ''),
                                     isExpanded: true,
                                     hint: Padding(
                                     padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
                                       child: Text(
                                         selected_height, 
                                       ),
                                     ),
                                    
                                     onChanged: (selected) {
                                       selected_height=selected.toString();
                                       setState(() {
                                        
                                       });
                                     },
                                     items: height.map<DropdownMenuItem<String>>((item) {
                                       return new DropdownMenuItem(
                                         child: Padding(
                                           padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
                                           child: new Text(item,style: TextStyle(fontSize: 16),),
                                         ),
                                         value: item.toString(),
                                       );
                                     }).toList(),
                                   ),
                                 ),
                               ),
                             ),
                               ],
                             ), 
                             SizedBox(height: screenHeight*0.02,),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(
                                  // height: screenHeight * 0.06,
                                  width: screenWidht * 0.46,
                                  child: TextFormField(
                                     keyboardType:TextInputType.number,
                                    controller: weightcontroller,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Weight'
                                    
                                    ),
                                  ),
                                 ),
                                  Container(
                               height: screenHeight * 0.06,
                               width: screenWidht * 0.46,
                               decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                               borderRadius: BorderRadius.circular(5.0)
                                   // border: OutlineInputBorder()
                                   ),
                               child: Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: Center(
                                   child: DropdownButtonFormField(
                                   menuMaxHeight: 300,
                                     decoration: InputDecoration.collapsed(hintText: ''),
                                     isExpanded: true,
                                     hint: Padding(
                                     padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
                                       child: Text(
                                         selected_weight, 
                                       ),
                                     ),
                                    
                                     onChanged: (selected) {
                                       selected_weight=selected.toString();
                                       setState(() {
                                        
                                       });
                                     },
                                     items: weight.map<DropdownMenuItem<String>>((item) {
                                       return new DropdownMenuItem(
                                         child: Padding(
                                           padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
                                           child: new Text(item,style: TextStyle(fontSize: 16),),
                                         ),
                                         value: item.toString(),
                                       );
                                     }).toList(),
                                   ),
                                 ),
                               ),
                             ),
                               ],
                             ), 
                             SizedBox(height: screenHeight*0.02,),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(
                                  // height: screenHeight * 0.06,
                                  width: screenWidht * 0.46,
                                  child: TextFormField(
                                    //  keyboardType:TextInputType.number,
                                    controller: sugarcontroller,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Sugar'
                                    
                                    ),
                                  ),
                                 ),
                                //  Container(
                                //   color: Colors.grey[200],
                                //   height: screenHeight * 0.06,
                                //   width: screenWidht * 0.46,
                                //   child: Center(child: Text('mg/dL',style: TextStyle(fontSize: 18),)),
                                //  )
                                  Container(
                                    color: Colors.grey[200],
                              // height: screenHeight * 0.06,
                              width: screenWidht * 0.46,
                              child: TextFormField(
                                 readOnly: true,
                                keyboardType:TextInputType.none,
                                // controller: bloodgroupcontroller,

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'mg/dL'
                                
                                ),
                              ),
                             ),
                               ],
                             ), 
                             SizedBox(height: screenHeight*0.02,),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(
                                  // height: screenHeight * 0.06,
                                  width: screenWidht * 0.46,
                                  child: TextFormField(
                                    //  keyboardType:TextInputType.number,
                                    controller: bpcontroller,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'BP'
                                    
                                    ),
                                  ),
                                 ),
                                  Container(
                                    color: Colors.grey[200],
                              // height: screenHeight * 0.06,
                              width: screenWidht * 0.46,
                              child: TextFormField(
                                readOnly: true,
                                // keyboardType:TextInputType.none,
                                // controller: bloodgroupcontroller,

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'mmHg'
                                
                                ),
                              ),
                             ),
                               ],
                             ), 
                             SizedBox(height: screenHeight*0.02,),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(
                                  // height: screenHeight * 0.06,
                                  width: screenWidht * 0.46,
                                  child: TextFormField(
                                    //  keyboardType:TextInputType.number,
                                    controller: pulsecontroller,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Pulse'
                                    
                                    ),
                                  ),
                                 ),
                                  Container(
                                    color: Colors.grey[200],
                              // height: screenHeight * 0.06,
                              width: screenWidht * 0.46,
                              child: TextFormField(
                                 readOnly: true,
                                keyboardType:TextInputType.none,
                                // controller: bloodgroupcontroller,

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'bpm'
                                
                                ),
                              ),
                             ),
                               ],
                             ), 
                             SizedBox(height: screenHeight*0.02,),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(
                                  // height: screenHeight * 0.06,
                                  width: screenWidht * 0.46,
                                  child: TextFormField(
                                     keyboardType:TextInputType.number,
                                    controller: tempcontroller,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Temp'
                                    
                                    ),
                                  ),
                                 ),
                                  Container(
                               height: screenHeight * 0.06,
                               width: screenWidht * 0.46,
                               decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                               borderRadius: BorderRadius.circular(5.0)
                                   // border: OutlineInputBorder()
                                   ),
                               child: Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: Center(
                                   child: DropdownButtonFormField(
                                   menuMaxHeight: 300,
                                     decoration: InputDecoration.collapsed(hintText: ''),
                                     isExpanded: true,
                                     hint: Padding(
                                     padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
                                       child: Text(
                                         selected_temp, 
                                       ),
                                     ),
                                    
                                     onChanged: (selected) {
                                       selected_temp=selected.toString();
                                       setState(() {
                                        
                                       });
                                     },
                                     items: temp.map<DropdownMenuItem<String>>((item) {
                                       return new DropdownMenuItem(
                                         child: Padding(
                                           padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
                                           child: new Text(item,style: TextStyle(fontSize: 16),),
                                         ),
                                         value: item.toString(),
                                       );
                                     }).toList(),
                                   ),
                                 ),
                               ),
                             ),
                               ],
                             ), 
                           
                             SizedBox(height: screenHeight*0.02,),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(
                                  // height: screenHeight * 0.06,
                                  width: screenWidht * 0.46,
                                  child: TextFormField(
                                    //  keyboardType:TextInputType.number,
                                    controller: spo2controller,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Spo2'
                                    
                                    ),
                                  ),
                                 ),
                                  Container(
                                    color: Colors.grey[200],
                              // height: screenHeight * 0.06,
                              width: screenWidht * 0.46,
                              child: TextFormField(
                                 readOnly: true,
                                keyboardType:TextInputType.none,
                                // controller: bloodgroupcontroller,

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: '(%)'
                                
                                ),
                              ),
                             ),
                               ],
                             ), 
                             SizedBox(height: screenHeight*0.02,),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(
                                  // height: screenHeight * 0.06,
                                  width: screenWidht * 0.46,
                                  child: TextFormField(
                                    //  keyboardType:TextInputType.number,
                                    controller: bmicontroller,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'BMI'
                                    
                                    ),
                                  ),
                                 ),
                                  Container(
                                    color: Colors.grey[200],
                              // height: screenHeight * 0.06,
                              width: screenWidht * 0.46,
                              child: TextFormField(
                                 readOnly: true,
                                keyboardType:TextInputType.none,
                                // controller: bloodgroupcontroller,

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'kg/m²'
                                
                                ),
                              ),
                             ),
                               ],
                             ), 
                             SizedBox(height: screenHeight*0.02,),
                             Container(
                                  // height: screenHeight * 0.06,
                                  // width: screenWidht * 0.46,
                                  child: TextFormField(
                                    maxLines: 3,
                                    //  keyboardType:TextInputType.number,
                                    controller: notecontroller,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Note'
                                    
                                    ),
                                  ),
                                 ),
                            SizedBox(height: screenHeight*0.03,),
                                 appoinment_slot_time == "automatic"?  ElevatedButton( 
                     
                     style: ButtonStyle(
                         backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                         shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          
                                        )
                                        
                                      ),
                    child:Text('Register',
                    style: TextStyle(fontSize: 20,color: Colors.white),),
                    onPressed: (() async{
                  if(doctordropdown == null){
                          NigDocToast().showErrorToast('Please Select Doctor');
                        }
                    else if(namecontroller.text.isEmpty){
                      nameFocusNode.requestFocus();
                          NigDocToast().showErrorToast('Please Enter Your Name');
                                      
                       
                        }else if(mobilenocontroller.text.isEmpty){
                          mobileFocusNode.requestFocus();
                          NigDocToast().showErrorToast('Please Enter Your Mobile No');
                        } else if(agecontroller.text.isEmpty){
                            ageFocusNode.requestFocus();
                          NigDocToast().showErrorToast('Please Enter Your Age');
                        }
                        
                        else{
                          var items={
                              
                              "doctor_id":doctordropdown,
                              "appointment_date":dateController.text.toString(),
                              "patient_id":cid == null ?'':cid,
                              "patient_name":namecontroller.text.toString(),
                              "title":selected_title,
                              "mobileno":mobilenocontroller.text.toString(),
                              "alternatemobile":alternatenocontroller.text.toString(),
                              "gender":selected_gender,
                              "age":agecontroller.text.toString(),
                              "apponitment_type":ApponitmentVal,
                              "note":notecontroller.text.toString(),
                              // "slot_time":selected_slot
                              "slot_time":Helper().isvalidElement(selected_slot) ? selected_slot:'0.00 AM to 0.00 PM'
                       
                          };
                          print(items);
                          var list = await PatientApi()
                                     .DocAddAppoinment(accesstoken, items);
                                 if (list['message'] ==
                                     "Appoinment created") {
                                   NigDocToast().showSuccessToast(
                                       'Appoinment created');
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) => AppointmentList()));
                                 } else {
                                   NigDocToast()
                                       .showErrorToast('Please TryAgain later');
                                 }
                        
                        }
                  
                    }
                    
                    ),):ElevatedButton( 
                     
                     style: ButtonStyle(
                         backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                         shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          
                                        )
                                        
                                      ),
                    child:Text('Register',
                    style: TextStyle(fontSize: 20,color: Colors.white),),
                    onPressed: (() async{
                  if(doctordropdown == null){
                          NigDocToast().showErrorToast('Please Select Doctor');
                        }
                    else if(namecontroller.text.isEmpty){
                          NigDocToast().showErrorToast('Please Enter Your Name');
                                      
                       
                        }else if(mobilenocontroller.text.isEmpty){
                          NigDocToast().showErrorToast('Please Enter Your Mobile No');
                        } else if(agecontroller.text.isEmpty){
                          NigDocToast().showErrorToast('Please Enter Your Age');
                        }
                        
                        else{
                          var items={
                              
                              "doctor_id":doctordropdown,
                              "appointment_date":dateController.text.toString(),
                              "patient_id":cid,
                              "patient_name":namecontroller.text.toString(),
                              "title":selected_title,
                              "mobileno":mobilenocontroller.text.toString(),
                              "alternatemobile":alternatenocontroller.text.toString(),
                              "gender":selected_gender,
                              "age":agecontroller.text.toString(),
                              "apponitment_type":ApponitmentVal,
                              "note":notecontroller.text.toString(),
                              // "slot_time":selected_slot
                              // "slot_time":Helper().isvalidElement(selected_slot) ? selected_slot:'0.00 AM to 0.00 PM'
                              "slot_time":slottimecontroller.text.toString()
                       
                          };
                          var list = await PatientApi()
                                     .DocAddAppoinment(accesstoken, items);
                                 if (list['message'] ==
                                     "Appoinment created") {
                                   NigDocToast().showSuccessToast(
                                       'Appoinment created');
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) => AppointmentList()));
                                 } else {
                                   NigDocToast()
                                       .showErrorToast('Please TryAgain later');
                                 }
                        
                        }
                  
                    }
                    
                    ),),
                    SizedBox(height: screenHeight*0.04,),
                  ],
                ),
              ),
            ),
          )),
      ));
  }
  Rendernamedata(screenHeight, screenWidth) {
    return Card(
        elevation: 20,
        child: Container(
          width: screenWidth * 0.95,
          child: ListTile(
            //leading: Icon(FontAwesomeIcons.user),
            title: Text('${selectedpatient['customer_name'].toString().toUpperCase()}',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            // trailing: IconButton(
            //     onPressed: () {
            //       setState(() {
            //         selectedProduct = null;
            //         //Product_complete = [];
            //       });
            //     },
            //     icon: Icon(Icons.clear, color: Colors.red)),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ));
  }

  rendernameAutoComplete(screenHeight, screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Autocomplete<List>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isNotEmpty) {
            var matches = [];
            //           setState(() {
            //  testNameController.text = textEditingValue.text;
            //           });
            setState(() {});
            // testNameController.text = textEditingValue.text;
            matches.addAll(Patient_data_list);
            matches.retainWhere((s) {
              return s['customer_name']
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
              //||
              // s['phone']
              //     .toString()
              //     .toLowerCase()
              //     .contains(textEditingValue.text.toLowerCase());
            });
            return [matches];
          } else {
            return const Iterable<List>.empty();
          }
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return Container(
            height: screenHeight * 0.07,
            width: screenWidth * 0.95,
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(color: custom_color.appcolor,width: 1.0,),
              borderRadius: BorderRadius.all(Radius.circular(8.0))
            ),
            child: Center(
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                      //border: OutlineInputBorder(),
                      // prefixIcon: Icon(Icons.search),
                      // suffixIcon: IconButton(
                      //   icon: Icon(
                      //     Icons.close,
                      //     color: Colors.red,
                      //   ),
                      //   onPressed: () {
                      //     setState(() {
                      //       textEditingController.clear();
                      //     });
                      //   },
                      // ),
                      //border: InputBorder.none,
                      //border: InputBorder.none,
                      //border: OutlineInputBorder(),
                      border: InputBorder.none,
                      hintText: ' Patient Name *'),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onChanged: (text) {
                    namecontroller.text = text;
                  },
                ),
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
          return options.toList()[0].isNotEmpty
              ? Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: Container(
                      width: screenWidth * 0.95,
                      // height: screenHeight * 0.78,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(5.0),
                          itemCount: options.toList()[0].length,
                          itemBuilder: (BuildContext context, int index) {
                            var option = options.toList()[0].elementAt(index);
                            var mobile= Helper().isvalidElement(option['phone'])?  option['phone'].toString():'';

                            return ElevatedButton(
                                onPressed: () async {
                                  //selectedProduct = option;
                                  //await getOverall();
                                  // print("ok");
                                  // option;
                                  cid = option['cid'].toString();
                                  agecontroller.text= option["age"].toString();
                                  // referredbyController.text = option["refrral_name"].toString();
                                  namecontroller.text = option["customer_name"].toString();
                                  selected_title = option["title"].toString();
                                  mobilenocontroller.text=Helper().isvalidElement(option['phone'])?  option['phone'].toString():'';
                                  setState(() {
                                  patient = false;
                                  patient_detail = option;
                                  });
                                },
                                style: ButtonStyle(
                                    shape: WidgetStateProperty.all<
                                            OutlinedBorder?>(
                                        ContinuousRectangleBorder()),
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            custom_color.appcolor)),
                                child: Container(
                                  color: custom_color.appcolor,
                                  //  width: screenWidth *0.96,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        // color: Colors.red,
                                        // width: screenWidth * 0.5,
                                        child: Text(
                                            '${option['customer_name'].toString().toUpperCase()} ',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.02,
                                      ),
                                      SizedBox(
                                      
                                        width: screenWidth * 0.22,
                                        child: Text(
                                            mobile
                                                .toString()
                                                .toUpperCase(),
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      // Text(
                                      //     'Age: ${options.toList()[0][index]['p_age'].toString().toUpperCase()}',
                                      //     style:
                                      //         const TextStyle(color: Colors.white)),
                                      const Divider(
                                        thickness: 1,
                                      )
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ),
                    ),
                  ),
                )
              : Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: screenWidth * 0.9,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all<OutlinedBorder?>(
                                ContinuousRectangleBorder()),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                custom_color.appcolor)),
                        child: Container(
                          child: const Text(
                            'Search List Empty',
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                        )),
                  ),
                );
        },
      ),
    );
  }
   
}