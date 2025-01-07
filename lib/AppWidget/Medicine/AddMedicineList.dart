
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/Medicine/MedicineList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;


class Add_MedicineList extends StatefulWidget {
  const Add_MedicineList({super.key});

  @override
  State<Add_MedicineList> createState() => _Add_MedicineListState();
}


bool isloading=false;

var selected_item;
var item =[
 '0-0-0-1',
 '0-0-1-0',
 '0-1-0-1',
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
 '2-2-2-2'



];
var accesstoken;
var userResponse;
class _Add_MedicineListState extends State<Add_MedicineList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
TextEditingController medicine_Controller=TextEditingController();
TextEditingController Alternative_Controller=TextEditingController();
TextEditingController pattrn_Controller=TextEditingController();
TextEditingController stripcontroller = TextEditingController();
TextEditingController qtycontroller = TextEditingController();
TextEditingController totalqtycontroller = TextEditingController();
TextEditingController eachstrippricecontroller = TextEditingController();
TextEditingController eachqtypricecontroller = TextEditingController();
TextEditingController totalpricecontroller = TextEditingController();
TextEditingController expdatecontroller = TextEditingController();
final FocusNode medicineFocusNode = FocusNode();
final FocusNode alternativeForcusNode = FocusNode();
final FocusNode stripFocusNode = FocusNode();
final FocusNode qtyFocusNode = FocusNode();
final FocusNode eachstripFocusNode = FocusNode();

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
  void dispose(){
    medicineFocusNode.dispose();
    alternativeForcusNode.dispose();
    stripFocusNode.dispose();
    qtyFocusNode.dispose();
    eachstripFocusNode.dispose();
  }
  @override
  Widget build(BuildContext context) {

     double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return  PopScope(
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


      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              
              children: [
                SizedBox(height: screenHeight*0.02,),
                   TextFormField(
                    controller: medicine_Controller,
                    focusNode: medicineFocusNode,
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
                  focusNode: alternativeForcusNode,
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
                   SizedBox(height: screenHeight*0.02,),
                   TextFormField(
                    controller: stripcontroller,
                    focusNode: stripFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Strip *"
                      
                    ),
                    onChanged: (data)async{
                      await amtCalculate();
                    },
                  
                ),
                  
                  SizedBox(height: screenHeight*0.02,),
                   
                   TextFormField(
                    controller: qtycontroller,
                    focusNode: qtyFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Qty *"
                    ),
                   onChanged: (data)async{
                      await amtCalculate();
                    },
                ),
                  
                  SizedBox(height: screenHeight*0.02,),
                   
                   TextFormField(
                    controller: totalqtycontroller,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Total Qty *"
                    ),
                  
                ),
                   SizedBox(height: screenHeight*0.02,),
                   TextFormField(
                    keyboardType: TextInputType.number,
                    controller: eachstrippricecontroller,
                    focusNode: eachstripFocusNode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Each Strip Price *"
                    ),
                      onChanged: (data)async{
                      await stripcalculation();
                    },
                  
                ),
                   SizedBox(height: screenHeight*0.02,),
                   TextFormField(
                    keyboardType: TextInputType.none,
                    controller: eachqtypricecontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Each Qty Price *"
                    ),
                  
                ),
                   SizedBox(height: screenHeight*0.02,),
                   TextFormField(
                    keyboardType: TextInputType.none,
                    controller: totalpricecontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Total Price *"
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
      
              Container(
                width: screenWidth*0.3,
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
                              medicineFocusNode.requestFocus();
                              NigDocToast().showErrorToast('Please Enter Medicine Nmae');
                
                            }else if(Alternative_Controller.text.isEmpty){
                              alternativeForcusNode.requestFocus();
                              NigDocToast().showErrorToast('Enter Alternattive Medicine');
                
                            }
                            else if(stripcontroller.text.isEmpty){
                              stripFocusNode.requestFocus();
                              NigDocToast().showErrorToast('Enter Strip');

                              }else if(qtycontroller.text.isEmpty){
                              qtyFocusNode.requestFocus();
                              NigDocToast().showErrorToast('Enter your Qty');
                              
                             } else if(eachstrippricecontroller.text.isEmpty){
                              eachstripFocusNode.requestFocus();
                              NigDocToast().showErrorToast('Enter Strip Price');
                          //  } else if(selected_item==null){
                          //     NigDocToast().showErrorToast('Select Pattern Type');
                            }else {
                              var data={
                                  "name":medicine_Controller.text.toString(),
                                  "aname":Alternative_Controller.text.toString(),
                                  "pattern":selected_item.toString(),
                                  "strip_price":eachstrippricecontroller.text.toString(),
                                  "qty_price":eachqtypricecontroller.text.toString(),
                                  "total_price":totalpricecontroller.text.toString(),
                                  "exp_date":expdatecontroller.text.toString(),
                                  "strip":stripcontroller.text.toString(),
                                  "qty":qtycontroller.text.toString(),
                                  "totalqty":totalqtycontroller.text.toString(),
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
                
                  
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(left: 50),
                //       child: ElevatedButton( 
                //       style: ElevatedButton.styleFrom(
                //       backgroundColor:custom_color.appcolor,
                //         ),
                //         child:Text('Save',
                //         style: TextStyle(fontSize: 20,color: Colors.white),),
                //         onPressed: (() {
                //           if(medicine_Controller.text.isEmpty){
                //             NigDocToast().showErrorToast('Please Enter Medicine Nmae');

                //           }else if(Alternative_Controller.text.isEmpty){
                //             NigDocToast().showErrorToast('Enter The Alter Medicine');

                //           }
                //           else if(selected_item==null){
                //             NigDocToast().showErrorToast('Select Pattern Type');
                //           }else{
                //             var data={
                //                 "medicin":medicine_Controller.text.toString(),
                //                 "altern":Alternative_Controller.text.toString(),
                //                 "pattern Type":selected_item.toString(),
                //             };
                //            Helper().isvalidElement(data);
                //              print(data);
                //           }
                          
                //         }),),
                //     ),

                //       Padding(
                //         padding: const EdgeInsets.only(top: 0,left: 70,right:10),
                //         child: ElevatedButton( 
                          
                //         style: ElevatedButton.styleFrom(
                //         backgroundColor:custom_color.appcolor,
                //         ),
                //         child:Text('Cancel',
                //         style: TextStyle(fontSize: 20,color: Colors.white),),
                //         onPressed: (() {
                //         Navigator.push(context, MaterialPageRoute(builder: (context)=>MedicineList()));
                //         }),),
                //       ),
                //   ],
                // )
                ],
              
                            
            ),
          ),
        ),
      ),
    ),
    );
  }
  amtCalculate(){
        var data  = (double.parse(stripcontroller.text.toString()) * double.parse(qtycontroller.text.toString()));
        print(data);
        totalqtycontroller.text = data.toString();
  }
  stripcalculation(){
     var data  = (double.parse(eachstrippricecontroller.text.toString()) * double.parse(qtycontroller.text.toString()));
        print(data);
         totalpricecontroller.text = data.toString();
          var strip  = (double.parse(eachstrippricecontroller.text.toString()) / double.parse(stripcontroller.text.toString()));
        print(strip);
         eachqtypricecontroller.text = strip.toString();

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