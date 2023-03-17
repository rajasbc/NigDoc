import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  TextEditingController staffnamecontroller = TextEditingController();
  TextEditingController designationcontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();

var selectedlevel;
var user = [
    'Admin',
    'Doctor',
    'Managers',
    'Staff',
  ];
bool showPassword = false;
  bool showPassword2 = false;

@override
  bool _passwordVisible = false;
  bool _passwordVisible2 = false;
  void initState() {
    _passwordVisible = false;
    _passwordVisible2 = false;
  }

  @override
  Widget build(BuildContext context) {
     var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('Add User'),),
      body: SingleChildScrollView(
        child: Column(
          children: [
             Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 2, left: 8, right: 8),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    controller: staffnamecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                    // maxLength: 10,
                    // keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Staff Name'),
                  ),
                ),
                 Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 2, left: 8, right: 8),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    controller: designationcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                    // maxLength: 10,
                    // keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Designation'),
                  ),
                ),
                 Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 2, left: 8, right: 8),
                  child: TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.always,
                    controller: mobilecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                    // maxLength: 10,
                    // keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Mobile Number'),
                  ),
                ),
                 Padding(
                  padding:
                      const EdgeInsets.only(top: 2.0, bottom: 2, left: 8, right: 8),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                    // maxLength: 10,
                    // keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Email Id'),
                  ),
                ),
                 Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 2, left: 8, right: 8),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    controller: addresscontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                    // maxLength: 10,
                    // keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Address'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.95,
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey)
                        // border: OutlineInputBorder()
                        ),
                    child: DropdownButtonFormField(
                      // validator: (value) => validateDrops(value),
                      // isExpanded: true,
                      decoration: InputDecoration.collapsed(hintText: ''),
                      isExpanded: true,
                      hint: Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                        child: Text(
                          'Select User Level',
                          style:
                              TextStyle(color: Colors.red),
                        ),
                      ),
                      // value:' _selectedState[i]',
                      onChanged: (selecteddoctor) {
                        selectedlevel=selecteddoctor;
                        setState(() {
                          // selectedDoctor = selectedDoctor;
                          // print("Stae value");
                          // print(newValue);
                          // _selectedState[i]= newValue;
                          // getMyDistricts(newValue, i);
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
                 Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, bottom: 2, left: 8, right: 8),
                  child: TextFormField(
                    // autovalidateMode: AutovalidateMode.always,
                    controller: usernamecontroller,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return '';
                    //   }
                    //   return null;
                    // },
                    // maxLength: 10,
                    // keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'User Name'),
                  ),
                ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: TextFormField(
                          keyboardType: TextInputType.text,
                          // autovalidateMode: AutovalidateMode.always,
                          controller: passcontroller,
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return '';
                          //   } else if (value.length >= 1 && value.length < 6) {
                          //     return 'More Than 6 Characters';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          obscureText:
                              !_passwordVisible, //This will obscure text dynamically
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Password',
                            // Here is key idea
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                 ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          // autovalidateMode: AutovalidateMode.always,
                          controller: confirmpasscontroller,
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return '';
                          //   } else if (value.length >= 1 && value.length < 6) {
                          //     return 'More Than 6 Characters';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          obscureText:
                              !_passwordVisible2, //This will obscure text dynamically
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: 'Confirm Password',
                            // Here is key idea
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible2 = !_passwordVisible2;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(onPressed: (){
      if(staffnamecontroller.text.isEmpty){
    Fluttertoast.showToast(
                          msg: 'Enter Staff Name',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
      }
      else if(designationcontroller.text.isEmpty){
          Fluttertoast.showToast(
                          msg: 'Enter Designation',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
      }
      else if(mobilecontroller.text.isEmpty){
          Fluttertoast.showToast(
                          msg: 'Enter Mobile Number',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
      }
       else if(mobilecontroller.text.length<10){
          Fluttertoast.showToast(
                          msg: 'Mobile Number Must Have 10 Digits',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
      }
      else if(emailcontroller.text.isEmpty){
          Fluttertoast.showToast(
                          msg: 'Enter Your Email Id',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
      }
      else if (!emailcontroller.text
                                        .contains('@') ||
                                    !emailcontroller.text.contains('.') ||
                                    !emailcontroller.text.contains('com')) {
                                  Fluttertoast.showToast(
                                      msg: 'Enter Valid Email Id',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
      else if(addresscontroller.text.isEmpty){
          Fluttertoast.showToast(
                          msg: 'Enter Address',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
      }
      else if(selectedlevel==null){
          Fluttertoast.showToast(
                          msg: 'Select User Level',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
      }
      else if(usernamecontroller.text.isEmpty){
          Fluttertoast.showToast(
                          msg: 'Enter User Name',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
      }
      else if(passcontroller.text.isEmpty){
          Fluttertoast.showToast(
                          msg: 'Enter Password',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
      }
      else if(confirmpasscontroller.text.isEmpty){
          Fluttertoast.showToast(
                          msg: 'Confirm Your Password',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
      }
      else if(passcontroller.text != confirmpasscontroller.text){
          Fluttertoast.showToast(
                          msg: 'Passwords Does Not match',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
      }
                      }, child: Text('Save'))
          ],
        ),
      ),
    );
  }
}
