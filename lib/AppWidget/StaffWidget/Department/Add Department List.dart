import 'package:flutter/material.dart';
//import 'package:nigdoc/AppWidget/StaffWidget/Department/Department%20List.dart';
import 'package:nigdoc/AppWidget/StaffWidget/Department/DepartmentList.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;


class Add_Department extends StatefulWidget {
  const Add_Department({super.key});

  @override
  State<Add_Department> createState() => _Add_DepartmentState();
}

class _Add_DepartmentState extends State<Add_Department> {
  TextEditingController departmentcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>department_List()));
        
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:custom_color.appcolor ,
          title: Text('Add Department',style: TextStyle(color: Colors.white),),

          leading: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>department_List()));
          }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        ),


        body: SafeArea(
          child: Column(
            
            children: [
              SizedBox(height: screenHeight*0.02),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller:departmentcontroller ,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Department *'
                  ),
                ),
                
                
              ),
              SizedBox(height: screenHeight*0.02,),

              Container(width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                   style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(custom_color.appcolor),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      
                                RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                         
                        
                                 ),
                      
                                 )
                    
                                 ),
                    onPressed: (){
                         if(departmentcontroller.text.isEmpty){
                          NigDocToast().showErrorToast('Enter Department');
                         }else{
                        var data={
                          "department":departmentcontroller.text.toString(),
                        
                        };
                        Helper().isvalidElement(data);
                        print(data);
                       }
                  }, child: Text('Save',style: TextStyle(fontSize: 20,color: Colors.white),)),
                ),
              )
            ],
          ),
         
          
          
        ),
        
      ),
    );
  }
}