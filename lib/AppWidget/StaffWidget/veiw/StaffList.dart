import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/StaffWidget/Api.dart';
import 'package:nigdoc/AppWidget/StaffWidget/veiw/AddUser.dart';
import 'package:nigdoc/AppWidget/StaffWidget/veiw/Editstaff.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart'as custom_color;

class StaffList extends StatefulWidget {
  const StaffList({super.key});

  @override
  State<StaffList> createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  bool isloading = false;
  var Stafflist;
  var accesstoken;
    var list=0;
    var selected_item = 'All user';
var user = [
    'All user',
    'Admin',
    // 'Doctor',
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
   var searchList;
    var testList;
    List test_List=[];
  @override
  void initState() {
    accesstoken = storage.getItem('userResponse')['access_token'];

    getStafflist();
    // TODO: implement initState
    super.initState();
  }
  
  var delete = 'Inactive';
  @override
  Widget build(BuildContext context) {
    //  test_List=Helper().isvalidElement(searchList)&&selected_item.text.isNotEmpty?searchList: Stafflist;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    Map<String, String> data = {
      'email': ''
    };
    
    return WillPopScope(onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Setting()),
        );
        return true;
      },
      child: Scaffold(
         appBar: AppBar(title: Text('Staff List',
              style: TextStyle(color: Colors.white),),
              backgroundColor:custom_color.appcolor,
              leading: IconButton(onPressed: (){
                Navigator.push(
              context, MaterialPageRoute(builder: (context)=> Setting(),)
             );
              }, icon: Icon(Icons.arrow_back,
              color: Colors.white,),),
            
              ),
        
        body:isloading? SafeArea(
          child: SingleChildScrollView(
            child: Container( 
              // height: screenHeight,
              // color: Colors.amber,
                child: Column(
                  children: [
                    // Text('data'),
                    SizedBox(height: screenHeight*0.02,),
                    Container(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.96,
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0)
                         
                          ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: DropdownButtonFormField(
                           menuMaxHeight: 300,
                            decoration: InputDecoration.collapsed(hintText: ''),
                            isExpanded: true,
                            hint: Padding(
                              padding: const EdgeInsets.only(top: 0, left: 2, right: 0),
                              child: Text(
                                // 'Select User.',
                                selected_item
                                // '${data['user_type']}'
                                // style:
                                //     TextStyle(color: Colors.red),
                              ),
                            ),
                            // value:' _selectedState[i]',
                            onChanged: (selectedstaffs) {
                              selected_item=selectedstaffs.toString();
                              setState(() {
                                searchuser();
                             
                              });
                              this.setState(() {});
                                  
                                   
                            },
                            items: user.map<DropdownMenuItem<String>>((item) {
                              return new DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
                                  child: new Text(item,style: TextStyle(fontSize: 15),),
                                ),
                                value: item.toString(),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                     SizedBox(height: screenHeight*0.02,),
                    Container(
                      height: screenHeight*0.80,
                      child: Helper().isvalidElement(test_List) &&
                                        test_List.length > 0? 
                                        ListView.builder(
                        itemCount: test_List.length,
                        itemBuilder: (BuildContext context, int index) {
                           var data = test_List[index];
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
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          SizedBox(width: screenWidth*0.02,),
                                           Text('($list)',style: TextStyle(fontWeight: FontWeight.bold),),
                                                      SizedBox(width: screenWidth*0.02,),
                                          Column(
                                            children: [
                                              SizedBox(height: screenHeight*0.01,),
                                              Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    // color: Colors.amber,
                                                    width: screenWidth * 0.39,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Name :',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        Text("${data['name'].toString().toUpperCase()}")
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    // color: Colors.purple,
                                                    width: screenWidth * 0.36,
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
                                              SizedBox(height: screenHeight*0.02,),
                                              Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    // color: Colors.amber,
                                                    width: screenWidth * 0.39,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Email :',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        Text('${data['email'].substring(0 ,11)}...')
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    // color: Colors.amber,
                                                    width: screenWidth * 0.36,
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
                                              SizedBox(height: screenHeight*0.01,),
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
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_staff(select_staff :data )));                                          
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
                                          child: Text('Are you sure you want to delete this staff?',style: TextStyle(fontSize: 16),),
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
                                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>StaffList()));
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
                                                          builder: (context) => StaffList()));
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
                                  ],
                                ),
                              ),
                            ),
                          );
                           
                        }):Center(child: Text('No Data Found')),
                    ),
                  ],
                ),
                  
            ),
          ),
        ):Center(child: SpinLoader(),),
         floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_staff()));
        },
        child: Icon(Icons.add,
        size: 30,
        color: Colors.white,
        
        ),
        backgroundColor: custom_color.appcolor,
        ),
      ),
    );
  }

  getStafflist()async{

    Stafflist = await Api().getstafflist(accesstoken);
    if (Helper().isvalidElement(Stafflist) &&
        Helper().isvalidElement(Stafflist['status']) &&
        Stafflist['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      Stafflist = Stafflist['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
      if(selected_item == 'All user'){
         test_List.clear();
      for (var data in Stafflist) {
        if (data['user_type'] != "Doctor") {
          test_List.add(data);
        }
      }
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
      for (var data in Stafflist) {
        if (data['user_type'] != "Doctor") {
          test_List.add(data);
        }
      }
          //  test_List = doctorlist;
           
    }
     else if (selected_item == 'Admin') {
      test_List.clear();
      for (var data in Stafflist) {
        if (data['user_type'] == "Admin") {
          test_List.add(data);
        }
      }
    }else if(selected_item == 'Doctor'){
     test_List.clear();
      for (var data in Stafflist) {
        if (data['user_type'] == "Doctor") {
          test_List.add(data);
        }
    }
  }else if(selected_item == 'Managers'){
     test_List.clear();
      for (var data in Stafflist) {
        if (data['user_type'] == "Managers") {
          test_List.add(data);
        }
    }
  }
  else if(selected_item == 'Staff'){
     test_List.clear();
      for (var data in Stafflist) {
        if (data['user_type'] == "Staff") {
          test_List.add(data);
        }
    }
  }

else if(selected_item == 'Receptionist'){
     test_List.clear();
      for (var data in Stafflist) {
        if (data['user_type'] == "Receptionist") {
          test_List.add(data);
        }
    }
  }
  else if(selected_item == 'Billing'){
     test_List.clear();
      for (var data in Stafflist) {
        if (data['user_type'] == "Billing") {
          test_List.add(data);
        }
    }
  }
  else if(selected_item == 'Cash Counter'){
     test_List.clear();
      for (var data in Stafflist) {
        if (data['user_type'] == "Cash Counter") {
          test_List.add(data);
        }
    }
  }
  else if(selected_item == 'Nurse'){
     test_List.clear();
      for (var data in Stafflist) {
        if (data['user_type'] == "Nurse") {
          test_List.add(data);
        }
    }
  }
  else if(selected_item == 'ICU'){
     test_List.clear();
      for (var data in Stafflist) {
        if (data['user_type'] == "ICU") {
          test_List.add(data);
        }
    }
  }
  else if(selected_item == 'ICW'){
     test_List.clear();
      for (var data in Stafflist) {
        if (data['user_type'] == "ICW") {
          test_List.add(data);
        }
    }
  }
   else if(selected_item == 'Ward'){
     test_List.clear();
      for (var data in Stafflist) {
        if (data['user_type'] == "Ward") {
          test_List.add(data);
        }
    }
  }
}
}
