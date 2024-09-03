import 'package:flutter/material.dart';
import 'package:nigdoc/Api/url.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/TestList/TestList.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;



class Add_TestList extends StatefulWidget {
  const Add_TestList({super.key});

  @override
  State<Add_TestList> createState() => _Add_TestListState();
}

class _Add_TestListState extends State<Add_TestList> {
   TextEditingController testnamecontroller =TextEditingController();
   TextEditingController testamountcontroller = TextEditingController();
 //bool isloading=false;
 var accesstoken;
 void initState() {
    super.initState();
    accesstoken = storage.getItem('userResponse')['access_token'];
    // selectedPatient = storage.getItem('selectedcustomer');
   

    // getpatientlist();
    // getgrouplist();
  

   
  }
  @override
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height;
     double screenWidth = MediaQuery.of(context).size.width;
   return  PopScope(
       canPop:false,
       onPopInvoked:(bool didpop) {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> TestList(),)
         );
         
        },

        child: Scaffold(
          appBar: AppBar(
            backgroundColor: custom_color.appcolor,
            title: Text('Add New Test',style: TextStyle(color: Colors.white),
            
            ),
            leading:IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TestList()));
            }, icon: Icon(Icons.arrow_back,color: Colors.white,))
          ),

          body:  SafeArea(
            
            child: SingleChildScrollView(
              
              child: Column(
                       
              children: [
                SizedBox(height: screenHeight*0.01,),
                   Padding(padding:
                   EdgeInsets.all(8.0),
                   
                   child: TextFormField(
              controller: testnamecontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Test Name",
                    ),
                   ),
                    ),
              
                    SizedBox(height: screenHeight*0.01,),
              
                    Padding(padding: 
                    EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: testamountcontroller,
                       decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Test Amount',
                       ),
              
                    ),
                    
                    ),
           SizedBox(height: screenHeight*0.03,),

                    Row(
                      children: [
                         Padding(padding: EdgeInsets.only(left: 70),
                        
                        child: ElevatedButton( 
                           style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    
                            RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
       
      
                             ),
    
                             )
  
                             ),
                          child:Text('Cancel',style: TextStyle(color: Colors.white,fontSize: 20),),

                          onPressed: (() {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TestList()));
                          }),
                          
                          ),
                          
                          
                          ),

                        Padding(padding: EdgeInsets.only(left: 50),
                        child: ElevatedButton(
                           style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    
                            RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
       
      
                             ),
    
                             )
  
                             ),
                           child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 20),),
                           onPressed: (()async {
                             if(testnamecontroller.text.isEmpty){
                              NigDocToast().showErrorToast('Enter Your Test Name');

                             }else if(testamountcontroller.text.isEmpty){
                              NigDocToast().showErrorToast('Enter Test Amount ');

                             }else{
                              var data={
                               'test_name': testnamecontroller.text.toString(),
                               'test_amount': testamountcontroller.text.toString(),
                              };
                              
                                                 var list = await PatientApi()
                                          .AddTest( accesstoken, data);
                                      if (list['message'] ==
                                          "Test Add successfully") {
                                        NigDocToast().showSuccessToast(
                                            'Test Add successfully');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => TestList()));
                                       

                                      } else {
                                        NigDocToast()
                                            .showErrorToast('Please TryAgain later');
                                      }
                              // Helper().isvalidElement(data);
                              // print(data);
                             };
                             
                           }),
                           ),
                        ),

                       
                      ],
                    )
                         ],
                        
                       
              
                        ),
            )
            ),
        ),
   );

   
  }
  
  
}