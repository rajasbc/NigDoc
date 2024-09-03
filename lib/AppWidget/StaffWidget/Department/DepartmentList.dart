import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/StaffWidget/Department/AddDepartmentList.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;


class department_List extends StatefulWidget {
  const department_List({super.key});

  @override
  State<department_List> createState() => _department_ListState();
}

class _department_ListState extends State<department_List> {
   TextEditingController searchText=TextEditingController();
   TextEditingController departmentcontroller=TextEditingController();
   TextEditingController adddepartmentcontroller=TextEditingController();
   bool isLoading = false;
   var userResponse;
   var accesstoken;
   List departmentList = [];
   var list=0;
   @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];

    getdepartmentlist();
    // TODO: implement initState
    super.initState();
  }
  var searchList;
  List test_List = [];
  @override
  Widget build(BuildContext context) {
    Map<String, String> data = {
      'department_name': ''
    };
    //  '${Helper().isvalidElement(clinic_profile) && Helper().isvalidElement(clinic_profile) ?clinic_profile['clinic_profile']['email'] == null ?'': clinic_profile['clinic_profile']['email'].toString().toLowerCase() : '' }',
    // test_List=Helper().isvalidElement(searchList)&&searchText.text.isNotEmpty?searchList: Helper().isvalidElement(departmentList) && Helper().isvalidElement(departmentList) ? departmentList == null ? '' : departmentList : '';
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
         body: SafeArea(
           child: SingleChildScrollView(
             child: Column(
               children: [
                 Column(
                   children: [
                    Container(
                     
                // SizedBox(height: screenHeight*0.02,),
                   child:    Column(
                        children: [
                          SizedBox(height: screenHeight*0.02,),
                          Center(child: 
                                Container(
                                  height: screenHeight * 0.06,
                                  width: screenWidth*0.96,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: custom_color.appcolor),
                                      borderRadius: BorderRadius.all(Radius.circular(4))),
                                  child: Row(
                                    children: [
                                      // Container(
                                      //     width: screenWidth * 0.1,
                                      //     height: screenHeight,
                                      //     child: Icon(Icons.search,
                                      //         color: custom_color.appcolor)),
                                      Container(
                                        width: screenWidth * 0.65,
                                        child: TextField(
                                          controller: searchText,
                                          onChanged: (text) {
                                            print(text);
                                      filterItems(text);
                                            this.setState(() {});
                                            // var list = ProductListItem;
                                              // searchList =  departmentList.where((element) {
                                              //   var treatList = element['department_name'].toString().toLowerCase();
                                              //   return treatList.contains(text.toLowerCase());
                                              //   // return true;
                                              // }).toList();
                                              // this.setState(() {});
                                          },
                                          decoration: new InputDecoration(
                                            filled: true,
                                            border: InputBorder.none,
                                            fillColor: Colors.white,
                                            hintText: 'Search Department List Here...',
                                          ),
                                        ),
                                      ),
                                      searchText.text.isNotEmpty
                                          ? Container(
                                              width: screenWidth * 0.06,
                                              height: screenHeight,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    searchText.clear();
                                                    filterItems(searchText.text);
                                                    searchList='';
                                                  });
                                                },
                                              ))
                                          : Container(),
                                           Container(
                                          width: screenWidth * 0.24,
                                          height: screenHeight,
                                          child: Icon(Icons.search,
                                              color: custom_color.appcolor)),
                                    ],
                                  ),
                                ),),
                        ],
                      ),
                      ),
                      SizedBox(height: screenHeight*0.02,),
                     SingleChildScrollView(
                       child: Helper().isvalidElement(test_List) && test_List.length > 0 ? Container(  
                         height: screenHeight*0.80,
                         child: ListView.builder(
                           shrinkWrap: true,
                           // itemCount: 5,
                            itemCount: test_List.length,
                            
                           itemBuilder: (BuildContext context, int index) {
                               list=index+1;
                             var data=test_List[index];
                            
                             return Center(
                               child: Padding(
                                 padding: const EdgeInsets.all(0.0),
                                 child: Container(
                                   color: index % 2 == 0
                                       ? custom_color.lightcolor
                                       : Colors.white,
                                  //  width: screenWidth,
                                   height: screenHeight * 0.1,
                                  
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ListTile(
                                        title: SizedBox(child: Text('${data['department_name']}')),
                                        
                                        leading: Text('$list',style: TextStyle(fontSize: 16),),
                                      
                                      
                                      trailing: PopupMenuButton(itemBuilder: (context)=>[
                                           PopupMenuItem(child: Row(
                                                   children: [
                                                     Icon(Icons.edit,color: custom_color.appcolor,),
                                                     Padding(padding: EdgeInsets.only(left: 10),
                                                     child: Text('Edit',style: TextStyle(fontSize: 16),),)
                                                   ],
                                  
                                                   
                                                 ),
                                                 onTap: () {
                                                  var item = {
                                                    departmentcontroller.text = data['department_name']
                                                  };
                                                   showDialog(context: context, builder: ((context) => AlertDialog(
                                                     actions: [
                                                         Padding(padding: EdgeInsets.all(10)),
                                                         Container(
                                                           height: screenHeight*0.04,
                                                           width: screenWidth*0.14,
                                                         ),                                        
                                  
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
                                                Padding(padding: EdgeInsets.only(left: 20),
                             
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
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>department_List()));
                               }),
                               
                               ),
                               
                               
                               ),
                             Padding(padding: EdgeInsets.only(left:20),
                             child: ElevatedButton(
                                style: ButtonStyle(
                                 backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                 shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                         
                                 RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10),
                            
                           
                                  ),
                         
                                  )
                                            
                                  ),
                                child: Text('Update',style: TextStyle(color: Colors.white,fontSize: 20),),
                                onPressed: (() async{
                                       if(departmentcontroller.text.isEmpty){
                           NigDocToast().showErrorToast('Enter Department');
                          }else{
                                             
                          var value={
                            'id':data['id'],
                             "department_name":departmentcontroller.text.toString(),
                                                                                                                                                         
                           };
                           var list = await PatientApi()
                             .Editdepartment( accesstoken, value);
                                           if (list['message'] ==
                                               "updated successfully") {
                                             NigDocToast().showSuccessToast(
                                                 'updated successfully');
                                             Navigator.push(
                                                 context,
                                                 MaterialPageRoute(
                                                     builder: (context) => department_List()));
                                           } else {
                                             NigDocToast()
                                                 .showErrorToast('Please TryAgain later');
                                           }
                                             }                         
                           
                                  
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
                                                           
                                      ),
                                    ),
                                  // width: screenWidth * 0.90,
                                   // decoration:
                                   //     BoxDecoration(border: Border.all(color: Colors.grey)),
                          //          child: Padding(
                          //            padding: const EdgeInsets.all(10),
                          //            child: Row(
                          //              children: [
                          //                Container(
                          //                  width: screenWidth*0.75,
                          //                  // color: Colors.red,
                          //                  child: Column(
                          //                    children: [
                          //                      Padding(
                          //                        padding: const EdgeInsets.all(0.0),
                          //                        child: Row(
                          //                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //                          children: [
                          //                            SizedBox(width: screenWidth*0.00,),
                          //                            Text('($list)',style: TextStyle(fontWeight: FontWeight.bold),),
                          //                            SizedBox(width: screenWidth*0.01,),
                          //                            Container(
                          //                             //  color: Colors.amber,
                          //                              width: screenWidth * 0.66,
                          //                             //  height: screenWidth*0.07,
                          //                              child: Row(
                          //                                children: [
                          //                                  Text(
                          //                                    'Name : ${data['department_name'].toString()}',
                          //                                     // 'Pat Name : ${data['customer_name'].substring(0 ,4)}....',
                          //                                    style: TextStyle(
                          //                                        fontWeight:
                          //                                            FontWeight.bold),
                          //                                  ),
                                                         
                          //                                ],
                          //                              ),
                          //                            ),
                                                     
                          //                          ],
                          //                        ),
                          //                      ),
                                              
                                              
                                  
                          //                    ],
                          //                  ),
                          //                ),
                          //               //  SizedBox(width: screenWidth*0.01,),
                          //                PopupMenuButton(itemBuilder: (context)=>[
                          //                  PopupMenuItem(child: Row(
                          //                          children: [
                          //                            Icon(Icons.edit,color: custom_color.appcolor,),
                          //                            Padding(padding: EdgeInsets.only(left: 10),
                          //                            child: Text('Edit',style: TextStyle(fontSize: 16),),)
                          //                          ],
                                  
                                                   
                          //                        ),
                          //                        onTap: () {
                          //                         var item = {
                          //                           departmentcontroller.text = data['department_name']
                          //                         };
                          //                          showDialog(context: context, builder: ((context) => AlertDialog(
                          //                            actions: [
                          //                                Padding(padding: EdgeInsets.all(10)),
                          //                                Container(
                          //                                  height: screenHeight*0.04,
                          //                                  width: screenWidth*0.14,
                          //                                ),                                        
                                  
                          //                      TextFormField(
                          //                      controller: departmentcontroller,
                          //                      decoration: InputDecoration(
                          //                      border: OutlineInputBorder(),
                          //                      labelText: 'Department *',
                          //                        ),
                          //                       ),
                          //                       SizedBox(height: screenHeight*0.04,),
                          //                       Row(
                          //                       children: [
                          //                       Padding(padding: EdgeInsets.only(left: 20),
                             
                          //    child: ElevatedButton( 
                          //      style: ButtonStyle(
                          //        backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                          //        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                         
                          //        RoundedRectangleBorder(
                          //        borderRadius: BorderRadius.circular(10),
                            
                           
                          //         ),
                         
                          //         )
                                            
                          //         ),
                          //      child:Text('Cancel',style: TextStyle(color: Colors.white,fontSize: 20),),
                                  
                          //      onPressed: (() {
                          //        Navigator.push(context, MaterialPageRoute(builder: (context)=>department_List()));
                          //      }),
                               
                          //      ),
                               
                               
                          //      ),
                          //    Padding(padding: EdgeInsets.only(left:20),
                          //    child: ElevatedButton(
                          //       style: ButtonStyle(
                          //        backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                          //        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                         
                          //        RoundedRectangleBorder(
                          //        borderRadius: BorderRadius.circular(10),
                            
                           
                          //         ),
                         
                          //         )
                                            
                          //         ),
                          //       child: Text('Update',style: TextStyle(color: Colors.white,fontSize: 20),),
                          //       onPressed: (() async{
                          //              if(departmentcontroller.text.isEmpty){
                          //  NigDocToast().showErrorToast('Enter Department');
                          // }else{
                                             
                          // var value={
                          //   'id':data['id'],
                          //    "department_name":departmentcontroller.text.toString(),
                                                                                                                                                         
                          //  };
                          //  var list = await PatientApi()
                          //    .Editdepartment( accesstoken, value);
                          //                  if (list['message'] ==
                          //                      "updated successfully") {
                          //                    NigDocToast().showSuccessToast(
                          //                        'updated successfully');
                          //                    Navigator.push(
                          //                        context,
                          //                        MaterialPageRoute(
                          //                            builder: (context) => department_List()));
                          //                  } else {
                          //                    NigDocToast()
                          //                        .showErrorToast('Please TryAgain later');
                          //                  }
                          //                    }                         
                           
                                  
                          //       }),
                          //       ),
                          //    ),
                                  
                             
                          //      ],
                          //     ),
                          //      SizedBox(height: screenHeight*0.04,),
                          //                            ],
                          //                          )));
                          //                        },
                                                 
                          //                        )
                          //                ])
                          //              ],
                          //            ),
                          //          ),
                                 ),
                            
                               ),
                               
                             );
                            
                           },
                                  
                           
                         ),
                         
                       ):Container(child: Center(child: Text('No Data Found')),),
                     ),
                   ],
                 ),
               ],
             ),
           ),
         ),
       floatingActionButton: FloatingActionButton(onPressed: (){
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_Department()));

       showDialog(context: context, builder: ((context) => AlertDialog(
                                                actions: [
                                                    Padding(padding: EdgeInsets.all(10)),
                                                    Container(
                                                      height: screenHeight*0.04,
                                                      width: screenWidth*0.14,
                                                    ),
                                                    
                                                               SizedBox(height: screenHeight*0.00,),


                                                               TextFormField(
                                                                controller: adddepartmentcontroller,
                                                                decoration: InputDecoration(
                                                                  border: OutlineInputBorder(),
                                                                  labelText: 'Department *',
                                                                ),
                                                               ),
                                                               SizedBox(height: screenHeight*0.04,),
                                                               Center(
                                                                 child: ElevatedButton(
                                                                    style: ButtonStyle(
                                                                     backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                                                     shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                                                                                    
                                                                     RoundedRectangleBorder(
                                                                     borderRadius: BorderRadius.circular(10),
                                                                                                                                       
                                                                                                                                      
                                                                      ),
                                                                                                                                    
                                                                      )
                                                                                                                                  
                                                                      ),
                                                                    child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 20),),
                                                                    onPressed: (() async{
                                                                           if(adddepartmentcontroller.text.isEmpty){
                                                                          NigDocToast().showErrorToast('Enter Department');
                                                                         }else{
                                                                       var data={
                                                                         "department_name":adddepartmentcontroller.text.toString(),
                                                                                                                                                    
                                                                        };
                                                                       var list = await PatientApi()
                                                                 .Adddepartment( accesstoken, data);
                                                                  if (list['message'] ==
                                                                      "Department Add successfully") {
                                                                    NigDocToast().showSuccessToast(
                                                                        'Department Add successfully');
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => department_List()));
                                                                  } else {
                                                                    NigDocToast()
                                                                        .showErrorToast('Please TryAgain later');
                                                                  }
                                                                                                  }                         
                                                                                                                                                      
                                                                      
                                                                    }),
                                                                    ),
                                                               ),
                          SizedBox(height: screenHeight*0.04,),
                                                ],
                                              )));
       },
       child: Icon(Icons.add,color: Colors.white,size: 30,),
       backgroundColor: custom_color.appcolor,
       ),
      ),
    );
  }
  getdepartmentlist() async {
    var List = await PatientApi().getdepartmentlist(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        isLoading=true;
        departmentList = List['list'];
        print(departmentList);
        filterItems(searchText.text);
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }
  void filterItems(String text) {
    // setState(() {
    if (text.isEmpty) {
      setState(() {
        test_List = departmentList;
      });
    } 
    else if (text.length >= 3) {
      setState(() {
        test_List = departmentList.where((item) =>
            item['department_name']
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase()),
            // item['mobile_no']
            //     .toString()
            //     .toLowerCase()
            //     .contains(text.toLowerCase())
                ).toList();
      });
    }
  }
}