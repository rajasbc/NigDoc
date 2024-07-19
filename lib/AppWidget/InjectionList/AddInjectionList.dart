import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nigdoc/AppWidget/InjectionList/InjectionList.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineList.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;



class Add_injection extends StatefulWidget {
  const Add_injection({super.key});

  @override
  State<Add_injection> createState() => _Add_injectionState();
}

class _Add_injectionState extends State<Add_injection> {
  TextEditingController add_injectioncontroller=TextEditingController();
 
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
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: add_injectioncontroller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Injection Name *'
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
                     onPressed: (() {
                       if(add_injectioncontroller.text.isEmpty){
                       Fluttertoast.showToast(
                         msg:"Please Enter Injection Name",
                       );
                       
                       }else{
                        var data={
                          "addInjection":add_injectioncontroller.text.toString(),
                          isloading:true,
                        };
                        Helper().isvalidElement(data);
                        print(data);
                       }
                      
                      
                       
                       
                     }),),
                  ),
                )
    ],
   )),
    
      
      
    ),
    );
  }
}