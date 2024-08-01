import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nigdoc/AppWidget/InjectionList/InjectionList.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;



class Add_injection extends StatefulWidget {
  const Add_injection({super.key});

  @override
  State<Add_injection> createState() => _Add_injectionState();
}

class _Add_injectionState extends State<Add_injection> {
  TextEditingController injectionnamecontroller = TextEditingController();
  TextEditingController injectionamountcontroller = TextEditingController();
  TextEditingController injectionqtycontroller = TextEditingController();
  TextEditingController expdatecontroller = TextEditingController();
  var userResponse;
  var accesstoken;
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
    double ScreenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
   
   var add_Injection;

    return  PopScope(
       canPop:false,
       onPopInvoked:(bool didpop) {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> InjectionList(),)
         );
         
        },

    child: Scaffold(
      appBar: AppBar(title: Text('Add Injection',
      style: TextStyle(color: Colors.white),
      ),
      backgroundColor:custom_color.appcolor,
       leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InjectionList(),
                ));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      
      ),
   body: SafeArea(child: 
   Column(
    children: [
      SizedBox(height: ScreenHeight*0.02,),
      // Padding(
      //   padding: const EdgeInsets.all(10),
      //   child: TextFormField(
      //               decoration: InputDecoration(
      //                 focusedBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(
      //                     color: Colors.black,
      //                     width: 1.0,
      //                   ),
      //                 ),
      //                 enabledBorder: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(5.0),
      //                   borderSide: BorderSide(
      //                     color: Colors.black,
      //                     width: 1.0,
      //                   ),
      //                 ),
      //                 labelText: ' Injection Name *',
      //                 labelStyle:
      //                     TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      //                 border: OutlineInputBorder(),
      //                 fillColor: Colors.white,
      //                 filled: true,
      //               ),
      //               controller: add_injectioncontroller,
      //             ),
              
      // ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            children: [
              TextFormField(
                controller: injectionnamecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Injection Name *'
                ),
              ),
            
            SizedBox(height: ScreenHeight*0.02,),
               TextFormField(
                controller: injectionamountcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Injection Amount*'
                ),
              ),

                SizedBox(height: ScreenHeight*0.02,),
               TextFormField(
                controller: injectionqtycontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Injection Qty*'
                ),
              ),
                SizedBox(height: ScreenHeight*0.02,),
                  Container(
                // width: screenWidth*0.49,
                child: TextField(
                   controller: expdatecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  //filled: true,
                  prefixIcon: Icon(Icons.calendar_today,color: custom_color.appcolor,),
                          
                  labelText: "Exp Date *"
                ),
                          
                readOnly: true,
                onTap: (() {
                  _selectDate();
                }),
                
                ),
              ),
            ],
          ),
        ),
      ),
       SizedBox(
                  height: ScreenHeight * 0.02,
                ),

                Container(width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                           
                          
                        ),
                        
                      )
                      
                    ),
                     child: Text('Save',
                     style: TextStyle(fontSize: 20,color: Colors.white),),
                     onPressed: (() async {
                       if(injectionnamecontroller.text.isEmpty){
                        NigDocToast().showErrorToast(
                         "Please Enter Injection Name",
                       );
                       
                       }else if(injectionamountcontroller.text.isEmpty){
                          NigDocToast().showErrorToast(
                         "Please Enter Injection Amount ",
                       );
                       }
                       else if(injectionqtycontroller.text.isEmpty){
                          NigDocToast().showErrorToast(
                         "Please Enter Injection Qty ",
                       );
                       }else if(expdatecontroller.text.isEmpty){
                          NigDocToast().showErrorToast(
                         "Please Select Exp Date ",
                       );
                       }
                       
                       else{
                        var data = {
                          "injections_name":injectionnamecontroller.text.toString(),
                          "injection_amount":injectionamountcontroller.text.toString(),
                          "injection_qty":injectionqtycontroller.text.toString(),
                          "injection_exp_date":expdatecontroller.text.toString(),

                          // isloading:true,
                        };
                        var list = await PatientApi()
                                    .add_injection( accesstoken, data);
                                if (list['message'] ==
                                    "Injection Add successfully") {
                                  NigDocToast().showSuccessToast(
                                      'Injection Add successfully');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => InjectionList()));
                                } else {
                                  NigDocToast()
                                      .showErrorToast('Please TryAgain later');
                                }
                        // Helper().isvalidElement(data);
                        // print(data);
                       }
                      
                      
                       
                       
                     }),),
                  ),
                )
    ],
   )),
    
      
      
    ),
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