import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/Common/utils.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineList.dart';
import 'package:nigdoc/AppWidget/Medicine/MedicineList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/TreatmentWidget/treatment.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:nigdoc/main.dart';
//import 'package:dropdown_button2/dropdown_button2.dart';

class AddTretment extends StatefulWidget {
  const AddTretment({super.key});

  @override
  State<AddTretment> createState() => _AddTretmentState();
}

class _AddTretmentState extends State<AddTretment> {
  String medicinedropdow = "Select Medicine List *";
  String departmentdropdown = "Select Department *";
 var selected_values1;
  var title={
     'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',

  };
  
 
  var SelectedPharmacy;
 var selected_values2;
  var title2={
     'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',

  };
  List <dynamic> medicineList=[];
  var Depaartment;
  String? selectedValue;
  var accesstoken;
  bool isloading=false;

  TextEditingController Treatmentcontroller = TextEditingController();
  TextEditingController medicinecontroller = TextEditingController();
  TextEditingController Departmentcontroller = TextEditingController();
  TextEditingController Feescontroller = TextEditingController();
  final LocalStorage storage = new LocalStorage('doctor_store');
  
@override
  void initState() {
     userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];
    // getMediAndLabNameList();
    getMedicineList();

    // TODO: implement initState
    super.initState();
  }
    getMedicineList() async {
    var data = {
      "shop_id": Helper().isvalidElement(SelectedPharmacy)?  SelectedPharmacy.toString():'',
    };

    var List = await PatientApi().getmedicineList(accesstoken, data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        //  MediAndLabNameList = List['list'];
        medicineList = List['list'];
        // MedicineLoader=true;
        // valid=true;
        // isLoading=true;
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
 return  PopScope(
       canPop:false,
       onPopInvoked:(bool didpop) {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> TreatmentList(),)
         );
         
        },
    child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Treatment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: custom_color.appcolor,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TreatmentList(),
                ));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),

      body:SingleChildScrollView(
        child: SafeArea(
          child: Container(
            
            
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: screenHeight*0.02,),
                TextFormField(
                  
                  controller: Treatmentcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Treatment Name'
                  ),
                ),
               
                SizedBox(
                  height: screenHeight * 0.02,
                ),

                
                 Padding(
                   padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                      //padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: screenHeight *0.07,
                        width: screenWidth * 0.96,
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0)
                            // border: OutlineInputBorder()
                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: DropdownButtonFormField(
                            
                              decoration: InputDecoration.collapsed(hintText: ''),
                              isExpanded: true,
                              hint: Padding(
                              padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
                                child: Text(
                                  ' Medicine List*',
                                 
                                ),
                              ),
                             
                              onChanged: (newvalue) {
                              //  medicineList=newvalue.toString();
                              medicinedropdow=newvalue.toString();
                                setState(() {
                                 
                                });
                             
                              },
                              items:title .map<DropdownMenuItem<String>>((item) {
                                return new DropdownMenuItem(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 7, left: 8, right: 8),
                                    child: new Text(item,style: TextStyle(fontSize: 15),),
                                  ),
                                  value: item.toString(),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Padding(
                   padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                  
                  child: Container(
                     height: screenHeight * 0.07,
                      width: screenWidth * 0.96,

                   decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0)
                         
                          ),
                  
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      //padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                      child: Center(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration.collapsed(hintText: ''),
                            isExpanded: true,
                            hint: Padding(
                              
                              padding: const EdgeInsets.only(top: 0, left: 2, right: 0),
                              child: Text(
                                ' Department *',
                               
                              ),
                            ),
                        
                            onChanged: (newvalue) {
                              departmentdropdown=newvalue.toString();
                              setState(() {
                                
                              });
                            },
                            
                            items: title2.map<DropdownMenuItem<String>>((item) {
                              return new DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 7, left: 8, right: 8),
                                  child: new Text(item,style: TextStyle(fontSize: 15),),
                                ),
                                value: item.toString(),
                              );
                            }).toList(),
                      
                         ),
                      ),
                    ),
                  ),
                ),
          
                SizedBox(
                  height: screenHeight * 0.02,
                ),
          
                TextFormField(
                  keyboardType: TextInputType.number,
                     controller: Feescontroller,
                      autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Fees *'
                  ),
                ),
               
                SizedBox(
                  height: screenHeight * 0.02,
                ),
          
                Container(width: screenWidth,
                  child: ElevatedButton(
                       style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(custom_color.appcolor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                         
                        
                      ),
                      
                    )
                    
                  ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      onPressed: () {
                        if (Treatmentcontroller.text.isEmpty) {
                          
                          Fluttertoast.showToast(
                              msg: ' Enter Treatment Name',
                             
                              textColor: Colors.black,
                              fontSize: 15.0);
                        } else if (medicinedropdow == null ||
                            medicinedropdow == "Select Medicine List *") {
                          Fluttertoast.showToast(
                              msg: 'Please Select Medicine List', fontSize: 15.0);
                        } else if (departmentdropdown == null ||
                            departmentdropdown == "Select Department *") {
                          Fluttertoast.showToast(
                              msg: 'Please Select Department', fontSize: 15.0);
                        } else if (Feescontroller.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: " Enter Fees", fontSize: 15.0);
                         }else {
                          var data = {
                            "treatmentname": Treatmentcontroller.text.toString(),
                            "medicine": medicinedropdow.toString(),
                            "Department": departmentdropdown.toString(),
                            "consult_fees": Feescontroller.text.toString(),
                            "description": ""
                          };
                        Helper().isvalidElement(data);
                         
                          print(data);
                         
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),),
    );
  }
}
