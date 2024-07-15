
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/Medicine/MedicineList.dart';
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
 'item1',
 'item2',
 'item3',
 'item4',
 'item5',
];

class _Add_MedicineListState extends State<Add_MedicineList> {
TextEditingController medicine_Controller=TextEditingController();
TextEditingController Alternative_Controller=TextEditingController();
TextEditingController pattrn_Controller=TextEditingController();

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
      appBar: AppBar(title: Text('Add Medicine List',style: TextStyle(color: Colors.white),),
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
                          
                            decoration: InputDecoration.collapsed(hintText: ''),
                            isExpanded: true,
                            hint: Padding(
                           
                            padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
                              child: Text(
                                'Pattern Type *',
                               
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
                  SizedBox(height: screenHeight*0.04,),
      
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
                  
                  
                  child: Text('Save',style: TextStyle(fontSize: 20,color: Colors.white),),
                  
                  onPressed: (){
                            if(medicine_Controller.text.isEmpty){
                              NigDocToast().showErrorToast('Please Enter Medicine Nmae');
                
                            }else if(Alternative_Controller.text.isEmpty){
                              NigDocToast().showErrorToast('Enter Alternattive Medicine');
                
                            }
                            else if(selected_item==null){
                              NigDocToast().showErrorToast('Select Pattern Type');
                            }else{
                              var data={
                                  "medicin":medicine_Controller.text.toString(),
                                  "altern":Alternative_Controller.text.toString(),
                                  "pattern Type":selected_item.toString(),
                              };
                             Helper().isvalidElement(data);
                               print(data);
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
}