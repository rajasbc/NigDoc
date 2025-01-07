import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/Api.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/WorKingHours/WorkingHours.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class Editworkinghours extends StatefulWidget {
  final selected_working;
  const Editworkinghours({super.key, required this.selected_working});

  @override
  State<Editworkinghours> createState() => _EditworkinghoursState();
}

class _EditworkinghoursState extends State<Editworkinghours> {
  TimeOfDay openTime = TimeOfDay.now();
  TimeOfDay closeTime = TimeOfDay.now();
  TimeOfDay lunchTimefrom = TimeOfDay.now();
  TimeOfDay lunchTimeto = TimeOfDay.now();
  String lunch = 'NO';
  String day = '';
  String holiday = 'NO';
  var selectedday;
  var breakSlot;
  var durationslot;
 bool? sundayischecked = false;
 bool? mondayischecked = false;
 bool? tuesdayischecked = false;
 bool? wednesdayischecked = false;
 bool? thursdayischecked = false;
 bool? fridayischecked = false;
 bool? saturdayischecked = false;

List Days=[];
  var min = [
    {'name': '30 Minutes', 'value': '30'},
    {'name': '1 Hour', 'value': '60'},
    {'name': '1 Hour 30 Minutes', 'value': '90'}
  ];

  var slotbreak = [
    {'name': '0 Minutes', 'value': '0'},
    {'name': '5 Minutes', 'value': '5'},
    {'name': '10 Minutes', 'value': '10'},
    {'name': '15 Minutes', 'value': '15'},
    {'name': '30 Minutes', 'value': '30'},
  ];
  var access_token;
  var userResponse;
  List daylist=[];

  TextEditingController opentimeController = TextEditingController();
  TextEditingController closetimeController = TextEditingController();
  TextEditingController lunchtimefromController = TextEditingController();
  TextEditingController lunchtimetoController = TextEditingController();
  TextEditingController appointmentslotController = TextEditingController();
  TextEditingController doctorcontroller = TextEditingController();

  TextEditingController sundaycontroller = TextEditingController();

  final FocusNode openingtimeFocusNode = FocusNode();
  
