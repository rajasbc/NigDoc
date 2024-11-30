import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
// import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Dashboardpage.dart';
import 'package:nigdoc/AppWidget/LoginWidget/Api.dart';
import 'package:nigdoc/AppWidget/LoginWidget/veiw/Forgetpassword.dart';
import 'package:nigdoc/AppWidget/LoginWidget/veiw/SignUp.dart';
import 'package:nigdoc/AppWidget/LoginWidget/veiw/Splashscreen.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
// import 'package:nigdoc/AppWidget/LoginWidget/veiw/onBoard.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/colors.dart' as Customcolor;
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  TextEditingController emailcontroller = TextEditingController();

  bool showPassword = false;
  bool isloading = false;
  late SharedPreferences pref;
  String shop_id = '';


  @override
  void initState() {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => Splashscreen(),
    //     ));
// initPreferences();
    // FlutterNativeSplash.remove();
    // }
    initPreferencess();
  }

  initPreferencess() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          exit(0);
        },
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(title: Text('Login'),),
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              // physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                      height: 1,
                    ),
                  // Container(height:screenHeight*0.05 ,color: Color.fromARGB(255, 241, 239, 239),),
                  // SizedBox(height: 20,),
                  Container(
                    // color: Colors.white,
                    // color: Colors.red,
                    height: screenHeight * 0.35,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage("assets/nigdoc.png"),
                        // fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: Container(
                        color: Customcolor.appcolor,
                        // color: Colors.red,
                        height: screenHeight * 0.65,
                        width: screenWidth * 1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            // Container(child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold,letterSpacing: 1),),),
                            //  SizedBox(
                            //   height: 10,
                            // ),
                            //  Container(child: Text('Sign in to continue',style: TextStyle(color: Colors.white,fontSize: 15),),),
                            //  SizedBox(
                            //   height: 20,
                            // ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: screenWidth * 0.90,
                                  child: Text(
                                    'Email',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
              
                            Container(
                              width: screenWidth * 0.90,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: Colors.blueAccent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              // padding: const EdgeInsets.all(10),
                              child: TextField(
                                controller: Emailcontroller,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                  border: InputBorder.none,
                                  hintText: 'Enter your Email',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: screenWidth * 0.90,
                                  child: Text(
                                    'Password',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: screenWidth * 0.90,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: Colors.blueAccent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // decoration: BoxDecoration(color: Colors.black,),
                                    // color: Colors.red,
                                    width: screenWidth * 0.65,
                                    child: TextField(
                                      obscureText: !showPassword,
                                      controller: passwordcontroller,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            left: 14.0, bottom: 8.0, top: 10.0),
                                        border: InputBorder.none,
                                        hintText: 'Enter Your Password',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.yellow,
                                    width: screenWidth * 0.15,
                                    // width: screenheight / 2.5,
                                    child: IconButton(
                                      icon: Icon(
                                        !showPassword
                                            ? FontAwesome.eye_off
                                            : FontAwesome.eye,
                                        color: Colors.black38,
                                        size: 18,
                                      ),
                                      onPressed: () {
                                        togglePasswordView();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                             SizedBox(height: screenHeight*0.01,),
                            Container(width: screenWidth * 0.90,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(onTap: (){
                                     Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Forgotpassword()),
                          );
              
                                  },
                                    child: Text("Forgot password?   ",style: TextStyle(fontSize: 15,color: Colors.white) ,)),
                                ],
                              )),
                            SizedBox(height: screenHeight*0.03,),
                            // Container(
                            //       child: TextButton(onPressed: (){
                            //         showDialog(context: context, builder: (context)=>AlertDialog(
                            //             actions: [
                            //               Container(
                            //               height: screenHeight*0.04,
                            //               width: screenWidth*0.14,
                            //               ),
                            //               Container(
                                             
                            //                 child: Column(
                            //                   children: [
                                               
                            //                       Container(
                                                  
                            //                       child: Padding(
                            //                         padding: const EdgeInsets.only(left: 10),
                            //                         child: Text('Forgot Password',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            //                       )),
                            //                      SizedBox(height: screenHeight*0.02,),
                            //                     Container(
                            //                       child: TextFormField(
                            //                         controller: emailcontroller,
                            //                         decoration: InputDecoration(
                            //                           border: OutlineInputBorder(),
                            //                           labelText: 'Email Address'
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     SizedBox(height: screenHeight*0.03,),
                            //                     Container(
                            //                       width: screenWidth,
                            //                       child: ElevatedButton(
                            //                          style: ButtonStyle(
                            //       backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                            //       shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          
                            //        RoundedRectangleBorder(
                            //        borderRadius: BorderRadius.circular(10),
                             
                            
                            //        ),
                          
                            //       )
                        
                            //       ),
                            //                         onPressed: (){
                            //                       if(!emailcontroller.text.contains('@')||
                            //                          !emailcontroller.text.contains('.')||
                            //                          !emailcontroller.text.contains('com')){
                            //                         NigDocToast().showErrorToast('Enter Your Email Id');
                            //                       }else{
                            //                         var data={
                            //                        "emailAddress":emailcontroller.text.toString(),
                            //                         };
                            //                         Helper().isvalidElement(data);
                            //                         print(data);
                            //                       }
                            //                       }, child: Text('Ok',style: TextStyle(color: Colors.white,fontSize: 20),)),
                                                
                            //                     ),
                            //                     SizedBox(height: screenHeight*0.02,)
                            //                   ],
                            //                 ),
                            //               )
                            //             ],
                            //         ));
                          
                         
                            //       }, 
                            //       child: Padding(
                            //         padding: const EdgeInsets.only(left: 230),
                            //         child: Text('Forgot Password?',style: TextStyle(color: Colors.white,fontSize: 16),
                                    
                            //         ),
                            //       )
                            //        ),
                            //         ),
                            SizedBox(
                              height:screenHeight*0.00,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: Colors.blueAccent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.06,
                              child: TextButton(
                                  onPressed: () async {
                                    this.setState(() {
                                      isloading = true;
                                    });
                                    var data = {
                                      "email": Emailcontroller.text,
                                      "password": passwordcontroller.text,
                                    };
                                    if (!Emailcontroller.text.isEmpty &&
                                        !passwordcontroller.text.isEmpty) {
                                      var logindata =
                                          await loginpage().loginresponse(data);
              
                                      isloading = false;
                                     await storage.setItem('userResponse', logindata);
                                      if (Helper().isvalidElement(logindata) &&
                                          Helper()
                                              .isvalidElement(logindata['error']) &&
                                          logindata['error'] ==
                                              'Email_id and Password Incorrect') {
                                        Fluttertoast.showToast(
                                            msg: 'Incorrect Email & Password',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 2,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 15.0);
                                      } else {
                                        if (logindata['access_token'] != null &&
                                    logindata['is_active'] != 'Active') {
                                  var medi_profile = logindata['clinic_profile'];
                                  shop_id = medi_profile['id'].toString();
                                  AlertBox();
                                }
                                      else if (logindata['access_token'] != null) {
                                          Emailcontroller.text = '';
                                          passwordcontroller.text = '';
                                          // await storeBox?.put('userResponse', user_data);
                                          this.setState(() {});
              
                                          await pref.setString('access_token',
                                          await logindata['access_token']);
                                          pref.setBool('isLogin', true);
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    Dash()),
                                          );
              
                                          Fluttertoast.showToast(
                                              msg: "login successfully",
                                              // ${logindata['clinic_profile']['name']}
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MyApp()),
                                          );
                                          this.setState(() {
                                            isloading = false;
                                          });
                                        }
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Please Fill Email Id & Password',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 15.0);
                                    }
              
                                    this.setState(() {
                                      isloading = false;
                                    });
                                  },
                                  child: isloading
                                      ? SpinLoader()
                                      : Text(
                                          'SIGN IN',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Customcolor.appcolor,
                                              fontWeight: FontWeight.bold),
                                        )),
                            ),
              
                            // SizedBox(
                            //   height: 10,
                            // ),
              //                         Container(
              //                           width: screenWidth * 0.40,
              //                           child: ElevatedButton(
              //                               onPressed: () async {
              //                                 this.setState(() {
              //                                   isloading = true;
              //                                 });
              //                                 var data = {
              //                                   "email": Emailcontroller.text,
              //                                   "password": passwordcontroller.text,
              //                                 };
              //                                 if (!Emailcontroller.text.isEmpty &&
              //                                     !passwordcontroller.text.isEmpty) {
              //                                   var logindata =
              //                                       await api().loginresponse(data);
              //                                   storage.setItem('userResponse', logindata);
              //                                   if (Helper().isvalidElement(logindata) &&
              //                                       Helper()
              //                                           .isvalidElement(logindata['error']) &&
              //                                       logindata['error'] ==
              //                                           'Email_id and Password Incorrect') {
              //                                     Fluttertoast.showToast(
              //                                         msg: 'Incorrect Email & Password',
              //                                         toastLength: Toast.LENGTH_SHORT,
              //                                         gravity: ToastGravity.CENTER,
              //                                         timeInSecForIosWeb: 2,
              //                                         backgroundColor: Colors.red,
              //                                         textColor: Colors.white,
              //                                         fontSize: 15.0);
              //                                   } else {
              //                                     // var user = UserData.fromMap(user_data);
              
              //                                     if (logindata['access_token'] != null) {
              //                                       Emailcontroller.text = '';
              //                                       passwordcontroller.text = '';
              //                                       // await storeBox?.put('userResponse', user_data);
              //                                       this.setState(() {});
              
              //                                       // Navigator.push(
              //                                       //   context,
              //                                       //   MaterialPageRoute(
              //                                       //       builder: (context) => MyApp()),
              //                                       // );
              //                                       // Navigator.push(
              //                                       //   context,
              //                                       //   MaterialPageRoute(
              //                                       //       builder: (context) =>
              //                                       //           DashboardScreen()),
              //                                       // );
              //                                       // Navigator.pop(context,true);
              // //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()),
              // // );
              
              //                                       // SharedPreferences SharedPreference = await SharedPreferences.getInstance();
              //                                       await pref.setString('access_token',
              //                                           await logindata['access_token']);
              //                                       pref.setBool('isLogin', true);
              //                                       Navigator.of(context).pushReplacement(
              //                                         MaterialPageRoute(
              //                                             builder: (BuildContext context) =>
              //                                                 Dash()),
              //                                       );
              
              //                                       // Navigator.push(
              //                                       //                                 context,
              //                                       //                                 MaterialPageRoute(
              //                                       //                                     builder: (context) => MyApp()),
              //                                       //                               );
              //                                       Fluttertoast.showToast(
              //                                           msg: "login successfully",
              //                                           toastLength: Toast.LENGTH_SHORT,
              //                                           gravity: ToastGravity.CENTER,
              //                                           timeInSecForIosWeb: 1,
              //                                           backgroundColor: Colors.green,
              //                                           textColor: Colors.white,
              //                                           fontSize: 16.0);
              //                                     } else {
              //                                       // Navigator.pop(context,true);
              // //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()),
              // // );
              //                                       Navigator.pushReplacement(
              //                                         context,
              //                                         MaterialPageRoute(
              //                                             builder: (context) => MyApp()),
              //                                       );
              //                                       this.setState(() {
              //                                         isloading = false;
              //                                       });
              //                                       // Fluttertoast.showToast(
              //                                       //     msg: "${user_data['lab_profile']['name']} ! login successfully",
              //                                       //     toastLength: Toast.LENGTH_SHORT,
              //                                       //     gravity: ToastGravity.CENTER,
              //                                       //     timeInSecForIosWeb: 1,
              //                                       //     backgroundColor: Colors.red,
              //                                       //     textColor: Colors.white,
              //                                       //     fontSize: 16.0);
              //                                     }
              //                                   }
              //                                 } else {
              //                                   Fluttertoast.showToast(
              //                                       msg: 'Please Fill Email Id & Password',
              //                                       toastLength: Toast.LENGTH_SHORT,
              //                                       gravity: ToastGravity.CENTER,
              //                                       timeInSecForIosWeb: 2,
              //                                       backgroundColor: Colors.red,
              //                                       textColor: Colors.white,
              //                                       fontSize: 15.0);
              //                                 }
              
              //                                 // Navigator.push(
              //                                 //     context,
              //                                 //     MaterialPageRoute(
              //                                 //       builder: (context) => Dashboardpage(),
              //                                 //     ));
              //                                 this.setState(() {
              //                                   isloading = false;
              //                                 });
              //                               },
              //                               child: Text('Login')),
              //
              //     ),
          SizedBox(height: screenHeight*0.03,),
          Padding(
            padding: const EdgeInsets.only(left: 75),
            child: Row(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 00),
                    child: Text("Dont't have An Account ?",
                    style: TextStyle(fontSize: 15,color: Colors.white),),
                  ),
                ),
                 Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>SignUp()));
                        }, child: Text('Sign Up',style: TextStyle(
                          color: Colors.white,fontSize: 20),))
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
            ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 10,),
              
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.end,
              
              //                       children: [
              //                         Container(),
              //                         // Padding(
              //                         //   padding: const EdgeInsets.all(8.0),
              //                         //   child: TextButton(
              //                         //     onPressed: (){
              
              //                         //     },
              //                         //    child: Text('Forget Password ?',style: TextStyle(fontSize: 16,color:Customcolor.appcolor ),)),
              //                         // ),
              //                         Padding(
              //                           padding: const EdgeInsets.only(top:8.0,bottom: 8,left: 8,right: 0),
              //                           child: TextButton(
              //                               onPressed: () async {
              //                                 this.setState(() {
              //                                   isloading = true;
              //                                 });
              //                                 var data = {
              //                                   "email": Emailcontroller.text,
              //                                   "password": passwordcontroller.text,
              //                                 };
              //                                 if (!Emailcontroller.text.isEmpty &&
              //                                     !passwordcontroller.text.isEmpty) {
              //                                   var logindata =
              //                                       await api().loginresponse(data);
              //                                       isloading = false;
              //                                   storage.setItem('userResponse', logindata);
              //                                   if (Helper().isvalidElement(logindata) &&
              //                                       Helper()
              //                                           .isvalidElement(logindata['error']) &&
              //                                       logindata['error'] ==
              //                                           'Email_id and Password Incorrect') {
              //                                     Fluttertoast.showToast(
              //                                         msg: 'Incorrect Email & Password',
              //                                         toastLength: Toast.LENGTH_SHORT,
              //                                         gravity: ToastGravity.CENTER,
              //                                         timeInSecForIosWeb: 2,
              //                                         backgroundColor: Colors.red,
              //                                         textColor: Colors.white,
              //                                         fontSize: 15.0);
              //                                   } else {
              //                                     // var user = UserData.fromMap(user_data);
              
              //                                     if (logindata['access_token'] != null) {
              //                                       Emailcontroller.text = '';
              //                                       passwordcontroller.text = '';
              //                                       // await storeBox?.put('userResponse', user_data);
              //                                       this.setState(() {});
              
              //                                       // Navigator.push(
              //                                       //   context,
              //                                       //   MaterialPageRoute(
              //                                       //       builder: (context) => MyApp()),
              //                                       // );
              //                                       // Navigator.push(
              //                                       //   context,
              //                                       //   MaterialPageRoute(
              //                                       //       builder: (context) =>
              //                                       //           DashboardScreen()),
              //                                       // );
              //                                       // Navigator.pop(context,true);
              // //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()),
              // // );
              
              //                                       // SharedPreferences SharedPreference = await SharedPreferences.getInstance();
              //                                       await pref.setString('access_token',
              //                                           await logindata['access_token']);
              //                                       pref.setBool('isLogin', true);
              //                                       Navigator.of(context).pushReplacement(
              //                                         MaterialPageRoute(
              //                                             builder: (BuildContext context) =>
              //                                                 Dash()),
              //                                       );
              
              //                                       // Navigator.push(
              //                                       //                                 context,
              //                                       //                                 MaterialPageRoute(
              //                                       //                                     builder: (context) => MyApp()),
              //                                       //                               );
              //                                       Fluttertoast.showToast(
              //                                           msg: "login successfully",
              //                                           // ${logindata['clinic_profile']['name']}
              //                                           toastLength: Toast.LENGTH_SHORT,
              //                                           gravity: ToastGravity.CENTER,
              //                                           timeInSecForIosWeb: 1,
              //                                           backgroundColor: Colors.green,
              //                                           textColor: Colors.white,
              //                                           fontSize: 16.0);
              //                                     } else {
              //                                       // Navigator.pop(context,true);
              // //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()),
              // // );
              //                                       Navigator.pushReplacement(
              //                                         context,
              //                                         MaterialPageRoute(
              //                                             builder: (context) => MyApp()),
              //                                       );
              //                                       this.setState(() {
              //                                         isloading = false;
              //                                       });
              //                                       // Fluttertoast.showToast(
              //                                       //     msg: "${user_data['lab_profile']['name']} ! login successfully",
              //                                       //     toastLength: Toast.LENGTH_SHORT,
              //                                       //     gravity: ToastGravity.CENTER,
              //                                       //     timeInSecForIosWeb: 1,
              //                                       //     backgroundColor: Colors.red,
              //                                       //     textColor: Colors.white,
              //                                       //     fontSize: 16.0);
              //                                     }
              //                                   }
              //                                 } else {
              //                                   Fluttertoast.showToast(
              //                                       msg: 'Please Fill Email Id & Password',
              //                                       toastLength: Toast.LENGTH_SHORT,
              //                                       gravity: ToastGravity.CENTER,
              //                                       timeInSecForIosWeb: 2,
              //                                       backgroundColor: Colors.red,
              //                                       textColor: Colors.white,
              //                                       fontSize: 15.0);
              //                                 }
              
              //                                 // Navigator.push(
              //                                 //     context,
              //                                 //     MaterialPageRoute(
              //                                 //       builder: (context) => Dashboardpage(),
              //                                 //     ));
              //                                 this.setState(() {
              //                                   isloading = false;
              //                                 });
              //                               },
              
              //                            child: isloading?SpinLoader(): Text('LOGIN',style: TextStyle(fontSize: 28,color: Customcolor.appcolor),)),
              //                         ),
              //                          Icon(Icons.arrow_forward,size: 30,color: custom_color.appcolor),
              //                       ],
              //                     )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  togglePasswordView() {
    setState(() {
      showPassword = !showPassword;
    });
  }
  
  var alertStyle = AlertStyle(
    animationType: AnimationType.fromBottom,
    isCloseButton: false,
    isOverlayTapDismiss: true,
    descStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    descTextAlign: TextAlign.center,
    animationDuration: const Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: const BorderSide(
        color: Colors.white,
      ),
    ),
    titleStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.blue[400],
    ),
    alertAlignment: Alignment.center,
  );
  AlertBox() {
    Alert(
      context: context,
      style: alertStyle,
      title: " Alert !",
     

      desc:
          "You doesn't Have any Plans Active.\n Please check and activate your plan.",
      buttons: [
        DialogButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          color: custom_color.error_color,
          radius: BorderRadius.circular(10.0),
          child: const Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }
}
