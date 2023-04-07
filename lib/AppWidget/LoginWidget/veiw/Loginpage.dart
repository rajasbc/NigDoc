import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
// import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Dashboardpage.dart';
import 'package:nigdoc/AppWidget/LoginWidget/Api.dart';
import 'package:nigdoc/AppWidget/LoginWidget/veiw/Splashscreen.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
// import 'package:nigdoc/AppWidget/LoginWidget/veiw/onBoard.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/colors.dart' as Customcolor;
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import '../../../AppWidget/common/Colors.dart'as custom_color;


class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
   bool showPassword = false;
  bool isloading = false;
  late SharedPreferences pref;

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
    return Scaffold(
      // appBar: AppBar(title: Text('Login'),),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                        Container(child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold,letterSpacing: 1),),),
                         SizedBox(
                          height: 10,
                        ),
                         Container(child: Text('Sign in to continue',style: TextStyle(color: Colors.white,fontSize: 15),),),
                         SizedBox(
                          height: 20,
                        ),
                        Column(mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Container(
                              width: screenWidth*0.90,
                              child: Text('EMAIL',style: TextStyle(color: Colors.white,fontSize: 15),),),
                           ],
                         ),
                          SizedBox(
                          height: 5,
                        ),
                         
                        Container(
                    width: screenWidth*0.90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    // padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: Emailcontroller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        border: InputBorder.none,
                        hintText: 'Enter your email address',
                      ),
                    ),
                  ),
                        SizedBox(
                          height: 10,
                        ),
                         Column(mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Container(
                              width: screenWidth*0.90,
                              child: Text('PASSWORD',style: TextStyle(color: Colors.white,fontSize: 15),),),
                           ],
                         ),
                          SizedBox(
                          height: 5,
                        ),
                        Container(
                    width: screenWidth*0.90,
                     decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
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
                                hintText: '***********',
                              ),
                            ),
                          ),
                          Container(
                            // color: Colors.yellow,
                            width: screenWidth * 0.15,
                            // width: screenheight / 2.5,
                            child: IconButton(
                              icon: Icon(
                                ! showPassword
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
                  SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                         
                          width: screenWidth*0.9,
                          height: screenHeight*0.06,
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
                                      await api().loginresponse(data);
                                      isloading = false;
                                  storage.setItem('userResponse', logindata);
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
                                   

                                    if (logindata['access_token'] != null) {
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
                          
                           child: isloading?SpinLoader(): Text('SIGN IN',style: TextStyle(fontSize: 25,color: Customcolor.appcolor,fontWeight: FontWeight.bold),)),

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
                  
                      ]
                      ,


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
    );
  }
   togglePasswordView() {
    setState(() {
      showPassword = !showPassword;
    });
  }
}