  var accesstoken;
  bool isLoading = false;
   var doctordropdown;
  List DoctorList = [];
  var selecteddoctor;
    List Doctor_List =[];
    List Doctor_List1=[];
    bool Test =true;
    var item;
   void initState() {
    int1();
     
   
    super.initState();
  }
  int1()async{
    accesstoken = storage.getItem('userResponse')['access_token'];
    userResponse = storage.getItem('userResponse');
   
    item = widget.selected_working;
    opentimeController.text=item['open_time'].toString();
    closetimeController.text=item['close_time'].toString();
    lunchtimefromController.text=item['lunch_time_from'].toString();
    lunchtimetoController.text=item['lunch_time_to'].toString();
    durationslot=item['slot_duration'].toString();
    if(item['day']=='Sunday'){
      sundayischecked=true;
    }
    if(item['day']=='Monday'){
      mondayischecked=true;
    }
    if(item['day']=='Tuesday'){
      tuesdayischecked=true;
    }
     if(item['day']=='Wednesday'){
      wednesdayischecked=true;
    }
     if(item['day']=='Thursday'){
      thursdayischecked=true;
    }
     if(item['day']=='Friday'){
      fridayischecked=true;
    }
     if(item['day']=='Saturday'){
      saturdayischecked=true;
    }
   await getdoctorlist();
    await getEditWorkingHoursDocList();
    
  
  }
  getdoctorlist() async {
   
   var doctorlist = await api().getdoctorlist(accesstoken);
    if (Helper().isvalidElement(doctorlist) &&
        Helper().isvalidElement(doctorlist['status']) &&
        doctorlist['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
      DoctorList=doctorlist['list'];
      });
    

      this.setState(() {
        isLoading = true;
      });
    }
  }
   getEditWorkingHoursDocList() async {
   var data = {
      "doctor_id": item['doctor_id'].toString(),
      
    };
    // this.setState(() {
    //   isLoading = true;
    // });
   var doctorlist = await PatientApi().getEditWorkingHoursDocList(accesstoken, data);
    if (Helper().isvalidElement(doctorlist) &&
        Helper().isvalidElement(doctorlist['status']) &&
        doctorlist['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      Doctor_List = doctorlist['list'];

      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isLoading = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Workinghours()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Working Hours',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: custom_color.appcolor,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Workinghours(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
               Expanded(
                    child: SingleChildScrollView(
                  child: Column(children: [
                    Hours(screenHeight, screenWidth)
                    // AppointmentList(screenHeight, screenWidth)
                  ]),
                ))
            ],
          ),
        ),
      ));
      
  }
  Hours(screenHeight, screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // color: Colors.white,
          child: Column(
        children: [
          // Container(
          //   // width: screenWidth * 0.95,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         'Opening Time :',
          //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //       ),
          //       Container(
          //         width: screenWidth * 0.50,
          //         child: TextFormField(
          //           decoration: InputDecoration(
          //             focusedBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(5.0),
          //               borderSide: BorderSide(
          //                 color: custom_color.appcolor,
          //                 width: 1.0,
          //               ),
          //             ),
          //             enabledBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(5.0),
          //               borderSide: BorderSide(
          //                color: custom_color.appcolor,
          //                 width: 1.0,
          //               ),
          //             ),
          //             // labelText: "Registration Number",
          //             border: const OutlineInputBorder(),

          //             fillColor: Colors.white,
          //             filled: true,
          //           ),
          //           controller: opentimeController,
          //           focusNode: openingtimeFocusNode,
          //           keyboardType: TextInputType.number,
          //           inputFormatters: [
          //             // LengthLimitingTextInputFormatter(10),
          //             //     FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
          //           ],
          //           readOnly: true,
          //           onTap: () {
          //             OpenTime(context);
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: screenHeight * 0.02,
          // ),
          // Container(
          //   // width: screenWidth * 0.95,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         'Closing Time :',
          //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //       ),
          //       Container(
          //         width: screenWidth * 0.50,
          //         child: TextFormField(
          //           decoration: InputDecoration(
          //             focusedBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(5.0),
          //               borderSide: BorderSide(
          //                 color: custom_color.appcolor,
          //                 width: 1.0,
          //               ),
          //             ),
          //             enabledBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(5.0),
          //               borderSide: BorderSide(
          //                 color: custom_color.appcolor,
          //                 width: 1.0,
          //               ),
          //             ),
          //             // labelText: "Registration Number",
          //             border: const OutlineInputBorder(),

          //             fillColor: Colors.white,
          //             filled: true,
          //           ),
          //           controller: closetimeController,
          //           keyboardType: TextInputType.number,
          //           inputFormatters: [
          //             // LengthLimitingTextInputFormatter(10),
          //             //     FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
          //           ],
          //           readOnly: true,
          //           onTap: () {
          //             CloseTime(context);
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          //   SizedBox(
          //   height: screenHeight * 0.02,
          // ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
            child: Helper().isvalidElement(selecteddoctor)
                ? RenderPatientdata(screenHeight, screenWidth)
                : renderPatientAutoComplete(screenHeight, screenWidth)
                // : renderTesttListWidget(screenHeight, screenWidth)
          ),
           SizedBox(height: screenHeight*0.02),
          Doctor_List.length>0?renderTesttListWidget(screenHeight, screenWidth):Container(),
          SizedBox(height: screenHeight*0.01),
                ],
              ),
            ),
          ),
           Container(
            // width: screenWidth * 0.95,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Opening Time :',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: screenWidth * 0.50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: custom_color.appcolor,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                         color: custom_color.appcolor,
                          width: 1.0,
                        ),
                      ),
                      // labelText: "Registration Number",
                      border: const OutlineInputBorder(),

                      fillColor: Colors.white,
                      filled: true,
                    ),
                    controller: opentimeController,
                    focusNode: openingtimeFocusNode,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      // LengthLimitingTextInputFormatter(10),
                      //     FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    ],
                    readOnly: true,
                    onTap: () {
                      OpenTime(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Container(
            // width: screenWidth * 0.95,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Closing Time :',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: screenWidth * 0.50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: custom_color.appcolor,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: custom_color.appcolor,
                          width: 1.0,
                        ),
                      ),
                      // labelText: "Registration Number",
                      border: const OutlineInputBorder(),

                      fillColor: Colors.white,
                      filled: true,
                    ),
                    controller: closetimeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      // LengthLimitingTextInputFormatter(10),
                      //     FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    ],
                    readOnly: true,
                    onTap: () {
                      CloseTime(context);
                    },
                  ),
                ),
              ],
            ),
          ),
            SizedBox(
            height: screenHeight * 0.02,
          ),
        
          Container(
           
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lunch Time From :',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: screenWidth * 0.50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: custom_color.appcolor,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: custom_color.appcolor,
                          width: 1.0,
                        ),
                      ),
                      // labelText: "Registration Number",
                      border: const OutlineInputBorder(),

                      fillColor: Colors.white,
                      filled: true,
                    ),
                    controller: lunchtimefromController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      // LengthLimitingTextInputFormatter(10),
                      //     FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    ],
                    readOnly: true,
                    onTap: () {
                      // LunchTimefrom(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Container(
            // width: screenWidth * 0.95,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lunch Time To :',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: screenWidth * 0.50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: custom_color.appcolor,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: custom_color.appcolor,
                          width: 1.0,
                        ),
                      ),
                      // labelText: "Registration Number",
                      border: const OutlineInputBorder(),

                      fillColor: Colors.white,
                      filled: true,
                    ),
                    controller: lunchtimetoController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      // LengthLimitingTextInputFormatter(10),
                      //     FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    ],
                    readOnly: true,
                    onTap: () {
                      // LunchTimeto(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Container(
            // width: screenWidth * 0.95,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Duration Per Slot :',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: screenWidth * 0.5,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: custom_color.appcolor,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: custom_color.appcolor,
                          width: 1.0,
                        ),
                      ),
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Select',
                    ),
                    onChanged: (item) {
                      if (item != null) {
                         durationslot=item['name'].toString();
                      }
                    },
                    items: min.map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items['name'].toString()),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
         
          Container(
            width: screenWidth,
            child: Text(
              'Day`s :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                                child: Checkbox(
                                    value: sundayischecked,
                                    activeColor:custom_color.appcolor,
                                    onChanged: (newbool) {
                                      setState(() {
                                        sundayischecked = newbool;
                                      });
                                    }
                                 
                                    ),
                              ),
                              Container(
                                child: Text('Sunday'),
                              )
            ],
          ),
         
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                                child: Checkbox(
                                    value: mondayischecked,
                                    activeColor:custom_color.appcolor,
                                    onChanged: (newbool) {
                                      setState(() {
                                        mondayischecked = newbool;
                                      });
                                    }
                                 
                                    
                                    ),
                              ),
                              Container(
                                child: Text('Monday'),
                              )
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                                child: Checkbox(
                                    value: tuesdayischecked,
                                    activeColor:custom_color.appcolor,
                                    onChanged: (newbool) {
                                      setState(() {
                                        tuesdayischecked = newbool;
                                      });
                                    }
                                   
                                    ),
                              ),
                              Container(
                                child: Text('Tuesday'),
                              )
            ],
          ),
          // Container(
         
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                                child: Checkbox(
                                    value: wednesdayischecked,
                                    activeColor:custom_color.appcolor,
                                    onChanged: (newbool) {
                                      setState(() {
                                        wednesdayischecked = newbool;
                                      });
                                    }
                                    
                                    ),
                              ),
                              Container(
                                child: Text('Wednesday'),
                              )
            ],
          ),
         
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                                child: Checkbox(
                                    value: thursdayischecked,
                                    activeColor:custom_color.appcolor,
                                    onChanged: (newbool) {
                                      setState(() {
                                        thursdayischecked = newbool;
                                      });
                                    }
                                  
                                    ),
                              ),
                              Container(
                                child: Text('Thursday'),
                              )
            ],
          ),
         
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                                child: Checkbox(
                                    value: fridayischecked,
                                    activeColor: custom_color.appcolor,
                                    onChanged: (newbool) {
                                      setState(() {
                                        fridayischecked = newbool;
                                      });
                                    }
                                   
                                    ),
                              ),
                              Container(
                                child: Text('Friday'),
                              )
            ],
          ),
         
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                                child: Checkbox(
                                    value: saturdayischecked,
                                    activeColor: custom_color.appcolor,
                                    onChanged: (newbool) {
                                      setState(() {
                                        saturdayischecked = newbool;
                                      });
                                    }
                                  
                                    ),
                              ),
                              Container(
                                child: Text('Saturday'),
                              )
            ],
          ),

          SizedBox(height: 20),
          Container(
              decoration: BoxDecoration(
                  color: custom_color.appcolor,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              width: screenWidth * 0.30,
              // height: screenHeight * 0.06,
              child: TextButton(
                  onPressed: () async {
                    
                      daylist=[];
                       if(sundayischecked ==true){
                        var name={'days':'Sunday'};
                              daylist.add(name);   

                       }
                       
                        if(mondayischecked==true){
                         var name={'days':'Monday'};
                              daylist.add(name);   

                       }
                        if(tuesdayischecked==true){
                         var name={'days':'Tuesday'};
                              daylist.add(name);   

                       }
                        if(wednesdayischecked==true){
                         var name={'days':'Wednesday'};
                              daylist.add(name);   

                       }
                        if(thursdayischecked==true){
                         var name={'days':'Thursday'};
                              daylist.add(name);   

                       }
                        if(fridayischecked==true){
                         var name={'days':'Friday'};
                              daylist.add(name);   

                       }
                       if(saturdayischecked==true){
                         var name={'days':'Saturday'};
                              daylist.add(name);   

                       }

                       if(opentimeController.text.isEmpty){
                        NigDocToast().showErrorToast('Please Select Opening Time');

                       }
                       else if(closetimeController.text.isEmpty){
                         NigDocToast().showErrorToast('Please Select Close Time');
                   
                       }
                       else if( Doctor_List.length==0){
                         NigDocToast().showErrorToast('Please Select Doctor');
                       }
                       
                       else if(lunchtimefromController.text.isEmpty){
                         NigDocToast().showErrorToast('Please Select lunch from Time');
                       }
                       else if(lunchtimetoController.text.isEmpty){
                         NigDocToast().showErrorToast('Please Select lunch to Time');
                       }
                       else if(durationslot==null){
                         NigDocToast().showErrorToast('Please Select Duration Slot Time');
                       }
                       else if(daylist.length==0){
                         NigDocToast().showErrorToast('Please Select a Days');
                       }
                       
                       else{
                   var data = {
                       
                        "doctor_list":Doctor_List,
                        "day_list":daylist,
                        'open_time':opentimeController.text.toString(),
                        'close_time':  closetimeController.text.toString(),
                        'lunch_time_from': lunchtimefromController.text.toString(),
                        "lunch_time_to":lunchtimetoController.text.toString(),
                        'slot_duration': durationslot.toString(),

                          
                      };
                      print(data);
                        var list = await PatientApi()
                                     .AddDocWorkingHours(accesstoken, data);
                                 if (list['message'] ==
                                     "successfully") {
                                   NigDocToast().showSuccessToast(
                                       'Edited successfully');
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) => Workinghours()));
                                 } else {
                                   NigDocToast()
                                       .showErrorToast('Please TryAgain later');
                                 }
                       }
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ))),
          SizedBox(height: 20),
        ],
      )),
    );
  }
  Future<void> OpenTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: openTime,
    );
    if (picked != null && picked != openTime)
      setState(() {
        openTime = picked;
        opentimeController.text = openTime.format(context);
      });
  }

  Future<void> CloseTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: closeTime,
    );
    if (picked != null && picked != closeTime)
      setState(() {
        closeTime = picked;
        closetimeController.text = closeTime.format(context);
      });
  }

  Future<void> LunchTimefrom(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: lunchTimefrom,
    );
    if (picked != null && picked != lunchTimefrom)
      setState(() {
        lunchTimefrom = picked;
        lunchtimefromController.text = lunchTimefrom.format(context);
      });
  }

  Future<void> LunchTimeto(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: lunchTimeto,
    );
    if (picked != null && picked != lunchTimeto)
      setState(() {
        lunchTimeto = picked;
        lunchtimetoController.text = lunchTimeto.format(context);
      });
  }
  String convertTo24HourFormat(String time12Hour) {
  // Split the time string into its components
  final parts = time12Hour.split(' ');
  final timePart = parts[0];
  final periodPart = parts[1];

  // Split the time part into hours and minutes
  final timeParts = timePart.split(':');
  int hour = int.parse(timeParts[0]);
  final minute = timeParts[1];

  // Convert the hour based on AM/PM
  if (periodPart == 'PM' && hour != 12) {
    hour += 12;
  } else if (periodPart == 'AM' && hour == 12) {
    hour = 0;
  }

  // Return the time in 24-hour format
  return '${hour.toString().padLeft(2, '0')}:$minute';
}

