import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/StaffWidget/Department/Add%20Department%20List.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;


class department_List extends StatefulWidget {
  const department_List({super.key});

  @override
  State<department_List> createState() => _department_ListState();
}

class _department_ListState extends State<department_List> {

   TextEditingController departmentcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Setting()));
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Department List',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: custom_color.appcolor,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setting(),
                    ));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            )),
         body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Container(
                 
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              color: index % 2 == 0
                                  ? custom_color.lightcolor
                                  : Colors.white,
                              width: screenWidth,
                              height: screenHeight * 0.07,
                             // width: screenWidth * 0.90,
                              // decoration:
                              //     BoxDecoration(border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: screenWidth*0.75,
                                      // color: Colors.red,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  // color: Colors.amber,
                                                  width: screenWidth * 0.45,
                                                  height: screenWidth*0.07,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Name :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    
                                                    ],
                                                  ),
                                                ),
                                                // Container(
                                                //   //  width: screenWidth * 0.35,
                                                //   child: Row(
                                                //     children: [
                                                //       Text(
                                                //         'Address :',
                                                //         style: TextStyle(
                                                //             fontWeight:
                                                //                 FontWeight.bold),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: screenWidth * 0.45,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Pincode :',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Container(
                                                //   //  width: screenWidth * 0.35,
                                                //   child: Row(
                                                //     children: [
                                                //       Text(
                                                //         'Mobile No :',
                                                //         style: TextStyle(
                                                //             fontWeight:
                                                //                 FontWeight.bold),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          ),
                                         

                                        ],
                                      ),
                                    ),
                                    PopupMenuButton(itemBuilder: (context)=>[
                                      PopupMenuItem(child: Row(
                                              children: [
                                                Icon(Icons.edit,color: custom_color.appcolor,),
                                                Padding(padding: EdgeInsets.only(left: 10),
                                                child: Text('Edit',style: TextStyle(fontSize: 16),),)
                                              ],

                                              
                                            ),
                                            onTap: () {
                                              showDialog(context: context, builder: ((context) => AlertDialog(
                                                actions: [
                                                    Padding(padding: EdgeInsets.all(10)),
                                                    Container(
                                                      height: screenHeight*0.04,
                                                      width: screenWidth*0.14,
                                                    ),
                                                    
                                                               SizedBox(height: screenHeight*0.00,),


                                                               TextFormField(
                                                                controller: departmentcontroller,
                                                                decoration: InputDecoration(
                                                                  border: OutlineInputBorder(),
                                                                  labelText: 'Department *',
                                                                ),
                                                               ),
                                                               SizedBox(height: screenHeight*0.04,),
                                                               Row(
                                                                children: [
                                                                   Padding(padding: EdgeInsets.only(left:20),
                        child: ElevatedButton(
                           style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(custom_color.appcolor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    
                            RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
       
      
                             ),
    
                             )
  
                             ),
                           child: Text('Update',style: TextStyle(color: Colors.white,fontSize: 20),),
                           onPressed: (() {
                                  if(departmentcontroller.text.isEmpty){
                      NigDocToast().showErrorToast('Enter Department');
                     }else{
                    var data={
                      "department":departmentcontroller.text.toString(),
                    
                    };
                    Helper().isvalidElement(data);
                    print(data);
                   }                         
                      
                             
                           }),
                           ),
                        ),

                        Padding(padding: EdgeInsets.only(left: 20),
                        
                        child: ElevatedButton( 
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(custom_color.appcolor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    
                            RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
       
      
                             ),
    
                             )
  
                             ),
                          child:Text('Cancel',style: TextStyle(color: Colors.white,fontSize: 20),),

                          onPressed: (() {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>department_List()));
                          }),
                          
                          ),
                          
                          
                          ),
                          ],
                         ),
                          SizedBox(height: screenHeight*0.04,),
                                                ],
                                              )));
                                            },
                                            
                                            )
                                    ])
                                  ],
                                ),
                              ),
                            ),
                       
                          ),
                          
                        );
                       
                      },

                      
                    ),

                  ),
                  
                ),
              ),
            ),
          ),
        ),
       floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_Department()));

       },
       child: Icon(Icons.add,color: Colors.white,size: 30,),
       backgroundColor: custom_color.appcolor,
       ),
      ),
    );
  }
}