import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/Medicine/MedicineList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class AddMedicineold extends StatefulWidget {
  const AddMedicineold({super.key});

  @override
  State<AddMedicineold> createState() => _AddMedicineoldState();
}

class _AddMedicineoldState extends State<AddMedicineold> {
   final LocalStorage storage = new LocalStorage('doctor_store');
  TextEditingController medicine_Controller=TextEditingController();
TextEditingController Alternative_Controller=TextEditingController();
TextEditingController pattrn_Controller=TextEditingController();
TextEditingController expdatecontroller = TextEditingController();
  var selected_item;
var item =[
 '0-0-0-1',
 '0-0-1-0',
 '0-0-1-1',
 '0-1-0-1',
 '0-1-1-0',
 '1-0-0-1',
 '1-0-1-0',
 '1-1-0-0',
 '0-1-1-1',
 '1-0-1-1',
 '1-1-0-1',
 '1-1-1-0',
 '1-1-1-1',
 '0-0-0-2',
 '0-0-2-0',
 '0-2-0-0',
 '2-0-0-0',
 '0-0-2-2',
 '0-2-0-2',
 '0-2-2-0',
 '2-0-0-2',
 '2-0-2-0',
 '2-2-0-0',
 '0-2-2-2',
 '2-0-2-2',
 '2-2-0-2',
 '2-2-2-0',
 '2-2-2-2',
];
var accesstoken;
var userResponse;
@override
  void initState(){
    init();
    
   
    super.initState();
    //  initilzeMethod();
  }
   init() async {
    // await storage.ready;
    userResponse = await storage.getItem('userResponse');
    accesstoken = await userResponse['access_token'];
    //subcategory = await storage.getItem('list');

   
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      
      canPop:false,
       onPopInvoked:(bool didpop) {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> MedicineList(),)
         );
         
        },
        child: Scaffold(
           appBar: AppBar(title: Text('Add Medicine',style: TextStyle(color: Colors.white),),
      backgroundColor:custom_color.appcolor,

      leading: IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MedicineList()));
      },
      icon:Icon(Icons.arrow_back,
      color: Colors.white,)
       ),
       
      ),
   body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: screenHeight*0.02,),
                   TextFormField(
                    controller: medicine_Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Medicine Name *"
                    ),
                  
                ),
                  
                  SizedBox(height: screenHeight*0.02,),
                 TextFormField(
                  controller: Alternative_Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Alternative Medicine *"
                    ),
                  
                ),

                  SizedBox(height: screenHeight*0.02,),
             
                 Padding(
                 padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                    //padding: const EdgeInsets.all(20),
                    child: Container(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.96,
                      
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0)
                          // border: OutlineInputBorder()
                          ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        
                        child: Center(
                          child: DropdownButtonFormField(
                          menuMaxHeight: 300,
                            decoration: InputDecoration.collapsed(hintText: ''),
                            isExpanded: true,
                            hint: Padding(
                           
                            padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
                              child: Text(
                                'Pattern Type',
                               
                              ),
                              
                            ),
                           
                            onChanged: (selected) {
                              selected_item=selected;
                              setState(() {
                               
                              });
                            },
                            items: item.map<DropdownMenuItem<String>>((item) {
                              return new DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 6, left: 8, right: 8),
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
                   SizedBox(height: screenHeight*0.02,),
                    Container(
                // width: screenWidth*0.49,
                child: TextField(
                   controller: expdatecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  //filled: true,
                  prefixIcon: Icon(Icons.calendar_today,color: custom_color.appcolor,),
                          
                  labelText: "Exp Date"
                ),
                          
                readOnly: true,
                onTap: (() {
                  _selectDate();
                }),
                
                ),
              ),
                
                  SizedBox(height: screenHeight*0.04,),
                 
      
              Container(width: screenWidth,
                child: ElevatedButton(
                  
                 style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                       
                      
                    ),
                    
                  )
                  
                ),
                  
                  
                  child: Text('Save',style: TextStyle(fontSize: 20,color: Colors.white),),
                  
                  onPressed: ()async{
                            if(medicine_Controller.text.isEmpty){
                              NigDocToast().showErrorToast('Please Enter Medicine Nmae');
                
                            }else if(Alternative_Controller.text.isEmpty){
                              NigDocToast().showErrorToast('Enter Alternattive Medicine');
                
                            
                          
                              
                            //  } else if(Alternative_Controller.text.isEmpty){
                            //   NigDocToast().showErrorToast('Enter Strip Price');
                          //  } else if(selected_item==null){
                          //     NigDocToast().showErrorToast('Select Pattern Type');
                            }else {
                              var data={
                                  "name":medicine_Controller.text.toString(),
                                  "aname":Alternative_Controller.text.toString(),
                                  "pattern":selected_item.toString(),
                                  "exp_date":expdatecontroller.text.toString(),
                              };
                            var list = await PatientApi()
                                    .add_medicine( accesstoken, data);
                                if (list['message'] ==
                                    "Medicine Add successfully") {
                                  NigDocToast().showSuccessToast(
                                      'Medicine Add successfully');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MedicineList()));
                                } else {
                                  NigDocToast()
                                      .showErrorToast('Please TryAgain later');
                                }
                            }
                },
                 ),
              ),
            ],
          ),
        ),
      )),
        ) ,
      );
  }
  Future<void>_selectDate() async {
      DateTime? _picked =  await showDatePicker(
        context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980), 
      lastDate: DateTime(2050),
      );
      if(_picked != null){
       setState(() {
         expdatecontroller.text=_picked.toString().split(" ")[0];
       });
      }
    }
}