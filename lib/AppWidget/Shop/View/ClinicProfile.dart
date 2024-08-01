import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/Shop/View/EditClincProfile.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../../AppWidget/common/Colors.dart'as custom_color;

class ClinicProfile extends StatefulWidget {
  const ClinicProfile({super.key});

  @override
  State<ClinicProfile> createState() => _ClinicProfileState();
}

class _ClinicProfileState extends State<ClinicProfile> {
  final LocalStorage storage = new LocalStorage('doctor_store');
 TextEditingController shopnameController = TextEditingController();
  TextEditingController shopshortnameController = TextEditingController();
  TextEditingController dlnoController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController emailidController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController statecodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController altermobileController = TextEditingController();
  TextEditingController landlineController = TextEditingController();
  TextEditingController shoptypeController = TextEditingController();
  TextEditingController clinicRegnumberController = TextEditingController();

  String shopDropdownvalue = '';
  bool isLoading =true;
  bool isSwitched = false;
  var userResponse;
  var accesstoken;
  var profile ;
  var list;
  var shop = [
    'Select Shop',
  ];

  String titleDropdownvalue = 'Shop Type';

  var title = [
    'Head',
    'Branch',
  ];

  String barcode = 'no';
  // XFile? image;

  @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];
    // getMediAndLabNameList();
    int();
    
    
    // TODO: implement initState
    super.initState();
    
  }
  int()async{
  await geProfile();
   await shopInfo();
  }
   

  // final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  // Future getImage(ImageSource media) async {
  //   var img = await picker.pickImage(source: media);
    
  //   setState(() {
  //     image = img;
  //   });
  // }

  //show popup dialog
  // void myAlert() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //           title: Text('Please choose media to select'),
  //           content: Container(
  //             height: MediaQuery.of(context).size.height / 6,
  //             child: Column(
  //               children: [
  //                 ElevatedButton(
  //                   //if user click this button, user can upload image from gallery
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                     getImage(ImageSource.gallery);
  //                   },
  //                   child: Row(
  //                     children: [
  //                       Icon(Icons.image),
  //                       Text('From Gallery'),
  //                     ],
  //                   ),
  //                 ),
  //                 ElevatedButton(
  //                   //if user click this button. user can upload image from camera
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                     getImage(ImageSource.camera);
  //                   },
  //                   child: Row(
  //                     children: [
  //                       Icon(Icons.camera),
  //                       Text('From Camera'),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 50;
    double screenWidth = MediaQuery.of(context).size.width;
    return new WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Setting()),
        );
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor:custom_color.appcolor,
            title: const Text(
              'Clinic Profile ',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Setting()),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )) ,
            iconTheme: IconThemeData(color: Colors.white),
            // actions: [
            //   IconButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => Setting()),
            //         );
            //       },
            //       icon: Icon(
            //         Icons.people_alt_outlined,
            //         color: Colors.black,
            //       )),
            // ],
          ),
        ),
        body:isLoading ? Container(
          height: screenHeight,
          width: screenWidth,
          // color: Colors.red,

          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Container(
                  //   height: screenHeight * 0.27,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage("assets/Shop.jpg"),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            //  border:  Border.all(width: 2, color:custom_color.app_color1 ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: screenHeight * 0.07,
                                    child: Image.asset('assets/profile.png'),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    // color: Colors.amberAccent,
                                    //  height: screenHeight * 0.06,
                                    width: screenWidth * 0.6,
                                    child: TextFormField(
                            decoration: const InputDecoration(
                               border: InputBorder.none,
                            ),
                            // autovalidateMode: AutovalidateMode.always,
                            readOnly: true,
                            controller: shopnameController,
                            // validator: (value) {
                            //   if(value == null || value.isEmpty) {
                            //     return "";
                            //   }
                            //   return null;
                            // },
                          ),
                                    // child: DropdownButtonFormField(
                                    //   // Initial Value
                                    //   decoration: const InputDecoration(
                                    //     // border: OutlineInputBorder(),
                                    //     labelText: '',
                  
                                    //     //icon: Icon(Icons.numbers),
                                    //   ),
                                    //   hint: Text("Select Shop"),
                  
                                    //   items: shop.map((String items) {
                                    //     return DropdownMenuItem(
                                    //       value: items,
                                    //       child: Text(items),
                                    //     );
                                    //   }).toList(),
                                    //   // After selecting the desired option,it will
                                    //   // change button value to selected value
                                    //   onChanged: (String? newValue) {
                                    //     setState(() {
                                    //       shopDropdownvalue = newValue!;
                                    //     });
                                    //   },
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // SizedBox(
                        //   child: TextFormField(
                        //     decoration: const InputDecoration(
                        //       border: OutlineInputBorder(),
                        //       labelText: "Shop Name*",
                        //     ),
                        //     // autovalidateMode: AutovalidateMode.always,
                        //     readOnly: true,
                        //     controller: shopnameController,
                        //     // validator: (value) {
                        //     //   if(value == null || value.isEmpty) {
                        //     //     return "";
                        //     //   }
                        //     //   return null;
                        //     // },
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        SizedBox(
                          child: TextFormField(
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Shop Short Name",
                            ),
                            // autovalidateMode: AutovalidateMode.always,
                            controller: shopshortnameController,
                            readOnly: true,
                            
                            // validator: (value) {
                            //   if(value == null || value.isEmpty) {
                            //     return "";
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: TextFormField(
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Clinic Registration Number",
                            ),
                            // autovalidateMode: AutovalidateMode.always,
                            controller: clinicRegnumberController,
                            readOnly: true,
                            
                            // validator: (value) {
                            //   if(value == null || value.isEmpty) {
                            //     return "";
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: TextFormField(
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "DL NO",
                            ),
                            // autovalidateMode: AutovalidateMode.always,
                            controller: dlnoController,
                            readOnly: true,
                            // validator: (value) {
                            //   if(value == null || value.isEmpty) {
                            //     return "";
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: TextFormField(
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Shop GST No",
                            ),
                            // autovalidateMode: AutovalidateMode.always,
                            readOnly: true,
                            controller: gstController,
                            // validator: (value) {
                            //   if(value == null || value.isEmpty) {
                            //     return "";
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // SizedBox(
                        //   child: TextFormField(
                        //     enabled: false,
                        //     decoration: const InputDecoration(
                        //       border: OutlineInputBorder(),
                        //       labelText: "Email Id",
                        //     ),
                        //     // autovalidateMode: AutovalidateMode.always,
                        //     readOnly: true,
                        //     controller: emailidController,
                        //     // validator: (value) {
                        //     //   if(value == null || value.isEmpty) {
                        //     //     return "";
                        //     //   }
                        //     //   return null;
                        //     // },
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth*0.42,
                              child: TextFormField(
                                enabled: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Address Line1",
                                ),
                                // autovalidateMode: AutovalidateMode.always,
                                controller: address1Controller,
                                readOnly: true,
                                // validator: (value) {
                  
                                //   if(value == null || value.isEmpty) {
                                //     return "";
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                            // SizedBox(height: 10,),
                            SizedBox(
                              width: screenWidth*0.06,
                            ),
                            SizedBox(
                              width: screenWidth*0.42,
                              child: TextFormField(
                                enabled: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Address Line2",
                                ),
                                // autovalidateMode: AutovalidateMode.always,
                                controller: address2Controller,
                                readOnly: true,
                                // validator: (value) {
                                //   if(value == null || value.isEmpty) {
                                //     return "";
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                               width: screenWidth*0.42,
                              child: TextFormField(
                                enabled: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Area",
                                ),
                                // autovalidateMode: AutovalidateMode.always,
                                controller: areaController,
                                readOnly: true,
                                // validator: (value) {
                                //   if(value == null || value.isEmpty) {
                                //     return "";
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                            // SizedBox(height: 10,),
                            SizedBox(
                               width: screenWidth*0.06,
                            ),
                            SizedBox(
                               width: screenWidth*0.42,
                              child: TextFormField(
                                enabled: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "City",
                                ),
                                // autovalidateMode: AutovalidateMode.always,
                                controller: cityController,
                                readOnly: true,
                                // validator: (value) {
                                //   if(value == null || value.isEmpty) {
                                //     return "";
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                               width: screenWidth*0.42,
                              child: TextFormField(
                                enabled: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "State",
                                ),
                                // autovalidateMode: AutovalidateMode.always,
                                controller: stateController,
                                readOnly: true,
                                // validator: (value) {
                                //   if(value == null || value.isEmpty) {
                                //     return "";
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                            // SizedBox(height: 10,),
                            SizedBox(
                               width: screenWidth*0.06,
                            ),
                            // SizedBox(
                            //   width: 185,
                            //   child: TextFormField(
                            //     enabled: false,
                            //     decoration: const InputDecoration(
                            //       border: OutlineInputBorder(),
                            //       labelText: "State Code",
                            //     ),
                            //     // autovalidateMode: AutovalidateMode.always,
                            //     controller: statecodeController,
                            //     readOnly: true,
                            //     // validator: (value) {
                            //     //   if(value == null || value.isEmpty) {
                            //     //     return "";
                            //     //   }
                            //     //   return null;
                            //     // },
                            //   ),
                            // ),
                            SizedBox(
                              width: screenWidth*0.42,
                              child: TextFormField(
                                enabled: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Country",
                                ),
                                // autovalidateMode: AutovalidateMode.always,
                                controller: countryController,
                                readOnly: true,
                                // validator: (value) {
                                //   if(value == null || value.isEmpty) {
                                //     return "";
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // SizedBox(
                        //   width: 5,
                        // ),
                        SizedBox(
                          width: screenWidth*0.94,
                          child: TextFormField(
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Pincode",
                            ),
                            keyboardType: TextInputType.number,
                            // maxLength: 6,
                            // autovalidateMode: AutovalidateMode.always,
                            controller: pincodeController,
                            readOnly: true,
                            // validator: (value) {
                            //   if(value == null || value.isEmpty) {
                            //     return "";
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: TextFormField(
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Mobile Number*",
                            ),
                            autovalidateMode: AutovalidateMode.always,
                            controller: mobileController,
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            maxLength: 10,
                            // validator: (value) {
                            //   if(value == null || value.isEmpty) {
                            //     return "";
                            //   }
                            //  else if (value.length >= 1 && value.length <= 9) {
                            //     return 'Mobile.No Must Contain 10 Digits';
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: TextFormField(
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Alternative Mobile Number",
                            ),
                            autovalidateMode: AutovalidateMode.always,
                            controller: altermobileController,
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            // validator: (value) {
                            //   if(value == null || value.isEmpty) {
                            //     return "";
                            //   }
                            //  else if (value.length >= 1 && value.length <= 9) {
                            //     return 'Mobile.No Must Contain 10 Digits';
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: TextFormField(
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Landline Number",
                            ),
                            autovalidateMode: AutovalidateMode.always,
                            controller: landlineController,
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            // maxLength: 10,
                            // validator: (value) {
                            //   if(value == null || value.isEmpty) {
                            //     return "";
                            //   }
                            //  else if (value.length >= 1 && value.length <= 9) {
                            //     return 'Mobile.No Must Contain 10 Digits';
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: TextFormField(
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Clinic Type",
                            ),
                            autovalidateMode: AutovalidateMode.always,
                            controller: shoptypeController,
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            // maxLength: 10,
                            // validator: (value) {
                            //   if(value == null || value.isEmpty) {
                            //     return "";
                            //   }
                            //  else if (value.length >= 1 && value.length <= 9) {
                            //     return 'Mobile.No Must Contain 10 Digits';
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width,
                        //   child: DropdownButtonFormField(
                        //     // Initial Value
                        //     decoration: const InputDecoration(
                        //       border: OutlineInputBorder(),
                        //       labelText: 'Shop Type',
                        //       //icon: Icon(Icons.numbers),
                        //     ),
                  
                        //     items: title.map((String items) {
                        //       return DropdownMenuItem(
                        //         value: items,
                        //         child: Text(items),
                        //       );
                        //     }).toList(),
                        //     // After selecting the desired option,it will
                        //     // change button value to selected value
                        //     onChanged: (String? newValue) {
                        //       setState(() {
                        //         titleDropdownvalue = newValue!;
                        //       });
                        //     },
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        // Container(
                        //     child: Row(
                        //       children: [
                        //         Container(
                        //           // color: Colors.grey,
                        //           width: screenWidth * 0.2,
                        //           child: Text(
                        //             "  Barcode",
                        //             style: TextStyle(fontSize: 18),
                        //           ),
                        //         ),
                        //         // Switch(
                        //         //         value: isSwitched,
                        //         //         onChanged: (value) {
                        //         //           setState(() {
                        //         //             isSwitched = value;
                        //         //             print(isSwitched);
                        //         //           });
                        //         //         },
                        //         //         activeTrackColor:
                        //         //             Colors.lightGreenAccent,
                        //         //         activeColor: Colors.green,
                        //         //       ),
                        //         Container(
                        //           // color: Colors.blue,
                        //           width: screenWidth * 0.33,
                        //           child: RadioListTile(
                        //             title: Text("Yes"),
                        //             value: "yes",
                        //             groupValue: barcode,
                        //             onChanged: (value) {
                        //               value = barcode;
                        //               setState(() {
                        //                 barcode = value.toString();
                        //               });
                        //             },
                        //           ),
                        //         ),
                        //         Container(
                        //           // color: Colors.amber,
                        //           width: screenWidth * 0.3,
                        //           child: RadioListTile(
                        //             title: Text("No"),
                        //             value: "no",
                        //             groupValue: barcode,
                        //             onChanged: (value) {
                        //               value = barcode;
                        //               setState(() {
                        //                 barcode = value.toString();
                        //               });
                        //             },
                        //           ),
                        //         ),
                        //       ],
                        //     )),
                        // Container(
                        //     child: Column(
                        //   children: [
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //       children: [
                        //         Container(
                        //           // color: Colors.grey,
                        //           width: screenWidth * 0.3,
                        //           child: Text(
                        //             "Shop Logo",
                        //             style: TextStyle(fontSize: 18),
                        //           ),
                        //         ),
                        //         Container(
                        //           // color: Colors.blue,
                        //           width: screenWidth * 0.25,
                        //           // child: TextButton(
                        //           //   onPressed: () {
                        //           //     // Navigator.push(
                        //           //     //     context,
                        //           //     //     MaterialPageRoute(
                        //           //     //       builder:
                        //           //     //           (context) =>
                        //           //     //               Dashboard(),
                        //           //     //     ));
                        //           //   },
                        //           //   child: Text(
                        //           //     "Choose File",
                        //           //     style: TextStyle(
                        //           //       color: Colors.white,
                        //           //     ),
                        //           //   ),
                        //           //   style: ButtonStyle(
                        //           //     backgroundColor:
                        //           //         WidgetStateProperty.all<Color>(
                        //           //             Colors.grey),
                        //           //     shape: WidgetStateProperty.all<
                        //           //         RoundedRectangleBorder>(
                        //           //       RoundedRectangleBorder(
                        //           //         borderRadius: BorderRadius.circular(0.0),
                        //           //         side: BorderSide(color: Colors.black),
                        //           //       ),
                        //           //     ),
                        //           //   ),
                        //           // ),
                  
                        //           child: ElevatedButton(
                        //             onPressed: () {
                        //               myAlert();
                        //             },
                        //             child: Text('Upload Photo'),
                        //           ),
                        //           // SizedBox(
                        //           //   height: 10,
                        //           // ),
                        //           //if image not null show the image
                        //           //if image null show text
                        //         ),
                        //         SizedBox(
                        //           width: 3,
                        //         ),
                        //         // Container(
                        //         //   // color: Colors.amber,
                        //         //   width: screenWidth * 0.3,
                        //         //   child: Text(
                        //         //     " No file chosen",
                        //         //     style: TextStyle(fontSize: 18),
                        //         //   ),
                        //         // ),
                        //         Helper().isvalidElement(image)
                        //             ? ElevatedButton(
                        //                 onPressed: () {
                        //                   setState(() {
                        //                     image = null;
                        //                   });
                        //                 },
                        //                 child: Text('cancel'),
                        //               )
                        //             : Container(),
                        //       ],
                        //     ),
                        //   ],
                        // )),
                        // image != null
                        //     ? Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //           horizontal: 50,
                        //         ),
                        //         child: ClipRRect(
                        //           borderRadius: BorderRadius.circular(8),
                        //           child: Image.file(
                        //             //to show image, you type like this.
                        //             File(image!.path),
                        //             fit: BoxFit.cover,
                        //             width: MediaQuery.of(context).size.width,
                        //             height: 300,
                        //           ),
                        //         ),
                        //       )
                        //     : Text(
                        //         "No Image",
                        //         style: TextStyle(fontSize: 20),
                        //       ),
                        SizedBox(
                          height: 20,
                        ),
                                                // Container(
                        //   height: screenHeight * 0.06,
                        //   width: screenWidth * 0.7,
                        //   // color:Colors.blueAccent,
                        //   child: TextButton(
                        //     onPressed: () {
                        //       var list={
                        //         'shopname':shopnameController.text,
                  
                        //       };
                  
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => Dashboard(),
                        //           ));
                        //     },
                        //     child: Text(
                        //       "Update",
                        //       style: TextStyle(
                        //           color: Colors.white, fontWeight: FontWeight.bold),
                        //     ),
                        //     style: ButtonStyle(
                        //       backgroundColor: WidgetStateProperty.all<Color>(
                        //           Color.fromARGB(255, 8, 122, 135)),
                        //       shape:
                        //           WidgetStateProperty.all<RoundedRectangleBorder>(
                        //         RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(50.0),
                        //           side: BorderSide(
                        //               color: Color.fromARGB(255, 8, 122, 135)),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ): Center(child:  SpinLoader(),),

         floatingActionButton: FloatingActionButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_ClinicProfile(select_profile : list)));
              
        
        },
        
        child: Icon(Icons.edit,color: Colors.white,size: 30,),
        backgroundColor: custom_color.appcolor,),
      ),
    );
  }

  shopInfo(){
    list = profile[0];
  
    print(list);
    setState((){
       shopnameController.text =Helper().isvalidElement(list['name'])? list['name'].toString():'';
       shopshortnameController.text = Helper().isvalidElement(list['shop_short_name'])? list['name'].toString():'';
       dlnoController.text = Helper().isvalidElement(list['dl_no'])? list['dl_no'].toString():'';
       gstController.text = Helper().isvalidElement(list['shop_gst_no'])? list['shop_gst_no'].toString():'';
       emailidController.text = Helper().isvalidElement(list['email'])? list['email'].toString():'';
       address1Controller.text = Helper().isvalidElement(list['address1'])? list['address1'].toString():'';
       address2Controller.text = Helper().isvalidElement(list['address2'])? list['address2'].toString():'';
       areaController.text =Helper().isvalidElement(list['area'])? list['area'].toString():''; 
       cityController.text = Helper().isvalidElement(list['city'])? list['city'].toString():'';
       stateController.text =  Helper().isvalidElement(list['state'])? list['state'].toString():'';
       statecodeController.text =  Helper().isvalidElement(list['state_code'])? list['state_code'].toString():'';
       countryController.text =  Helper().isvalidElement(list['country'])? list['country'].toString():'';
       pincodeController.text = Helper().isvalidElement(list['pincode'])? list['pincode'].toString():'';
       mobileController.text =Helper().isvalidElement(list['mobile_no'])? list['mobile_no'].toString():''; 
       altermobileController.text =Helper().isvalidElement(list['alt_mobile_no'])? list['alt_mobile_no'].toString():''; 
       landlineController.text = Helper().isvalidElement(list['landline_no'])? list['landline_no'].toString():'';
       barcode = Helper().isvalidElement(list['barcode'])? list['barcode'].toString().toLowerCase():'';
       shoptypeController.text =  Helper().isvalidElement(list['shop_type'])? list['shop_type'].toString():'';
       clinicRegnumberController.text =  Helper().isvalidElement(list['register_id'])? list['register_id'].toString():'';
      isLoading=true;
      // isSwitched=Helper().isvalidElement(list['barcode'])&&list['barcode'].toString().toLowerCase()=='no'?false:true ;
    });
  }
  geProfile() async {
   
    var List = await PatientApi().getProfile(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        profile = List['list'];
        print(profile);
        isLoading=true;
        // var values = MediAndLabNameList;
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }
}