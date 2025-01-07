import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/Admission/Admission.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/Api.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class Patientadmission extends StatefulWidget {
  const Patientadmission({super.key});

  @override
  State<Patientadmission> createState() => _PatientadmissionState();
}

class _PatientadmissionState extends State<Patientadmission> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  final DateFormate = "dd-MM-yyyy";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController admissiondateController = TextEditingController();
  TextEditingController bednocontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();
   final FocusNode nameFocusNode = FocusNode();
    void dispose(){
    nameFocusNode.dispose();
    
  }
  String selected_title = 'Mr';
var title =[
     'Mr',
     'Mrs',
     'Ms',
     'Master',
     'Miss',
     'Smt',
     'Dr',
     'Selvi',
     'B/O',
     'Baby or Just Born(B/O)',
     'Baby'

];
bool isLoading = false;
var warddropdown;
List ward_List =[];
var beddropdown;
var bedcategoryList = [];
var doctordropdown;
List DoctorList = [];
List floorList =[];
var floordropdown;
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
        firstDate: DateTime(DateTime.now().year-1, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));


    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    if (checkfield == "Admissiom Date") {
      // var formatter = new DateFormat('dd-MM-yyyy');
      admissiondateController.text =
          DateFormat(DateFormate).format(pickedDate!);

      // getcancelledlist();
    } else {
      admissiondateController.text = DateFormat(DateFormate).format(pickedDate!);
     
      // getcancelledlist();
    }
  }
  var accesstoken;
  var userResponse;
   void initState() {
    int();
     
   
    super.initState();
  }
  int()async{
    accesstoken = storage.getItem('userResponse')['access_token'];
    userResponse = storage.getItem('userResponse');
    // accesstoken=userResponse['access_token'];
    
  await getdoctorlist();
  await getFloorList();
  }
   getdoctorlist() async {
   
   var doctorlist = await api().getdoctorlist(accesstoken);
    if (Helper().isvalidElement(doctorlist) &&
        Helper().isvalidElement(doctorlist['status']) &&
        doctorlist['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      DoctorList=doctorlist['list'];
    

      this.setState(() {
        isLoading = true;
      });
    }
  }
   getFloorList() async {
    var List = await PatientApi().getDocFloor(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        floorList = List['list'];
        isLoading = true;
        // filterItems(searchText.text);
      });
    }
  }
   getWardListRoom()async{
    // warddropdown.isEmpty();
    var data = {
      "floor_id":floordropdown.toString(),
    };

      var List = await PatientApi().getWardListRoom(accesstoken, data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        //  MediAndLabNameList = List['list'];
        ward_List = List['list'];
      
        isLoading=true;
       
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Admission()));
      },
      child: Scaffold(
         appBar: AppBar(
          title: Text('Patient Admission',style: TextStyle(color: Colors.white),),
           backgroundColor:custom_color.appcolor,
          leading: IconButton(onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Admission(),)
         );
          }, icon: Icon(Icons.arrow_back,
          color: Colors.white,),),
        ),
        body: SafeArea(
          
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  children: [
                     Container(
                       height: screenHeight * 0.07,
                       width: screenWidht * 0.96,
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
                            
                             onChanged: (selectedpatient) {
                               selected_title=selectedpatient.toString();
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
                     SizedBox(height: screenHeight*0.02,),
                   Container(
                  child: TextFormField(
                    focusNode: nameFocusNode,
                    controller: namecontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name *'
                    ),
                  ),
                ),
                 SizedBox(height: screenHeight*0.02,),
                     Container(
                              // width: screenWidht * 0.45,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: '',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  labelText: 'Admissiom Date',
                                  suffixIcon: Icon(
                                    Icons.date_range,
                                    color: custom_color.appcolor,
                                  ),
                                ),
                                controller: admissiondateController,
                                readOnly: true,
                                onTap: () async {
                                  selectDate(context, 'Admissiom Date');
                                },
                              ),
                            ),
                             SizedBox(height: screenHeight*0.02,),
                              SizedBox(
            width: screenWidht * 0.95,
            child: DropdownButtonFormField(
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
                  'Select Floor',
                ),
                // value:patternDropdownvalue,
                onChanged: (item) async {
                  floordropdown = item.toString();
                  // wardList.clear();
                  // warddropdown.clear();
              
                 
                 setState(() {
                   ward_List = [];
                 });
                 await getWardListRoom();
                },
                items: floorList
                    .map(
                        (value) => DropdownMenuItem<String>(
                              value: value["id"].toString(),
                              child: Text(value["floor_name"].toString()),
                            )).toList()

                )),
                  SizedBox(height: screenHeight*0.02,),
                  SizedBox(
            width: screenWidht * 0.95,
            child: ward_List.length>0?DropdownButtonFormField(
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
                  'Select Ward',
                ),
                // value:patternDropdownvalue,
                onChanged: (item) async {

                  warddropdown = item;
                 var u=warddropdown.split('&%*');
                 setState(() {
                  //  roomControllers = [];
                 });
                //  await getbedist();
                },
                items: ward_List
                    .map(
                        (value) => DropdownMenuItem<String>(
                              value: value['id'].toString(),
                              child: Text(value["ward_name"].toString()),
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
                  'Select Ward',
                ),
                // value:patternDropdownvalue,
                onChanged: (item) async {

                  warddropdown = item;
                 var u=warddropdown.split('&%*');
                
                },
                items: []
                    .map(
                        (value) => DropdownMenuItem(
                              value: value['id'],
                              child: Text(value["ward_name"].toString()),
                            ))
                    .toList()

                )),
                 SizedBox(height: screenHeight*0.02,),
                              SizedBox(
            // width: screenWidht * 0.95,
            child: bedcategoryList.length>0?DropdownButtonFormField(
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
                  'Select Bed Category',
                ),
                // value:patternDropdownvalue,
                onChanged: (item) async {

                  beddropdown = item;
                
                 setState(() {
                 
                 });
                
                },
                items: bedcategoryList
                    .map(
                        (value) => DropdownMenuItem<String>(
                              value: value['id'].toString(),
                              child: Text(value["ward_name"].toString()),
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
                  'Select Bed Category',
                ),
                // value:patternDropdownvalue,
                onChanged: (item) async {

                  beddropdown = item;
                
                
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
                Container(
                  child: TextFormField(
                    controller: bednocontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Bed No'
                    ),
                  ),
                ),
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
                  'Admitting Doctor',
                ),
                // value:patternDropdownvalue,
                onChanged: (item) async {

                  doctordropdown = item;
                
                 setState(() {
                 
                 });
                
                },
                items: DoctorList
                    .map(
                        (value) => DropdownMenuItem<String>(
                              value: value['id'].toString(),
                              child: Text(value["name"].toString()),
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
                  'Admitting Doctor',
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
                Container(
                  child: TextFormField(
                    controller: amountcontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Amount'
                    ),
                  ),
                ),

                SizedBox(height: screenHeight*0.02,),
                 ElevatedButton( 
                     
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
                     
                      if(namecontroller.text.isEmpty){
                        nameFocusNode.requestFocus();
                          NigDocToast().showErrorToast('Please Enter Name');
                        }else{
                          // var items={
                              
                          //     "floor_id":floordropdown,
                          //     "ward_id":warddropdown,
                          //     "total_bed":bedValues,
                          //     "total_room":roomValues
                
                          // };
                          // var list = await PatientApi()
                          //            .AddDocRoom(accesstoken, items);
                          //        if (list['message'] ==
                          //            "Room Add successfully") {
                          //          NigDocToast().showSuccessToast(
                          //              'Room Add successfully');
                          //          Navigator.push(
                          //              context,
                          //              MaterialPageRoute(
                          //                  builder: (context) => Admission()));
                          //        } else {
                          //          NigDocToast()
                          //              .showErrorToast('Please TryAgain later');
                          //        }
                        
                        }
                   
                    }),),
                  ],
                ),
              ),
            ),
          )
        ),
      ));
  }
}