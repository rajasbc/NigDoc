import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/veiw/DoctorList.dart';
//import 'package:nigdoc/AppWidget/DoctorWidget/veiw/DoctorList.dart';
import 'package:nigdoc/AppWidget/StaffWidget/veiw/StaffList.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class AddDoctor extends StatefulWidget {
  const AddDoctor({super.key});

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
       TextEditingController titlecontroller = TextEditingController();
       TextEditingController staffnamecontroller = TextEditingController();
       TextEditingController designationcontroller = TextEditingController();
  // ignore: non_constant_identifier_names
       TextEditingController Professionscontroller= TextEditingController();
       TextEditingController mobilecontroller = TextEditingController();
       TextEditingController emailcontroller = TextEditingController();
       TextEditingController addresscontroller = TextEditingController();
       TextEditingController passcontroller = TextEditingController();
       TextEditingController confirmpasscontroller = TextEditingController();
       TextEditingController departmentcontroller= TextEditingController();
       TextEditingController userlevelcontroller = TextEditingController();
       TextEditingController usernamecontroller = TextEditingController();

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
var list=[
        'list1',
        'list2',
        'list3',
        'list4',
        'list5',
];
var selected_item;
var user = [
    'Admin',
    'Doctor',
    'Managers',
    'Staff',
  ];

  bool showPassword = false;
  bool showPassword2 = false;

@override
  bool _passwordVisible = true;
  bool _passwordVisible2 = true;
  void initState() {
    _passwordVisible = true;
    _passwordVisible2 = true;
  }

  @override
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
 return  PopScope(
       canPop:false,
       onPopInvoked:(bool didpop) {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> DoctorList(),)
         );
         
        },
    child: Scaffold(
      appBar: AppBar(title: Text('Add Doctor',style: TextStyle(color: Colors.white),),
      backgroundColor: custom_color.appcolor,
      leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorList(),
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
                           
                            onChanged: (selectedDoctor) {
                              selected_level=selectedDoctor;
                              setState(() {
                               
                              });
                            },
                            items: title.map<DropdownMenuItem<String>>((item) {
                              return new DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 7, left: 8, right: 8),
                                  child: new Text(item,style: TextStyle(fontSize: 16),),
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
                          border: OutlineInputBorder(), labelText: 'Doctor Name *'
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


                   Padding(
                    //padding: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                    child: Container(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.96,
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0)
                         
                          ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: DropdownButtonFormField(
                          decoration: InputDecoration.collapsed(hintText: ''),
                            isExpanded: true,
                            hint: Padding(
                              padding: const EdgeInsets.only(top: 0, left: 2, right: 0),
                              child: Text(
                                'Department *',
                               
                              ),
                            ),
                          
                            onChanged: (selectedDoctor) {
                              selected_Values=selectedDoctor;
                              setState(() {
                               
                              });
                            },
                            items: list.map<DropdownMenuItem<String>>((item) {
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


                   Padding(
                    //padding: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                    child: Container(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.96,
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0)
                         
                          ),
                      child: Padding(
                       
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: DropdownButtonFormField(
                           
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
                            onChanged: (selectedDoctor) {
                              selected_item=selectedDoctor;
                              setState(() {
                              
                              });
                            },
                            items: user.map<DropdownMenuItem<String>>((item) {
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
                      controller: usernamecontroller,
                     
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Username'),
                    ),
                  ),
                   SizedBox(height: screenHeight*0.01,),



                   Padding(
                     padding:
                        const EdgeInsets.only(top: 12, bottom: 2, left: 8, right: 8),
                   child: TextFormField(
                    obscureText: _passwordVisible,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.text,
                    controller: passcontroller,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',

                      suffixIcon: IconButton(
                       icon:Icon(
                        _passwordVisible
                        ?Icons.visibility_off
                        :Icons.visibility,
                        color: custom_color.appcolor,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible=!_passwordVisible;
                          });
                        },
                        )
                    ),
                   ),
                   ),
                    SizedBox(height: screenHeight*0.01,),



                        Padding(
                           padding:
                        const EdgeInsets.only(top: 12.0, bottom: 2, left: 8, right: 8),
                          child: TextFormField(
                            controller: confirmpasscontroller,
                            obscureText: _passwordVisible2,
                            autovalidateMode: AutovalidateMode.always,
                             keyboardType: TextInputType.text,


                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Confirm Password',
                              suffixIcon: IconButton(
                                icon:Icon(
                                  _passwordVisible2
                                  ?Icons.visibility_off
                                  : Icons.visibility,
                                  color: custom_color.appcolor,

                                ),
                                onPressed: (() {
                                  setState(() {
                                    _passwordVisible2=!_passwordVisible2;
                                  });
                                }),
                                 )
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
                                          if(selected_level==null){
                                            NigDocToast().showErrorToast('Please Select Titel');
                               
                                           }else if(staffnamecontroller.text.isEmpty){
                                          NigDocToast().showErrorToast('Please Enter Doctor Name');
                              
                                            }
                                            else if(designationcontroller.text.isEmpty){
                                        NigDocToast().showErrorToast('Please Enter Designation');
                               
                                            }
                                            else if(Professionscontroller.text.isEmpty){
                                        NigDocToast().showErrorToast('Please Enter Professions');
                               
                                            }
                                             else if(selected_Values==null){
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
                                            else if(usernamecontroller.text.isEmpty){
                                        NigDocToast().showErrorToast('Please Enter User Name ');
                              
                                            }
                                            else if(passcontroller.text.isEmpty){
                                        NigDocToast().showErrorToast('Enter Password');
                              
                                            }
                                            else if(confirmpasscontroller.text.isEmpty){
                                        NigDocToast().showErrorToast('Enter Confirm Password');
                                     
                                            }else{
                                                var data={
                                                  "title":titlecontroller.text.toString(),
                                                  "staff":staffnamecontroller.text.toString(),
                                                  "designation":designationcontroller.text.toString(),
                                                  "professions":Professionscontroller.text.toString(),
                                                  "department":departmentcontroller.text.toString(),
                                                  "userlevel":userlevelcontroller.text.toString(),
                                                  "email":emailcontroller.text.toString(),
                                                  "mob no":mobilecontroller.text.toString(),
                                                  "address":addresscontroller.text.toString(),
                                                  "user name":usernamecontroller.text.toString(),
                                                  "pass":passcontroller.text.toString(),
                                                  "confirm pass":confirmpasscontroller.text.toString(),
                            
                                                };
                                                Helper().isvalidElement(data);
                                                print(data);
                                               }
                                              
                                     }, child: Text('Save',style: TextStyle(color:Colors.white,fontSize: 20),)),
                          ),
                        ),SizedBox(height: screenHeight*0.05,),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
