import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/Api.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/WorKingHours/DoctorLeaveList.dart';
import 'package:nigdoc/WorKingHours/WorkingHours.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class AddDoctorleave extends StatefulWidget {
  const AddDoctorleave({super.key});

  @override
  State<AddDoctorleave> createState() => _AddDoctorleaveState();
}

class _AddDoctorleaveState extends State<AddDoctorleave> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  final DateFormate = "dd-MM-yyyy";
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController doctorcontroller = TextEditingController();
  TextEditingController leavedayscontroller = TextEditingController();
  String selected_type = 'Leave';
var type =[
  'Leave',
  'Holiday',
  
];

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
        lastDate: DateTime(DateTime.now().year+1, DateTime.now().month, DateTime.now().day));


    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    if (checkfield == "From Date") {
      // var formatter = new DateFormat('dd-MM-yyyy');
      fromController.text =
          DateFormat(DateFormate).format(pickedDate!);

      // getcancelledlist();
    } else {
      fromController.text = DateFormat(DateFormate).format(pickedDate!);
     
      // getcancelledlist();
    }
  }
  Future<void> selectToDate(BuildContext context, data) async {
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
        lastDate: DateTime(DateTime.now().year+1, DateTime.now().month, DateTime.now().day));


    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    if (checkfield == "To Date") {
      // var formatter = new DateFormat('dd-MM-yyyy');
      toController.text =
          DateFormat(DateFormate).format(pickedDate!);
       calculateDaysLeave();
      // getcancelledlist();
    } else {
      toController.text = DateFormat(DateFormate).format(pickedDate!);
     calculateDaysLeave();
      // getcancelledlist();
    }
  }
    List DoctorList = [];
    var selecteddoctor;
    List Doctor_List =[];
    bool Test =true;
    bool  isLoading = true;
    var accesstoken;
    var userResponse;
    void initState() {
    int1();
     
   
    super.initState();
  }
  int1()async{
    accesstoken = storage.getItem('userResponse')['access_token'];
    userResponse = storage.getItem('userResponse');
    // accesstoken=userResponse['access_token'];

    await getdoctorlist();
  
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
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidht = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Doctorleavelist()));
      },
      child: Scaffold(
         appBar: AppBar(
          title: Text(
            'Add Doctor Leave',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: custom_color.appcolor,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Doctorleavelist(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  children: [
                    Container(
                         height: screenHeight * 0.06,
                         //  width: screenWidht * 0.46,
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
                          selected_type, 
                          ),
                          ),
                                          
                         onChanged: (selectedgender) {
                              selected_type=selectedgender.toString();
                              setState(() {
                                              
                                });
                            },
                          items: type.map<DropdownMenuItem<String>>((item) {
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
                              // width: screenWidht * 0.45,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: '',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  labelText: 'From Date *',
                                  suffixIcon: Icon(
                                    Icons.date_range,
                                    color: custom_color.appcolor,
                                  ),
                                ),
                                controller: fromController,
                                readOnly: true,
                                onTap: () async {
                                  selectDate(context, 'From Date');
                                },
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
                                  labelText: 'To Date *',
                                  suffixIcon: Icon(
                                    Icons.date_range,
                                    color: custom_color.appcolor,
                                  ),
                                ),
                                controller: toController,
                                readOnly: true,
                                onTap: () async {
                                  selectToDate(context, 'To Date');
                                  
                                },
                              ),
                            ),
                            SizedBox(height: screenHeight*0.02,),
                            Container(
                              child: TextFormField(
                                readOnly: true,
                                controller: leavedayscontroller,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Leave Days *'
                                ),
                                
                              ),
                            ),
                             SizedBox(height: screenHeight*0.02,),
                            Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
            child: Helper().isvalidElement(selecteddoctor)
                ? RenderPatientdata(screenHeight, screenWidht)
                : renderPatientAutoComplete(screenHeight, screenWidht)
                // : renderTesttListWidget(screenHeight, screenWidth)
          ),
           SizedBox(height: screenHeight*0.02),
          Doctor_List.length>0?renderTesttListWidget(screenHeight, screenWidht):Container(),

          SizedBox(height: screenHeight*0.03),


          Container(
            child: isloading ?
            ElevatedButton(
                  style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                    )
                    
                  ),
                  onPressed: (){

                }, child: Text('Save',
                      style: TextStyle(fontSize: 20,color: Colors.white),))
                      
                      : ElevatedButton(
                        style: ButtonStyle(
                           backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                           shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                            
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            
                                          )
                                          
                                        ),
                        onPressed: ()async{
                          
                           this.setState(() {
                              isLoading = true;
                           });
                           
                          if(fromController.text.isEmpty){
                             NigDocToast().showErrorToast('Enter From Date');
                          } 
                         else if(toController.text.isEmpty){
                             NigDocToast().showErrorToast('Enter To Date');
                          }
                          else if( Doctor_List.length==0){
                           NigDocToast().showErrorToast('Please Select Doctor');
                         }
                          else{
                         var data = {
                          "doctor_list":Doctor_List,
                          "leave":selected_type,
                          "leave_from":fromController.text.toString(),
                          "leave_to":toController.text.toString(),
                          "leave_days":leavedayscontroller.text.toString(),
            
                         };
                                var list = await PatientApi()
                                       .AddDoctorLeave(accesstoken, data);
                                   if (list['message'] ==
                                       "Doctor Leave added successfully"){
                                     NigDocToast().showSuccessToast(
                                         'Doctor Leave added successfully');
                                     Navigator.push(
                                         context,
                                         MaterialPageRoute(
                                             builder: (context) => Doctorleavelist()));
                                   } else {
                                     NigDocToast()
                                         .showErrorToast('Please TryAgain later');
                                   }
                                
                          }
                          
            
                      }, child: Text('Save',
                      style: TextStyle(fontSize: 20,color: Colors.white),),),
          )
                ],
              ),
            ),
          ),
                  ],
                ),
                
              ),
            ),
          )),
      ));
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
              // color: Colors.white,
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
                            
                              }
    
            
          }, icon: Icon(Icons.close,),color: custom_color.error_color,),
                     
                                              )
                                                ])
                                            );
                                            }
                                    )
             
            ),
           
          ],
        ),
      ),
    );
  }
 
 calculateDaysLeave() {
  final dateFormat = DateFormat('MM-dd-yyyy'); 

  try {
    
    DateTime fromDate = dateFormat.parse(fromController.text.trim());
    DateTime toDate = dateFormat.parse(toController.text.trim());

    int differenceInDays = toDate.difference(fromDate).inDays + 1; 

    if (differenceInDays <= 0) {
      
      leavedayscontroller.text = "0";
    } else {
     
      leavedayscontroller.text = differenceInDays.toString();
    }
  } catch (e) {
  
  }
}

}