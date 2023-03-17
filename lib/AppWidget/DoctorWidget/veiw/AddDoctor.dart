import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multiselect/multiselect.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({super.key});

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  TextEditingController docnamecontroller = TextEditingController();
  TextEditingController designationcontroller = TextEditingController();
  TextEditingController professioncontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController mobilenumbercontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController doacontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();
  TextEditingController organisationcontroller = TextEditingController();

  String titleDropdownvalue = 'Dr';
List<String> department = ['Genral','Neuralogy','Occupational Therapy' ];
List<String> selecteddepartment = [];
var userlevel;
  var title = ['Dr'];
  var user = [
    'Admin',
    'Doctor',
  ];
 bool showPassword = false;
  bool showPassword2 = false;

  DateTime currentDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    dobcontroller.text = pickedDate.toString().split(' ')[0];
  }

  DateTime currentdate = DateTime.now();

  Future<void> selectdate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentdate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != currentdate)
      setState(() {
        currentdate = pickedDate;
      });
    doacontroller.text = pickedDate.toString().split(' ')[0];
  }

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
      appBar: AppBar(
        title: Text('Add Doctor'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom:18.0),
                      child: Container(
                        // color: Colors.red,
                        width: screenWidth * 0.26,
                        height: screenHeight * 0.07,
                        decoration:
                            BoxDecoration(border: Border.all(color: Colors.grey)
                                // border: OutlineInputBorder()
                                ),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                              value: titleDropdownvalue,
                              items: title.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  titleDropdownvalue = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.65,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                           autovalidateMode: AutovalidateMode.always,
                          controller: docnamecontroller,
                           validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                    return null;
                  },
        
                          // keyboardType: TextInputType.none,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Doctor Nme'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 2.0, bottom: 2, left: 8, right: 8),
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
                  autovalidateMode: AutovalidateMode.always,
                  controller: professioncontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  // maxLength: 10,
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Professions'),
                ),
              ),
               Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 8, right: 8),
              child: DropDownMultiSelect(
              
                options: department, 
              selectedValues: selecteddepartment, 
              onChanged: (value){
                 setState(() {
                    selecteddepartment = value;
                  });
              },
               whenEmpty: 'Select Department',
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
                        'User Level',
                        // style:
                        //     TextStyle(color: Colors.grey),
                      ),
                    ),
                    // value:' _selectedState[i]',
                    onChanged: (selectedlevel) {
                      userlevel = selectedlevel;
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
                          padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                          child: new Text(item),
                        ),
                        value: item.toString(),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 2, left: 8, right: 8),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  controller: mobilenumbercontroller,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
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
                    const EdgeInsets.only(top: 8.0, bottom: 2, left: 8, right: 8),
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
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 2, left: 8, right: 8),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  controller: citycontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  // maxLength: 10,
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'City'),
                ),
              ),
               Padding(
                padding:
                    const EdgeInsets.only(top:8.0, bottom: 2, left: 8, right: 8),
                child: TextFormField(
                  // autovalidateMode: AutovalidateMode.always,
                  controller: pincodecontroller,
                  keyboardType: TextInputType.number,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return '';
                  //   }
                  //   return null;
                  // },
                  // maxLength: 10,
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Pincode'),
                ),
              ),
           
            Padding(
                padding:
                    const EdgeInsets.only(top: 14.0, bottom: 2, left: 8, right: 8),
                child: TextField(
                  // obscure/Text: true,
                  keyboardType: TextInputType.none,
                  // maxLength: 3,
                  controller: dobcontroller,
                  onTap: () {
                    selectDate(context);
                  },
                  decoration: InputDecoration(
                    labelText: 'Date Of Birth',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 14.0, bottom: 2, left: 8, right: 8),
                child: TextField(
                  // obscure/Text: true,
                  keyboardType: TextInputType.none,
                  // maxLength: 3,
                  controller: doacontroller,
                  onTap: () {
                    selectdate(context);
                  },
                  decoration: InputDecoration(
                    labelText: 'Date Of Anniversery',
                    border: OutlineInputBorder(),
                  ),
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
                      if(docnamecontroller.text.isEmpty){
                         Fluttertoast.showToast(
                          msg: 'Enter Doctor Name',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
                      }
                      else if (designationcontroller.text.isEmpty){
                         Fluttertoast.showToast(
                          msg: 'Enter Designation',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
                      }
                       else if (professioncontroller.text.isEmpty){
                         Fluttertoast.showToast(
                          msg: 'Enter Professions',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
                      }
                       else if (selecteddepartment.isEmpty){
                         Fluttertoast.showToast(
                          msg: 'Enter Department',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
                      }

                       else if (userlevel == null){
                         Fluttertoast.showToast(
                          msg: 'Select User Level',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
                      }
                       else if (mobilenumbercontroller.text.isEmpty){
                         Fluttertoast.showToast(
                          msg: 'Enter Mobile Number',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
                      }
                       else if (mobilenumbercontroller.text.length<10){
                         Fluttertoast.showToast(
                          msg: 'Mobile Number Must Have 10 Digits',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
                      }
                      else if (emailcontroller.text.isEmpty){
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
                                   else if (addresscontroller.text.isEmpty){
                         Fluttertoast.showToast(
                          msg: 'Enter Address',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
                      }
                         else if (citycontroller.text.isEmpty){
                         Fluttertoast.showToast(
                          msg: 'Enter City',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
                      }
                       else if (passcontroller.text.isEmpty){
                         Fluttertoast.showToast(
                          msg: 'Enter Password',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
                      }
                       else if (passcontroller.text.length<6){
                         Fluttertoast.showToast(
                          msg: 'Password Must Atleast 6 Characters',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
                      }
                       else if (confirmpasscontroller.text.isEmpty){
                         Fluttertoast.showToast(
                          msg: 'Confirm Your Password',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0);
                      }
                       else if (passcontroller.text != confirmpasscontroller.text){
                         Fluttertoast.showToast(
                          msg: 'Password Does Not Match',
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
      ),
    );
  }
  togglePasswordView() {
    setState(() {
      showPassword = !showPassword;
      //  showPassword2 = !showPassword2;
    });
  }
}
