import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Dashboardpage.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/Api.dart';
import 'package:nigdoc/AppWidget/LoginWidget/Api.dart';
import 'package:nigdoc/AppWidget/LoginWidget/veiw/Loginpage.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineList.dart';
import 'package:nigdoc/AppWidget/StaffWidget/Referral/EditReferral.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController clinicnamecontroller = TextEditingController();
  TextEditingController doctornamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController mobilenocontroller = TextEditingController();
  TextEditingController alternativecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();
  TextEditingController address1controller = TextEditingController();
  TextEditingController address2controller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController countrycontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  //TextEditingController generalphysiciancontroller = TextEditingController();

  final FocusNode clinicnameFocusNode = FocusNode();
  final FocusNode doctornmeFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode mobileFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmFocusNode = FocusNode();
  final FocusNode address1FocusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();
  final FocusNode stateFocusNode = FocusNode();
  final FocusNode countryFocusNode = FocusNode();
  final FocusNode pincodeFocusNode = FocusNode();
  final LocalStorage storage = new LocalStorage('doctor_store');
  var access_token;
  var userResponse;
  bool _passwordVisible1 = true;
  bool _passwordVisible2 = true;
  bool? ischecked = false;

  final Uri Privacy = Uri.parse("https://nigdoc.com/privacy.php");

  final Uri Terms = Uri.parse("https://nigdoc.com/termsCondition.php");

  // Future<void>launcherPrivacyUri()async{
  //   try{
  //     await launchUrl(Privacy);
  //   }catch(err){

  //   }
  // }
  Future<void> launcherPrivacyUri() async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      Privacy,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        Privacy,
        mode: LaunchMode.inAppBrowserView,
      );
    }
  }

  Future<void> launcherTermsUri() async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      Terms,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        Terms,
        mode: LaunchMode.inAppBrowserView,
      );
    }
  }

  bool isloading = false;
  late SharedPreferences pref;
  @override
  void initState() {
    init();
    // TODO: implement initState
    super.initState();
  }

  init() async {
    pref = await SharedPreferences.getInstance();
  }

  var select_general = 'Genral Physician';
  var item = {
    'Cardiology',
    'ENT',
    'Gastroenterology',
    'Gynaecology',
    'Haematology',
    'Pediatrics',
    'Neurology',
    'Oncology',
    'Opthalmology',
    'Urology',
    'General Physician',
  };

  void dispose() {
    clinicnameFocusNode.dispose();
    doctornmeFocusNode.dispose();
    emailFocusNode.dispose();
    mobileFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmFocusNode.dispose();
    address1FocusNode.dispose();
    cityFocusNode.dispose();
    stateFocusNode.dispose();
    countryFocusNode.dispose();
    pincodeFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didpop) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Loginpage(),
            ));
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: custom_color.appcolor,
          title: Text(
            'Sign Up',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Loginpage(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // SizedBox(height: screenHeight*0.01),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                // child:
                TextFormField(
                  controller: clinicnamecontroller,
                  focusNode: clinicnameFocusNode,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    hintText: 'Clinic Name',
                  ),
                ),
                // ),

                SizedBox(
                  height: screenHeight * 0.01,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                // child:
                TextFormField(
                  controller: doctornamecontroller,
                  focusNode: doctornmeFocusNode,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    hintText: 'Doctor Name',
                  ),
                ),
                // ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                // child:
                TextFormField(
                  controller: emailcontroller,
                  focusNode: emailFocusNode,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    hintText: 'Email Id',
                  ),
                ),
                // ),
                SizedBox(height: screenHeight * 0.01),
                //  Row(

                //    children: [

                Container(
                  width: screenWidth,
                  //  child: Padding(
                  //    padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLength: 10,
                    // inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      //  border: OutlineInputBorder(),
                      labelText: 'Mobile No',
                      counterText: "",
                    ),
                    controller: mobilenocontroller,
                    focusNode: mobileFocusNode,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    ],
                  ),
                  //  ),
                ),

                //  SizedBox(width: screenWidth*0.02,),

                //  Container(
                //    width: screenWidth*0.46,
                //   child: TextField(
                //     keyboardType: TextInputType.number,
                //     inputFormatters: [LengthLimitingTextInputFormatter(10)],
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Alternative No'
                //     ),
                //     controller: alternativecontroller,
                //   ),
                //  )

                //    ],
                //  ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.46,
                      //  child: Padding(
                      //    padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        obscureText: _passwordVisible1,
                        //autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                            //  border: OutlineInputBorder(),
                            labelText: ' Enter Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible1
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: custom_color.appcolor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible1 = !_passwordVisible1;
                                });
                              },
                            )),
                        controller: passwordcontroller,
                        focusNode: passwordFocusNode,
                      ),
                    ),
                    //  ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    Container(
                      width: screenWidth * 0.47,
                      child: TextField(
                        obscureText: _passwordVisible2,
                        //autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            labelText: 'Confirm Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: custom_color.appcolor,
                              ),
                              onPressed: (() {
                                setState(() {
                                  _passwordVisible2 = !_passwordVisible2;
                                });
                              }),
                            )),
                        controller: confirmpasscontroller,
                        focusNode: confirmFocusNode,
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.46,
                      //  child: Padding(
                      //    padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            //  border: OutlineInputBorder(),
                            labelText: 'Address 1'),
                        controller: address1controller,
                        focusNode: address1FocusNode,
                      ),
                    ),
                    //  ),

                    SizedBox(
                      width: screenWidth * 0.02,
                    ),

                    Container(
                      width: screenWidth * 0.47,
                      child: TextField(
                        decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            labelText: 'Address 2'),
                        controller: address2controller,
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.46,
                      //  child: Padding(
                      //    padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            //  border: OutlineInputBorder(),
                            labelText: 'City'),
                        controller: citycontroller,
                        focusNode: cityFocusNode,
                      ),
                    ),
                    //  ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    Container(
                      width: screenWidth * 0.47,
                      child: TextField(
                        decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            labelText: 'State'),
                        controller: statecontroller,
                        focusNode: stateFocusNode,
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.47,
                      //  child: Padding(
                      //    padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            //  border: OutlineInputBorder(),
                            labelText: 'Country'),
                        controller: countrycontroller,
                        focusNode: countryFocusNode,
                      ),
                    ),
                    //  ),

                    SizedBox(
                      width: screenWidth * 0.01,
                    ),

                    Container(
                      width: screenWidth * 0.47,
                      child: TextField(
                        // inputFormatters: [LengthLimitingTextInputFormatter(6)],
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // border: OutlineInputBorder(),
                          labelText: 'Pincode',
                          counterText: "",
                        ),
                        controller: pincodecontroller,
                        focusNode: pincodeFocusNode,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                        ],
                      ),
                    )
                  ],
                ),
                // SizedBox(height: screenHeight*0.02,),

                //  TextFormField(
                //   controller: generalphysiciancontroller,
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //      labelText: 'General Physician'
                //   ),
                //  ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                // child:
                SizedBox(height: screenHeight * 0.01),
                Container(
                  height: screenHeight * 0.08,
                  // width: screenWidth * 0.98,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      // border: OutlineInputBorder(),
                      labelText: select_general,
                    ),
                    isExpanded: true,
                    onChanged: (medicine) {
                      select_general = select_general;
                      setState(() {});
                    },
                    items: item.map<DropdownMenuItem<String>>((item) {
                      return new DropdownMenuItem(
                        child: new Text(
                          item,
                          style: TextStyle(fontSize: 15),
                        ),
                        value: item.toString(),
                      );
                    }).toList(),
                  ),
                ),
                // ),
                //  SizedBox(height: screenHeight*0.02,),

                Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Checkbox(
                                value: ischecked,
                                activeColor: Colors.blue,
                                onChanged: (newbool) {
                                  setState(() {
                                    ischecked = newbool;
                                  });
                                }),
                          ),
                          Container(
                            child: Text(
                              'I agree to the',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          Container(
                            child: TextButton(
                                onPressed: () {
                                  // const string_uri ="https:nigdoc.com/privacy.php";
                                  launcherPrivacyUri();
                                },
                                child: Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                          Container(
                            child: Text(
                              'and',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: TextButton(
                                onPressed: () async {
                                  launcherTermsUri();
                                },
                                child: Text(
                                  'Terms of Use',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Container(
                  width: screenWidth*0.70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                custom_color.appcolor),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        onPressed: () async {
                          if (clinicnamecontroller.text.isEmpty) {
                            clinicnameFocusNode.requestFocus();
                            NigDocToast().showErrorToast('Enter Clinic Name');
                          } else if (doctornamecontroller.text.isEmpty) {
                            doctornmeFocusNode.requestFocus();
                            NigDocToast().showErrorToast('Enter Doctor Name');
                          } else if (!emailcontroller.text.contains('@') ||
                              !emailcontroller.text.contains('.') ||
                              !emailcontroller.text.contains('com')) {
                            emailFocusNode.requestFocus();
                            NigDocToast().showErrorToast("Enter Your Email Id");
                          } else if (mobilenocontroller.text.isEmpty) {
                            mobileFocusNode.requestFocus();
                            NigDocToast()
                                .showErrorToast('Enter Your Mobile No');
                          } else if (mobilenocontroller.text.isNotEmpty &&
                              mobilenocontroller.text.length < 10) {
                            mobileFocusNode.requestFocus();
                            NigDocToast().showErrorToast(
                                'Please Enter the valid Mobile No');
                          } else if (passwordcontroller.text.isEmpty) {
                            passwordFocusNode.requestFocus();
                            NigDocToast().showErrorToast('Enter Your Password');
                          } else if (passwordcontroller.text.length < 6) {
                            passwordFocusNode.requestFocus();
                            NigDocToast().showErrorToast(
                                'Please Enter Your Password Maximum Six Digit');
                          } else if (confirmpasscontroller.text.isEmpty) {
                            confirmFocusNode.requestFocus();
                            NigDocToast()
                                .showErrorToast('Enter Confirm Password');
                          } else if (confirmpasscontroller.text !=
                              passwordcontroller.text) {
                            confirmFocusNode.requestFocus();
                            NigDocToast().showErrorToast(
                                'password and Confirm Password mismatch');
                          } else if (address1controller.text.isEmpty) {
                            address1FocusNode.requestFocus();
                            NigDocToast()
                                .showErrorToast('Enter Your Address 1');
                          } else if (citycontroller.text.isEmpty) {
                            cityFocusNode.requestFocus();
                            NigDocToast().showErrorToast('Enter Your City');
                          } else if (statecontroller.text.isEmpty) {
                            stateFocusNode.requestFocus();
                            NigDocToast().showErrorToast('Enter Your State');
                          } else if (countrycontroller.text.isEmpty) {
                            countryFocusNode.requestFocus();
                            NigDocToast().showErrorToast('Enter Your Country');
                          } else if (pincodecontroller.text.isEmpty) {
                            pincodeFocusNode.requestFocus();
                            NigDocToast().showErrorToast('Enter Your Pincode');
                          } else if (pincodecontroller.text.isNotEmpty &&
                              pincodecontroller.text.length < 6) {
                            pincodeFocusNode.requestFocus();
                            NigDocToast().showErrorToast(
                                'Please Enter the valid Pincode');
                          } else if (select_general == null) {
                            NigDocToast()
                                .showErrorToast('Select General Physician');
                          } else if (ischecked == false) {
                            NigDocToast().showErrorToast(
                                'Please Agree the Privacy Policy and Terms of Use');
                          } else {
                            var data = {
                              "name": clinicnamecontroller.text.toString(),
                              "doctor_name":
                                  doctornamecontroller.text.toString(),
                              "email": emailcontroller.text.toString(),
                              "contact_no": mobilenocontroller.text.toString(),
                              "alt_mobile_no":
                                  alternativecontroller.text.toString(),
                              "password": passwordcontroller.text.toString(),
                              //"confirm":confirmpasscontroller.text.toString(),
                              "address1": address1controller.text.toString(),
                              "address2": address2controller.text.toString(),
                              "city": citycontroller.text.toString(),
                              "state": statecontroller.text.toString(),
                              "country": countrycontroller.text.toString(),
                              "pincode": pincodecontroller.text.toString(),
                              "department": select_general.toString(),
                              "user_type": "admin",
                              "status": "Active"
                            };

                            var list = await loginpage().userSignup(data);
                            // if(list['message']=="email already exits ")

                            // {
                            //    NigDocToast().showSuccessToast(
                            //     'email already exits');
                            // // print(data);
                            // }
                            if (list['access_token'] != null) {
                              await storage.setItem('userResponse', list);
                              await pref.setString(
                                  'access_token', await list['access_token']);
                              pref.setBool('isLogin', true);
                              NigDocToast()
                                  .showSuccessToast('Signup Successfully');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dash()));
                            } else if (list['message'] ==
                                'email already exits') {
                              NigDocToast()
                                  .showErrorToast('email already exits');
                            } else {
                              NigDocToast()
                                  .showErrorToast('pls tryagain later');
                            }
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
