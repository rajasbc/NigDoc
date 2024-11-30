import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/Api.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/veiw/AddDoctor.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/veiw/EditDoctor.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/StaffWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart'as custom_color;

class DoctorList extends StatefulWidget {
  const DoctorList({super.key});

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  TextEditingController searchText = TextEditingController();
  bool isloading = false;
  var doctorlist;
  var accesstoken;
var selected_item;
var list=0;
var user = [
    'All user',
    'Admin',
    'Doctor',
    'Managers',
    'Staff',
    'Receptionist',
    'Billing',
    'Cash Counter',
    'Nurse',
    'ICU',
    'ICW',
    'Ward'
  ];
  @override
  void initState() {
    accesstoken = storage.getItem('userResponse')['access_token'];

    getdoctorlist();
    // TODO: implement initState
    super.initState();
  }
var delete = 'Inactive';
 List test_List=[];
 List test_List1 = [];
 var searchList;
  @override
  Widget build(BuildContext context) {
    test_List1=Helper().isvalidElement(searchList)&&searchText.text.isNotEmpty?searchList: test_List;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Map<String, String> data = {
      'address': '',
      'email':'',
    };
    
    return WillPopScope(onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Setting()),
        );
        return true;
      },
      child: Scaffold(
         appBar: AppBar(title: Text('Doctor List',
              style: TextStyle(color: Colors.white),),
              backgroundColor:custom_color.appcolor,
              leading: IconButton(onPressed: (){
                Navigator.push(
              context, MaterialPageRoute(builder: (context)=> Setting(),)
             );
              }, icon: Icon(Icons.arrow_back,
              color: Colors.white,),),
            
              ),
        
        body:isloading? Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                   SizedBox(height: screenHeight*0.02,),
                    Column(
                      children: [
                        Center(child: 
                              Container(
                                height: screenHeight * 0.06,
                                width: screenWidth*0.931,
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
                                    
                                          this.setState(() {});
                                          // var list = ProductListItem;
                                            searchList =  test_List.where((element) {
                                              var treatList = element['name'].toString().toLowerCase();
                                              return treatList.contains(text.toLowerCase());
                                              // return true;
                                            }).toList();
                                            this.setState(() {});
                                        },
                                        decoration: new InputDecoration(
                                          filled: true,
                                          border: InputBorder.none,
                                          fillColor: Colors.white,
                                          hintText: 'Search Doctor List Here...',
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
                                                  searchText.text = '';
                                                  searchList='';
                                                });
                                              },
                                            ))
                                        : Container(),
                                        Container(
                                        width: screenWidth * 0.18,
                                        height: screenHeight,
                                        child: Icon(Icons.search,
                                            color: custom_color.appcolor)),
                                  ],
                                ),
                              ),),
                      ],
                    ),
                  //     Container(
                  //       height: screenHeight * 0.07,
                  //       width: screenWidth * 0.96,
                  //       decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                  //       borderRadius: BorderRadius.circular(5.0)
                           
                  //           ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(10.0),
                  //         child: Center(
                  //           child: DropdownButtonFormField(
                             
                  //             decoration: InputDecoration.collapsed(hintText: ''),
                  //             isExpanded: true,
                  //             hint: Padding(
                  //               padding: const EdgeInsets.only(top: 0, left: 2, right: 0),
                  //               child: Text(
                  //                 'Select User.',
                  //                 // '${data['user_type']}'
                  //                 // style:
                  //                 //     TextStyle(color: Colors.red),
                  //               ),
                  //             ),
                  //             // value:' _selectedState[i]',
                  //             onChanged: (selectedstaffs) {
                  //               selected_item=selectedstaffs;
                  //               setState(() {
                  //                 searchuser();
                               
                  //               });
                  //               this.setState(() {});
                                    
                                     
                  //             },
                  //             items: user.map<DropdownMenuItem<String>>((item) {
                  //               return new DropdownMenuItem(
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.only(top: 7, left: 8, right: 8),
                  //                   child: new Text(item,style: TextStyle(fontSize: 15),),
                  //                 ),
                  //                 value: item.toString(),
                  //               );
                  //             }).toList(),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //      SizedBox(height: screenHeight*0.02,),
                  Container(
                    height: screenHeight*0.76,
                    child: Helper().isvalidElement(test_List1) && test_List1.length > 0
                        ? ListView.builder(
                            itemCount: test_List1.length,
                            itemBuilder: (BuildContext context, int index) {
                              var data = test_List1[index];
                               list=index+1;
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: index % 2 == 0
                                        ? custom_color.lightcolor
                                        : Colors.white,
                                    width: screenWidth,
                                    // height: screenHeight * 0.20,
                                    // width: screenWidth * 0.90,
                                    // decoration:
                                    //     BoxDecoration(border: Border.all(color: Colors.grey)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            SizedBox(width: screenWidth*0.02,),
                                             Text('($list)',style: TextStyle(fontWeight: FontWeight.bold),),
                                                        SizedBox(width: screenWidth*0.02,),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(1.0),
                                                  child: Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      
                                                      Container(
                                                        width: screenWidth * 0.35,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Name :',
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            Text('${data['name'].toString()}')
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                         width: screenWidth * 0.35, 
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Phone :',
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            Text('${data['contact_no'].toString()}')
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: screenHeight*0.01,),
                                                Padding(
                                                  padding: const EdgeInsets.all(1.0),
                                                  child: Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: screenWidth * 0.35,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Address :',
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            Text('${data['address'].toString()}')
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: screenWidth * 0.35, 
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'userlevel :',
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            Text('${data['user_type'].toString()}')
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                // Padding(
                                                //   padding: const EdgeInsets.all(1.0),
                                                //   child: Row(
                                                //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                //     children: [
                                                //       Container(
                                                //           width: screenWidth * 0.55,
                                                //           child: Row(
                                                //             children: [
                                                //               Text(
                                                //                 'Organisation :',
                                                //                 style: TextStyle(
                                                //                     fontWeight:
                                                //                         FontWeight.bold),
                                                //               ),
                                                //               Text('${data[''].toString()}')
                                                //             ],
                                                //           )),
                                                //       Row(
                                                //         children: [
                                                //           Text(
                                                //             'City :',
                                                //             style: TextStyle(
                                                //                 fontWeight: FontWeight.bold),
                                                //           ),
                                                //           Text('${data[''].toString()}')
                                                //         ],
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                SizedBox(height: screenHeight*0.01,),
                                                Container(
                                                  width: screenWidth*0.68,
                                                  child: Row(
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Email :',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          Text('${data['email'].substring(0 ,11)}')
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                      
                                            Column(
                                              children: [
                                                Padding(
                                                padding: const EdgeInsets.only(left: 1),
                                                child:data['user_type'].toString() != 'Admin'? PopupMenuButton(itemBuilder: (context)=>[
                                                PopupMenuItem(
                                                child: Row(
                                                children: [
                                                Icon(Icons.edit,color: custom_color.appcolor,),
                                               Padding(
                                               padding: const EdgeInsets.only(left: 10),
                                              child: Text('Edit',style: TextStyle(fontSize: 16,),),
                                              )
                                                          
                                           ],
                                            ),
                                            onTap: ()async {
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_doctor(select_doctor :data )));                                          
                                            },
                                             ),
                                             PopupMenuItem(
                                        child: Row(
                                        children: [
                                      
                                        Icon(Icons.delete,
                                        color: custom_color.appcolor,
                                        ),
                                           Padding(padding: EdgeInsets.only(left:10),
                                           child: Center(child: Text('Delete',style: TextStyle(fontSize: 16),
                                           
                                           )),
                                           
                                           ),
                                  
                                    ],
                                  ),
                                 
                                  onTap: () {
                                     showDialog(context: context, builder: (context)=>AlertDialog(
                                  
                                        actions: [
                                         
                                          SizedBox(height: screenHeight*0.02,),
                                           Center(child: Container(child: Text('DELETE STAFF',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))),
                                           SizedBox(height: screenHeight*0.02,),
                                           Container(
                                            child: Text('Are you sure you want to delete this Doctor?',style: TextStyle(fontSize: 16),),
                                           ),
                                            SizedBox(height: screenHeight*0.02,),
                                           Container(
                                            child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  child: ElevatedButton(
                                                     style: ButtonStyle(
                                            backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                    
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    
                                  )
                                  
                                ),
                                                    onPressed: (){
                                                    //  Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorList()));
                                                    Navigator.pop(context);
                                                    }, child: Text('NO' ,style: TextStyle(fontSize: 20,color: Colors.white),)),
                                                ),
                                                Container(
                                                  child: ElevatedButton(
                                                     style: ButtonStyle(
                                            backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                    
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    
                                  )
                                  
                                ),
                                
                                                    onPressed: ()async{ 
                                                       var value= {
                                                              "id":data['id'],
                                                              "status":delete,
                                                             };
                                                             var list = await Api()
                                                      .Deletestaff( accesstoken, value);
                                                  if (list['message'] ==
                                                      "Deleted successfully") {
                                                    NigDocToast().showSuccessToast(
                                                        'Deleted successfully');
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => DoctorList()));
                                                  } else {
                                                    NigDocToast()
                                                        .showErrorToast('Please TryAgain later');
                                                  }
                                                            
                                                    }, child: Text('yes' ,style: TextStyle(fontSize: 20,color: Colors.white),)),
                                                ),
                                                
                                              ],
                                            ),
                                           )
                                        ]
                                     ));
                                  }
                                                      
                                  ),
                                       ]):Container()
                                       ),
                                                                                  
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      
                                      
                                    ),
                                    
                                  ),
                                ),
                              );
                            })
                        : Center(child: Text('No Data Found')),
                  ),
                ],
              ),
            )):Center(child: SpinLoader(),
                ),
                 floatingActionButton: FloatingActionButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>AddDoctor()));
            },
            child: Icon(Icons.add,
            size: 30,
            color: Colors.white,),
            backgroundColor: custom_color.appcolor,
            ),
     
      ),
    );
  }

  getdoctorlist() async {
   
    // doctorlist = await api().getdoctorlist(accesstoken);
    // if (Helper().isvalidElement(doctorlist) &&
    //     Helper().isvalidElement(doctorlist['status']) &&
    //     doctorlist['status'] == 'Token is Expired') {
    //   Helper().appLogoutCall(context, 'Session expeired');
    // } else {
    //   doctorlist = doctorlist['list'];
    //   //  storage.setItem('diagnosisList', diagnosisList);
    //   this.setState(() {
    //     isloading = true;
    //   });
    // }
    doctorlist = await Api().getstafflist(accesstoken);
    if (Helper().isvalidElement(doctorlist) &&
        Helper().isvalidElement(doctorlist['status']) &&
        doctorlist['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      doctorlist = doctorlist['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
      //  if(doctorlist['user_type'] == "Doctor"){
          // test_List.clear();
      for (var data in doctorlist) {
       
        if (data['user_type'] == "Doctor") {
          test_List.add(data);
        }
      // }
          //  test_List = doctorlist;
           
    }
      this.setState(() {
        isloading = true;
      });
    }
  }

  searchuser(){
    if(selected_item == 'All user'){
      test_List.clear();
      for (var data in doctorlist) {
        // if (data['user_type'] == "Admin") {
          test_List.add(data);
        // }
      }
          //  test_List = doctorlist;
           
    }
     else if (selected_item == 'Admin') {
      test_List.clear();
      for (var data in doctorlist) {
        if (data['user_type'] == "Admin") {
          test_List.add(data);
        }
      }
    }else if(selected_item == 'Doctor'){
     test_List.clear();
      for (var data in doctorlist) {
        if (data['user_type'] == "Doctor") {
          test_List.add(data);
        }
    }
  }else if(selected_item == 'Managers'){
     test_List.clear();
      for (var data in doctorlist) {
        if (data['user_type'] == "Managers") {
          test_List.add(data);
        }
    }
  }
  else if(selected_item == 'Staff'){
     test_List.clear();
      for (var data in doctorlist) {
        if (data['user_type'] == "Staff") {
          test_List.add(data);
        }
    }
  }

else if(selected_item == 'Receptionist'){
     test_List.clear();
      for (var data in doctorlist) {
        if (data['user_type'] == "Receptionist") {
          test_List.add(data);
        }
    }
  }
  else if(selected_item == 'Billing'){
     test_List.clear();
      for (var data in doctorlist) {
        if (data['user_type'] == "Billing") {
          test_List.add(data);
        }
    }
  }
  else if(selected_item == 'Cash Counter'){
     test_List.clear();
      for (var data in doctorlist) {
        if (data['user_type'] == "Cash Counter") {
          test_List.add(data);
        }
    }
  }
  else if(selected_item == 'Nurse'){
     test_List.clear();
      for (var data in doctorlist) {
        if (data['user_type'] == "Nurse") {
          test_List.add(data);
        }
    }
  }
  else if(selected_item == 'ICU'){
     test_List.clear();
      for (var data in doctorlist) {
        if (data['user_type'] == "ICU") {
          test_List.add(data);
        }
    }
  }
  else if(selected_item == 'ICW'){
     test_List.clear();
      for (var data in doctorlist) {
        if (data['user_type'] == "ICW") {
          test_List.add(data);
        }
    }
  }
   else if(selected_item == 'Ward'){
     test_List.clear();
      for (var data in doctorlist) {
        if (data['user_type'] == "Ward") {
          test_List.add(data);
        }
    }
  }
}
}
