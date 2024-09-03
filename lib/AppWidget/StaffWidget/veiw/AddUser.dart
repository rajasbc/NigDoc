import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/Api.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/StaffWidget/Api.dart';
//import 'package:nigdoc/AppWidget/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/StaffWidget/veiw/StaffList.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class Add_staff extends StatefulWidget {
  const Add_staff({super.key});

  @override
  State<Add_staff> createState() => _Add_staff();
}

class _Add_staff extends State<Add_staff> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController staffnamecontroller = TextEditingController();
  TextEditingController designationcontroller = TextEditingController();
  TextEditingController Professionscontroller= TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();
  TextEditingController departmentcontroller= TextEditingController();
   TextEditingController userlevelcontroller = TextEditingController();
    TextEditingController usernamecontroller = TextEditingController();
    TextEditingController department1controller = TextEditingController();

var add_User;
var selected_level;
var title =[
     'Select',
     'Mr',
     'Mrs',
     'Miss',
     'Dr',
];
var selected_Values;
bool Test =true;
var selected_item;
var user = [
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
  bool isloading = false;
  bool showPassword = false;
  bool showPassword2 = false;
var userResponse;
var accesstoken;
List departmentListList =[];
List department_List = [];
var selectedTest;
@override
  bool _passwordVisible = true;
  bool _passwordVisible2 =false;
  void initState() {
    _passwordVisible = true;
    _passwordVisible2 = false;
       userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];
    getdepartmentList();
  }

  getdepartmentList() async{
    var List = await PatientApi().getdepartmentList(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        departmentListList = List['list'];
      });
    }
  }  @override
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
 return  PopScope(
       canPop:false,
       onPopInvoked:(bool didpop) {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> StaffList(),)
         );
         
        },
    child: Scaffold(
      appBar: AppBar(title: Text('Add Staff',style: TextStyle(color: Colors.white),),
      backgroundColor: custom_color.appcolor,
      leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StaffList(),
                ));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        
      ),
      
      
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: screenHeight*0.02,),
                 Padding(
                   padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                      //padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.96,
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0)
                            // border: OutlineInputBorder()
                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: DropdownButtonFormField(
                            
                              decoration: InputDecoration.collapsed(hintText: ''),
                              isExpanded: true,
                              hint: Padding(
                              padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
                                child: Text(
                                  'Title *',
                                 
                                ),
                              ),
                             
                              onChanged: (selectedstaffs) {
                                selected_level=selectedstaffs;
                                setState(() {
                                 
                                });
                              },
                              items: title.map<DropdownMenuItem<String>>((item) {
                                return new DropdownMenuItem(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
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
               SizedBox(height: screenHeight*0.01,),
            
            
            
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, bottom: 2, left: 8, right: 8),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        controller:staffnamecontroller,
                       
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Staff Name *'
                            ),
                            
                      ),
                    ),
                    SizedBox(height: screenHeight*0.01,),
                     Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, bottom: 2, left: 8, right: 8),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        controller: designationcontroller,
                       
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Designation *'
                            ),
                            
                      ),
                    ),
            
                    SizedBox(height: screenHeight*0.01,),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, bottom: 2, left: 8, right: 8),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        controller: Professionscontroller,
                        
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Professions *'
                            ),
                            
                      ),
                    ),
                    SizedBox(height: screenHeight*0.02,),
            
            
                    //  Container(
                    //    height: screenHeight * 0.07,
                    //    width: screenWidth * 0.96,
                    //    decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                    //    borderRadius: BorderRadius.circular(5.0)
                          
                    //        ),
                    //    child: Padding(
                    //      padding: const EdgeInsets.all(10.0),
                    //      child: Center(
                    //        child: DropdownButtonFormField(
                    //         menuMaxHeight: 300,
                    //          decoration: InputDecoration.collapsed(hintText: ''),
                            
                    //          isExpanded: true,
                    //          hint: Padding(
                    //            padding: const EdgeInsets.only(top: 0, left: 2, right: 0),
                    //            child: Text(
                    //              'Department *',
                                
                    //            ),
                    //          ),
                           
                    //          onChanged: (selectedstaffs) {
                    //            selected_Values=selectedstaffs;
                    //            setState(() {
                                
                    //            });
                    //          },
                    //          items: departmentListList
                    //          .map<DropdownMenuItem<String>>(
                    //    (value) => DropdownMenuItem<String>(
                    //          value: value["id"].toString(),
                    //          // item: value['department_name'].toString(),
                    //          child: Text(value["department_name"].toString()),
                    //        ))
                    //                      .toList()
                    //        ),
                    //      ),
                    //    ),
                    //  ),
                    Container(
                    child: Helper().isvalidElement(selectedTest)
                    ? RenderPatientdata(screenHeight, screenWidth)
                    : renderPatientAutoComplete(screenHeight, screenWidth)
                // : renderTesttListWidget(screenHeight, screenWidth)
                ),
                      SizedBox(height: screenHeight*0.02),
                      department_List.length>0?renderTesttListWidget(screenHeight, screenWidth):Container(),
         
                      SizedBox(height: screenHeight*0.02,),    
                      Container(
                       height: screenHeight * 0.08,
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
                                 'User Level *',
                                 // style:
                                 //     TextStyle(color: Colors.red),
                               ),
                             ),
                             // value:' _selectedState[i]',
                             onChanged: (selectedstaffs) {
                               selected_item=selectedstaffs;
                               setState(() {
                               
                               });
                             },
                             items: user.map<DropdownMenuItem<String>>((item) {
                               return new DropdownMenuItem(
                                 child: Padding(
                                   padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
                                   child: Container(
                                     // height: screenHeight*0.01,
                                     child: new Text(item,style: TextStyle(fontSize: 15),)),
                                 ),
                                 value: item.toString(),
                               );
                             }).toList(),
                           ),
                         ),
                       ),
                     ),
                    SizedBox(height: screenHeight*0.02,),

                     Padding(
                      padding:
                          const EdgeInsets.only(top: 2.0, bottom: 2, left: 8, right: 8),
                      child: TextFormField(
                        
                        autovalidateMode: AutovalidateMode.always,
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                       
                        // maxLength: 10,
                        // keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Email Id *'),
                      ),
                    ),
                     SizedBox(height: screenHeight*0.01,),
            
            
            
                      Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, bottom: 2, left: 8, right: 8),
                      child: TextFormField(
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.always,
                        controller: mobilecontroller,
                      
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Mobile No *'),
                      ),
                    ),
                     SizedBox(height: screenHeight*0.01,),
            
            
            
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, bottom: 2, left: 8, right: 8),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        controller: addresscontroller,
                     
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Address *'
                            ),
                            
                      ),
                    ),
                     SizedBox(height: screenHeight*0.01,),
            
            
            
                    
                     Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, bottom: 2, left: 8, right: 8),
                      child: TextFormField(
                        // autovalidateMode: AutovalidateMode.always,
                        readOnly: true,
                        controller: emailcontroller,
                       
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Username'),
                      ),
                    ),
                     SizedBox(height: screenHeight*0.01,),
            
                    Padding(padding:
                    const EdgeInsets.only(top:8.0,bottom: 2,left:8,right:8) ,
                    child: TextFormField(
                      obscureText: _passwordVisible,
                      controller: passcontroller,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),labelText: 'Password ',
                       
                       suffixIcon: IconButton(
                        icon: Icon(_passwordVisible
                        ?Icons.visibility_off
                        :Icons.visibility,
                        color: custom_color.appcolor,
                        ),
                        onPressed: (() {
                          setState(() {
                            _passwordVisible=!_passwordVisible;
                          });
                        }),
                       )
                      ),
                    ),
                    ),
                      SizedBox(height: screenHeight*0.01,),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, bottom: 2, left: 8, right: 8),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                        obscureText:  !_passwordVisible2,
                        autovalidateMode: AutovalidateMode.always,
                        controller: confirmpasscontroller,
                     
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Confirm Password ',
                            suffixIcon: IconButton(
            
                            
                             icon:Icon(_passwordVisible2
                             ?Icons.visibility
                            : Icons.visibility_off,
                            color: custom_color.appcolor,
                             ),
                              onPressed: () {
                                        setState(() {
                                          _passwordVisible2=! _passwordVisible2;
                                        });
                                      
                               } )
                            
                            ),
                          
                   ), ),
            
            
                        
            
                           SizedBox(height: screenHeight*0.01,),
            
            
            
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
                                onPressed: () async {
                                            if(selected_level==null){
                                              NigDocToast().showErrorToast('Please Select Title');
                                 
                                             }else if(staffnamecontroller.text.isEmpty){
                                            NigDocToast().showErrorToast('Please Enter Staff Name');
                                
                                              }
                                              else if(designationcontroller.text.isEmpty){
                                          NigDocToast().showErrorToast('Please Enter Designation');
                                 
                                              }
                                              else if(Professionscontroller.text.isEmpty){
                                          NigDocToast().showErrorToast('Please Enter Professions');
                                 
                                              }
                                               else if(department_List==null){
                                          NigDocToast().showErrorToast('Please Select Department');
                                 
                                              }
                                              else if(selected_item==null){
                                          NigDocToast().showErrorToast('Please Select User Level');
                                 
                                              }
                                              else if (!emailcontroller.text
                                     .contains('@') ||
                                     !emailcontroller.text.contains('.') ||
                                     !emailcontroller.text.contains('com')) {
                                      NigDocToast().showErrorToast("Please Enter Your Email id");
                                    }
                                              else if(mobilecontroller.text.isEmpty){
                                          NigDocToast().showErrorToast('Enter Mobile No');
                                 
                                              }
                                              else if (addresscontroller.text.isEmpty){
                                                NigDocToast().showErrorToast('Please Enter Address');
                                             
                                 
                                              }
                                          //     else if(usernamecontroller.text.isEmpty){
                                          // NigDocToast().showErrorToast('Please Enter User Name ');
                                
                                          //     }
                                              else if(passcontroller.text.isEmpty){
                                          NigDocToast().showErrorToast('Enter Password');
                                
                                              }
                                              else if(confirmpasscontroller.text.isEmpty){
                                          NigDocToast().showErrorToast('Enter Confirm Password');
                                       
                                              }else{
                                                  var data={
                                                    "title":selected_level.toString(),
                                                    "name":staffnamecontroller.text.toString(),
                                                    "designation":designationcontroller.text.toString(),
                                                    "professions":Professionscontroller.text.toString(),
                                                    "department_name":department_List,
                                                    "userlevel":selected_item.toString(),
                                                    "email":emailcontroller.text.toString(),
                                                    "contact_no":mobilecontroller.text.toString(),
                                                    "address":addresscontroller.text.toString(),
                                                    // "user name":usernamecontroller.text.toString(),
                                                    "password":passcontroller.text.toString(),
                                                    // "confirm pass":confirmpasscontroller.text.toString(),
                              
                                                  };
                                                   var list = await Api()
                                    .Addstaff( accesstoken, data);
                                if (list['message'] ==
                                    "Staffs Add successfully") {
                                  NigDocToast().showSuccessToast(
                                      'Staffs Add successfully');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StaffList()));
                                } else {
                                  NigDocToast()
                                      .showErrorToast('Please TryAgain later');
                                }
                                                 }
                                                 
                                                
                                       }, child: Text('Save',style: TextStyle(color:Colors.white,fontSize: 20),)),
                            ),
                          ),SizedBox(height: screenHeight*0.05,),
                     
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
  renderTesttListWidget(screenHeight, screenWidth){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: custom_color.appcolor),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // color: Colors.green,
                 width: screenWidth*0.86,
                                      child: ListView.builder(
                                         shrinkWrap: true,
                                          itemCount: department_List.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var data = department_List[index];
                                              return Container(
                                                  child: Column(children: [
                                                ListTile(
                                                  title: Text("${data["department_name"].toString()}"),
                                                 trailing: IconButton(onPressed: (){
              if(department_List.contains(data)){
                 department_List.remove(data);
                 setState(() {
                     print('exists');

                 });
                                print('exists');

                                }else{
                                  // Group_TestList.add(selectedTest);
                                  // setState(() {
                                  //   Test = false;
                                  //   selectedTest = null;
                                  // });
                                }

              
            }, icon: Icon(Icons.close,),color: Colors.red),
                        //                         title:  Text(
                        //   Helper().isvalidElement(data)
                        //       ? "${data["test_name"].toString()}"
                        //       : '',
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // ),
                                                )
                                                  ])
                                              );
                                              }
                                      )
                // child: Row(
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           Helper().isvalidElement(Group_TestList)
                //               ? "${Group_TestList[0]['test_name'].toString()}"
                //               : '',
                //           style: TextStyle(fontWeight: FontWeight.bold),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ),
              // Container(
              //   color: Colors.red,
              //    width: screenWidth*0.30,
              //     child: IconButton(
              //   onPressed: () {
              //     // storage.setItem('selectedPatient', null);
              //     // this.setState(() {
              //     //   // selectedPatient = null;
              //     //   // clearProduct();
              //     //   // ProductshowAutoComplete = true;
              //     // });
              //   },
              //   icon: Icon(
              //     Icons.close,
              //   ),
              //   color: CustomColors.error_color,
              // ))
            ],
          ),
        ),
      ),
    );
  }
  RenderPatientdata(screenHeight, screenWidth) {
    return Card(
        elevation: 20,
        child: Container(
          width: screenWidth * 0.95,
          child: ListTile(
            trailing: IconButton(onPressed: (){
              if(department_List.contains(selectedTest)){
                                print('exists');
                                NigDocToast().showErrorToast('Already Added');
                                setState(() {
                                    selectedTest = null;
                                });
                               
                                }else{
                                  department_List.add(selectedTest);
                                  setState(() {
                                    Test = false;
                                    selectedTest = null;
                                  });
                                }

              
            }, icon: Icon(Icons.send,color: custom_color.appcolor,)),
            
            title: Text('${selectedTest['department_name'].toString().toUpperCase()}',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        )
        
        );
  }

  renderPatientAutoComplete(screenHeight, screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Autocomplete<List>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isNotEmpty) {
            var matches = [];
            setState(() {});
            matches.addAll(departmentListList);
            matches.retainWhere((s) {
              return s['department_name']
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
            return [matches];
          } else {
            return const Iterable<List>.empty();
          }
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return Container(
            height: screenHeight * 0.07,
            width: screenWidth * 0.95,
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 1,
                
              ),
            ),
            child: Center(
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: '  Department'),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onChanged: (text) {
                    department1controller.text = text;
                  },
                ),
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
          return options.toList()[0].isNotEmpty
              ? Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: Container(
                      width: screenWidth * 0.95,
                      // height: screenHeight * 0.78,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(5.0),
                          itemCount: options.toList()[0].length,
                          itemBuilder: (BuildContext context, int index) {
                            var option = options.toList()[0].elementAt(index);

                            return ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                      selectedTest= option;
                                  });
                              
                                // // select_test = option;
                                
                                },
                                
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            OutlinedBorder?>(
                                        ContinuousRectangleBorder()),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            custom_color.appcolor)),
                                child: Container(
                                  color: custom_color.appcolor,
                                 
                                  child: Row(
                                    
                                    children: [
                                      SizedBox(
                                        
                                        width: screenWidth * 0.5,
                                        child: Text(
                                            '${options.toList()[0][index]['department_name'].toString().toUpperCase()} ',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                      )
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ),
                    ),
                  ),
                )
              : Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: screenWidth * 0.9,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder?>(
                                ContinuousRectangleBorder()),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                custom_color.appcolor)),
                        child: Container(
                          child: const Text(
                            'Search List Empty',
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                        )),
                  ),
                );
        },
      ),
    );
  }
}
