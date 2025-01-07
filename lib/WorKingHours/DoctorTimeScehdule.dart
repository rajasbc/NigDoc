import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/WorKingHours/WorkingHours.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class Doctortimescehdule extends StatefulWidget {
  final selected_working;
  const Doctortimescehdule({super.key, required this.selected_working});

  @override
  State<Doctortimescehdule> createState() => _DoctortimescehduleState();
}

class _DoctortimescehduleState extends State<Doctortimescehdule> {
 
   List<TextEditingController> fromTimeControllers = [];
  List<TextEditingController> toTimeControllers = [];

   final FocusNode fromtimeFocusNode = FocusNode();
   final FocusNode totimeFocusNode = FocusNode();
  
   void dispose(){
    fromtimeFocusNode.dispose();
    
  }
  TimeOfDay fromTime = TimeOfDay.now();
  TimeOfDay toTime = TimeOfDay.now();
  var accesstoken;
  bool isLoading = false;
   var userResponse;
    bool Test =true;
    var schedule_list;
    var item;
    var list = 0;
    List doctorSchedule=[];
   void initState() {
    int1();
     
   
    super.initState();
  }
  int1()async{
    accesstoken = storage.getItem('userResponse')['access_token'];
    userResponse = storage.getItem('userResponse');
    item = widget.selected_working;
    // accesstoken=userResponse['access_token'];

    await getDoctorScheduleList();


     fromTimeControllers =
        List.generate(schedule_list.length, (index) => TextEditingController());
    toTimeControllers =
        List.generate(schedule_list.length, (index) => TextEditingController());
  
  }
    getDoctorScheduleList()async{
  
    var items = {
      "day":item['day'].toString(),
    };

      var List = await PatientApi().getDoctorScheduleList(accesstoken, items);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        //  MediAndLabNameList = List['list'];
        schedule_list = List['list'];
      
        isLoading=true;
       
      });
     
    }
    

  }
  void saveSchedule() {
    for (int i = 0; i < schedule_list.length; i++) {
      String fromTime = fromTimeControllers[i].text;
      String toTime = toTimeControllers[i].text;

      if (fromTime.isEmpty) {
        showErrorToast('Please select From Time for Doctor ${schedule_list[i]['name']}');
        return;
      }

      if (toTime.isEmpty) {
        showErrorToast('Please select To Time for Doctor ${schedule_list[i]['name']}');
        return;
      }

      DateTime? fromDateTime = _parseTime(fromTime);
      DateTime? toDateTime = _parseTime(toTime);

      if (fromDateTime == null || toDateTime == null) {
        showErrorToast('Invalid time format for Doctor ${schedule_list[i]['name']}');
        return;
      }

      if (toDateTime.isBefore(fromDateTime) || toDateTime == fromDateTime) {
        showErrorToast('To Time must be later than From Time for Doctor ${schedule_list[i]['name']}');
        return;
      }
    }

    // Save logic
    print("Schedules Saved");
    for (int i = 0; i < schedule_list.length; i++) {
      print({
        "name": schedule_list[i]['name'],
        "from": fromTimeControllers[i].text,
        "to": toTimeControllers[i].text
      });
    }

    showSuccessToast("Schedules Saved Successfully!");
  }

  DateTime? _parseTime(String time) {
    try {
      return DateTime.parse('1970-01-01T$time:00');
    } catch (e) {
      return null;
    }
  }

  void showErrorToast(String message) {
    // Add your toast logic here
    print("Error: $message");
  }

  void showSuccessToast(String message) {
    // Add your success toast logic here
    print("Success: $message");
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidht = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Workinghours()));
      },
      child: Scaffold(
         appBar: AppBar(
          title: Text(
            'Doctor Time Scehdule',
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
        body: SafeArea(
          child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Container(
                                // color: Colors.white,
                                height: screenHeight * 0.7596,
                                child: Helper().isvalidElement(schedule_list) &&
                                        schedule_list.length > 0
                                    ? 
                                    ListView.builder(
                                        itemCount: schedule_list.length,
                                        // itemCount:1,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var data = schedule_list[index];
                            
                                          // var paid = data['grand_total'] - data['balance'];
                                          list=index+1;
                                          return Center(
                                            child: Container(
                                              color: index % 2 == 0
                                                  ? Color.fromARGB(
                                                      255, 238, 242, 250)
                                                  : Colors.white,
                                              width: screenWidht,
                                           
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('($list) '),
                                                      Container(
                                                        // color: Colors.amber,
                                                         width: screenWidht*0.90,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(4.0),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                // width: screenwidht * 0.47,
                                                                child: Row(
                                                                  children: [
                                                                     Text(
                                                                      'Dr Name : ',
                                                                    //  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                    ),
                                                                    Text(
                                                                        '${data['name'].toString()}')
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(height: screenHeight*0.01,),
                                                              TextFormField(
                                                                controller: fromTimeControllers[index],
                                                                readOnly: true,
                                                                decoration: InputDecoration(
                                                                  labelText: 'From Time *',
                                                                  suffixIcon: const Icon(Icons.access_time),
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(5.0),
                                                                  ),
                                                                ),
                                                                onTap: () async {
                                                                  TimeOfDay? picked = await showTimePicker(
                                                                    context: context,
                                                                    initialTime: TimeOfDay.now(),
                                                                  );
                                                                  if (picked != null) {
                                                                    fromTimeControllers[index].text =
                                                                        picked.format(context);
                                                                  }
                                                                },
                                                              ),
                                                             SizedBox(height: screenHeight*0.01,),
                                                               TextFormField(
                                                                 controller: toTimeControllers[index],
                                                                 readOnly: true,
                                                                 decoration: InputDecoration(
                                                                   labelText: 'To Time *',
                                                                   suffixIcon: const Icon(Icons.access_time),
                                                                   border: OutlineInputBorder(
                                                                     borderRadius: BorderRadius.circular(5.0),
                                                                   ),
                                                                 ),
                                                                 onTap: () async {
                                                                   TimeOfDay? picked = await showTimePicker(
                                                                     context: context,
                                                                     initialTime: TimeOfDay.now(),
                                                                   );
                                                                   if (picked != null) {
                                                                     toTimeControllers[index].text =
                                                                         picked.format(context);
                                                                   }
                                                                 },
                                                               ),
                                                            
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      // Icon(Icons.menu)
                                                      
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            
                                          );
                                        })
                                    : Center(
                                        child: Text('No Data Found'),
                                      ),
                                      
                                // :
                                // Text('Nodata'),
                                ),
                                 ElevatedButton(
                      style: ButtonStyle(
                         backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                         shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          
                                        )
                                        
                                      ),
                      onPressed: ()async{
                        for (int i = 0; i < schedule_list.length; i++) {
                              doctorSchedule.add({
                                "doc_id": schedule_list[i]['doc_id'],
                                "doc_from": fromTimeControllers[i].text,
                                "doc_to": toTimeControllers[i].text,
                                "current_day": item['day']
                              });
                            }

                           
                              var finalData = {"doctor_id": doctorSchedule};
                              var list = await PatientApi()
                                     .AddDoctorTimeSchedule(accesstoken, finalData);
                                 if (list['message'] ==
                                     "Doctor schedule added successfully") {
                                   NigDocToast().showSuccessToast(
                                       'Doctor schedule added successfully');
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) => Workinghours()));
                                 } else {
                                   NigDocToast()
                                       .showErrorToast('Please TryAgain later');
                                 }
                              print(finalData);

                        

                    }, child: Text('Save',
                    style: TextStyle(fontSize: 20,color: Colors.white),),)
                          ],
                        ),
                      ),
                      
                    ),

                   
                  ],
                ),
              ),
      ))
      );
  }
  
}