String convertTo24HourFormatWithSeconds(String time12Hour) {
  // Split the time string into its components
  final parts = time12Hour.split(' ');
  final timePart = parts[0];
  final periodPart = parts[1];

  // Split the time part into hours and minutes
  final timeParts = timePart.split(':');
  int hour = int.parse(timeParts[0]);
  final minute = timeParts[1];

  // Convert the hour based on AM/PM
  if (periodPart == 'PM' && hour != 12) {
    hour += 12;
  } else if (periodPart == 'AM' && hour == 12) {
    hour = 0;
  }

  // Return the time in 24-hour format with seconds
  return '${hour.toString().padLeft(2, '0')}:$minute:00';
}

String formatDuration(Duration duration) {
  // Extract hours, minutes, and seconds
  int hours = duration.inHours.abs();
  int minutes = duration.inMinutes.remainder(60).abs();
  int seconds = duration.inSeconds.remainder(60).abs();

  // Check if the duration is negative
  String sign = duration.isNegative ? "-" : "";

  // Return the formatted string
  return '$sign${hours.toString().padLeft(2, '0')}:'
         '${minutes.toString().padLeft(2, '0')}:'
         '${seconds.toString().padLeft(2, '0')}';
}
RenderPatientdata(screenHeight, screenWidth) {
    return Card(
        elevation: 20,
        child: Container(
          width: screenWidth * 0.95,
          child: ListTile(
            trailing: IconButton(onPressed: (){
              if(Doctor_List.contains(selecteddoctor)){
                                print('exists');
                                NigDocToast().showErrorToast('Already Added');
                                setState(() {
                                    selecteddoctor = null;
                                });
                               
                                }else{
                                  Doctor_List.add(selecteddoctor);
                                  setState(() {
                                    Test = false;
                                    selecteddoctor = null;
                                  });
                                }

              
            }, icon: Icon(Icons.send)),
            
            title: Text('${selecteddoctor['name'].toString().toUpperCase()}',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        )
        
        );
  }

  renderPatientAutoComplete(screenHeight, screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Autocomplete<List>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isNotEmpty) {
            var matches = [];
            setState(() {});
            matches.addAll(DoctorList);
            matches.retainWhere((s) {
              return s['name']
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
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
              color: Colors.white,
              border: Border.all(
                color: custom_color.appcolor,
                width: 1.0,
              ),
            ),
            child: Center(
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: '  Doctor'),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onChanged: (text) {
                    doctorcontroller.text = text;
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

                            return ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                      selecteddoctor= option;
                                  });
                              
                                // // select_test = option;
                                
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
                                 
                                  child: Row(
                                    
                                    children: [
                                      SizedBox(
                                        
                                        width: screenWidth * 0.5,
                                        child: Text(
                                            '${options.toList()[0][index]['name'].toString().toUpperCase()} ',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                      ),
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
  renderTesttListWidget(screenHeight, screenWidth){
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: custom_color.appcolor),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      
      width: screenWidth,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // color: Colors.green,
               width: screenWidth*0.90,
                                    child: ListView.builder(
                                       shrinkWrap: true,
                                        itemCount: Doctor_List.length,
                                        physics:
                                            NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context,
                                            int index) {
                                          var data = Doctor_List[index];
                                            return Container(
                                                child: Column(children: [
                                              ListTile(
                                                title: Text("${data["name"].toString()}"),
                                               trailing: IconButton(onPressed: (){
            if(Doctor_List.contains(data)){
               Doctor_List.remove(data);
               setState(() {
                   print('exists');
    
               });
                              print('exists');
    
                              }else{
                                // Group_TestList.add(selectedTest);
                                // setState(() {
                                //   Test = false;
                                //   selectedTest = null;
                                // });
                              }
    
            
          }, icon: Icon(Icons.close,),color: custom_color.error_color,),
                      //                         title:  Text(
                      //   Helper().isvalidElement(data)
                      //       ? "${data["test_name"].toString()}"
                      //       : '',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                                              )
                                                ])
                                            );
                                            }
                                    )
              // child: Row(
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           Helper().isvalidElement(Group_TestList)
              //               ? "${Group_TestList[0]['test_name'].toString()}"
              //               : '',
              //           style: TextStyle(fontWeight: FontWeight.bold),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
            ),
            // Container(
            //   color: Colors.red,
            //    width: screenWidth*0.30,
            //     child: IconButton(
            //   onPressed: () {
            //     // storage.setItem('selectedPatient', null);
            //     // this.setState(() {
            //     //   // selectedPatient = null;
            //     //   // clearProduct();
            //     //   // ProductshowAutoComplete = true;
            //     // });
            //   },
            //   icon: Icon(
            //     Icons.close,
            //   ),
            //   color: CustomColors.error_color,
            // ))
          ],
        ),
      ),
    );
  }
}