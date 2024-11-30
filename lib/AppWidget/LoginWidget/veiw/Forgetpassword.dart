import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/AppWidget/common/Colors.dart' as CustomColors;
import 'package:nigdoc/AppWidget/LoginWidget/Api.dart';
import 'package:nigdoc/AppWidget/LoginWidget/veiw/Loginpage.dart';
import 'package:nigdoc/AppWidget/common/Colors.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final LocalStorage storage = new LocalStorage('nigdent_store');
  TextEditingController Passwordcontroller = TextEditingController();
  TextEditingController Confirmpasswordcontroller = TextEditingController();
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController OTPController = TextEditingController();
  TextEditingController Mobilenocontroller = TextEditingController();
  // TextEditingController OTPController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmFocusNode = FocusNode();
  late Timer timer;
  int start = 60;
  bool loding = false;
  bool OTP = false;
  bool password = false;
  bool showpassword = true;
  bool showconpassword = true;
  var enter_otp;
  var Otp;
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Loginpage()));
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appcolor,
          title: Text(
            'Forgot Password',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Loginpage()));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: SingleChildScrollView(
                child: Column(children: [
                  !loding ? email(screenHeight, screenWidth) : Container(),
                  OTP ? otp(screenHeight, screenWidth) : Container(),
                  password ? Password(screenHeight, screenWidth) : Container(),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Password(screenHeight, screenWidth) {
    return Container(
        child: Column(children: [
      Center(
        child: TextFormField(
          //obscureText: true,
          controller: Passwordcontroller,
          focusNode: passwordFocusNode,
          obscureText: showpassword,

          decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                      !showpassword ? Icons.visibility : Icons.visibility_off,
                      color: appcolor,
                      size: 25),
                  onPressed: () {
                    setState(() {
                      showpassword = !showpassword;
                    });
                  }),
              border: OutlineInputBorder(),
              labelText: 'New Password'),
        ),
      ),
      SizedBox(height: screenHeight * 0.02),
      Container(
        child: TextFormField(
          //obscureText: true,
          controller: Confirmpasswordcontroller,
          focusNode: confirmFocusNode,
          obscureText: showconpassword,

          decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                      !showconpassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: appcolor,
                      size: 25),
                  onPressed: () {
                    setState(() {
                      showconpassword = !showconpassword;
                    });
                  }),
              border: OutlineInputBorder(),
              labelText: 'Confirm Password'),
        ),
      ),
      SizedBox(height: screenHeight * 0.02),
      Container(
          width: screenWidth,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: appcolor),
            // style: ElevatedButton.styleFrom(
            //   primary: Color.fromARGB(171, 3, 67, 52), // background
            //   onPrimary: Colors.white,

            //   // foreground
            // ),
            onPressed: () async {
              if (Passwordcontroller.text.isEmpty) {
                passwordFocusNode.requestFocus();
                // Apptoast().showErrorToast("Enter Your Password");
                Fluttertoast.showToast(
                    msg: 'Enter Your Password',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.red,
                    textColor: Colors.white);
              } else if (Passwordcontroller.text.length < 6) {
                passwordFocusNode.requestFocus();
                // Apptoast().showErrorToast('Please Enter Your 6 Digit Password');
                Fluttertoast.showToast(
                    msg: 'Please Enter Your 6 Digit Password',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.red,
                    textColor: Colors.white);
              } else if (Passwordcontroller.text !=
                  Confirmpasswordcontroller.text) {
                // Apptoast().showErrorToast('Confirm Password Mismatch');
                confirmFocusNode.requestFocus();
                Fluttertoast.showToast(
                    msg: 'Confirm Password Mismatch',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.red,
                    textColor: Colors.white);
              } else {
                var data1 = {
                  "email": Emailcontroller.text.toString(),
                  "password": Passwordcontroller.text.toString(),
                  "mobileno": Mobilenocontroller.text.toString()
                };
                // var list;
                var list = await loginpage().changepassword(data1);
                if (list['message'] == "successfully") {
                  // Apptoast().showSuccessToast('Password Update Successfully');
                  Fluttertoast.showToast(
                      msg: 'Password Update Successfully',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.green,
                      textColor: Colors.white);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Loginpage()));
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Collections()));
                  // OverlayLoader().hideLoader();
                } else {
                  // OverlayLoader().hideLoader();
                  // Apptoast().showErrorToast('Please Tryagain Later');
                  Fluttertoast.showToast(
                      msg: 'Please Tryagain Later',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white);
                }
              }
            },
            child: Container(
              // color: Colors.green,
              // padding: const EdgeInsets.all(14),
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )),
    ]));
  }

  otp(screenHeight, screenWidth) {
    return Container(
      child: Center(
        child: Container(
            child: Column(children: [
          Text("Enter Your OTP"),
          SizedBox(height: screenHeight * 0.02),
          OTPTextField(
              // controller: OTPController,
              length: 4,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 45,
              fieldStyle: FieldStyle.box,
              outlineBorderRadius: 15,
              style: TextStyle(fontSize: 17),
              // onChanged: (pin) {
              //   // print("Changed: " + pin);
              // },
              onCompleted: (pin) async {
                // print("Completed: " + pin);
                enter_otp = pin;
                if (pin != Otp.toString()) {
                  setState(() {
                    OTPController.clear();
                  });
                  // Apptoast().showErrorToast(
                  //     "The OTP You Entered is Invalid. Please Enter The Correct OTP");
                  Fluttertoast.showToast(
                      msg:
                          'The OTP You Entered is Invalid. Please Enter The Correct OTP',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white);
                } else {}
              }),
          SizedBox(height: screenHeight * 0.02),
          Container(
              child: Column(children: [
            // startTimer(),
            Text('Session Timeout :${start} sec'),
          ])),
          SizedBox(height: screenHeight * 0.02),
          Container(
              width: screenWidth,
              child: ElevatedButton(
                // style: ButtonStyle(
                //   backgroundColor: WidgetStateProperty.all<Color>(
                //       Colors.blue), // Change the color here
                // ),
                // style: ElevatedButton.styleFrom(
                //     backgroundColor: appcolor),
                // style: ElevatedButton.styleFrom(
                //   primary: Color.fromARGB(171, 3, 67, 52), // background
                //   onPrimary: Colors.white,

                //   // foreground
                // ),
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(appcolor),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )),
                onPressed: () async {
                  if (Otp.toString() == enter_otp) {
                    // Apptoast().showErrorToast("OTP Verified Successfully");
                    Fluttertoast.showToast(
                        msg: 'OTP Verified Successfully',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.green,
                        textColor: Colors.white);
                    setState(() {
                      password = true;
                      OTP = false;
                    });
                  } else {}
                  // setState(() {
                  //   password = true;
                  //   OTP = false;
                  // });
                },
                child: Container(
                  // color: Colors.green,
                  // padding: const EdgeInsets.all(14),

                  child: const Text("Submit",
                      style: TextStyle(color: Colors.white)),
                ),
              ))
        ])),
      ),
    );
  }

  startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
            // timerLoading = false;
            // otpbox.set(['1', '2', '3', '4']);
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  email(screenHeight, screenWidth) {
    return Container(
        child: SingleChildScrollView(
            child: Column(children: [
      SizedBox(height: 10),
      // Row(
      //   children: [
      Container(
        // width: screenWidth * 0.65,
        child: TextField(
          controller: Emailcontroller,
          focusNode: emailFocusNode,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: 'Enter Your Email'),
        ),
      ),
      SizedBox(
        width: screenWidth * 0.04,
      ),
      // Container(
      //   child: ElevatedButton(
      //     onPressed: () async {
      //       if (Emailcontroller.text.isEmpty) {
      //         Apptoast().showErrorToast('Enter Your Email');
      //       } else {
      //         var data = {
      //           "Email": Emailcontroller.text.toString(),
      //         };
      //         var list = await api().getforgotmobileno(data);
      //         var mobile = list['list'][0]['contact_no'].toString();
      //         Mobilenocontroller.text = mobile.toString();
      //         // if (list['message'] == "successfully") {
      //         //   Apptoast().showSuccessToast(
      //         //       'Bill Cancel successfully');
      //         //   // Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerList()));
      //         //   // Navigator.push(
      //         //   //     context,
      //         //   //     MaterialPageRoute(
      //         //   //         builder: (context) => Collections()));
      //         //   // OverlayLoader().hideLoader();
      //         // } else {
      //         //   // OverlayLoader().hideLoader();
      //         //   Apptoast()
      //         //       .showErrorToast('please tryagain later');
      //       }
      //     },
      //     child: Container(
      //       // color: Colors.green,
      //       padding: const EdgeInsets.all(14),
      //       child: const Text("OK"),
      //     ),
      //   ),
      // )
      //   ],
      // ),
      SizedBox(height: screenHeight * 0.02),
      Container(
        width: screenWidth,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(appcolor),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              )),
          onPressed: () async {
            if (Emailcontroller.text.isEmpty) {
              emailFocusNode.requestFocus();
              Fluttertoast.showToast(
                  msg: 'Enter Your Email',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.red,
                  textColor: Colors.white);
            } else {
              var data = {
                "email": Emailcontroller.text.toString(),
              };
              // var list;
              var list = await loginpage().getmobilenum(data);
              if (Helper().isvalidElement(list['list'])) {
                setState(() {
                  var mobile = list['list']['contact_no'].toString();
                  Mobilenocontroller.text = mobile.toString();
                });
              } else {
                Fluttertoast.showToast(
                    msg: 'Pls Check the Email',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.red,
                    textColor: Colors.white);
              }

              // if (list['message'] == "successfully") {
              //   Apptoast().showSuccessToast(
              //       'Bill Cancel successfully');
              //   // Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerList()));
              //   // Navigator.push(
              //   //     context,
              //   //     MaterialPageRoute(
              //   //         builder: (context) => Collections()));
              //   // OverlayLoader().hideLoader();
              // } else {
              //   // OverlayLoader().hideLoader();
              //   Apptoast()
              //       .showErrorToast('please tryagain later');
            }
          },
          child: Container(
            // color: Colors.green,
            // padding: const EdgeInsets.all(14),
            child: const Text("Submit", style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: screenHeight * 0.02),
      Container(
        // width: screenWidth * 0.65,
        child: TextField(
          readOnly: true,
          controller: Mobilenocontroller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Mobile No',
            counterText: "",
          ),
          maxLength: 10,
        ),
      ),
      SizedBox(height: screenHeight * 0.02),
      Container(
          width: screenWidth,
          child: ElevatedButton(
            // style: ButtonStyle(
            //   backgroundColor: WidgetStateProperty.all<Color>(
            //       Colors.blue), // Change the color here
            // ),
            // style: ElevatedButton.styleFrom(
            //     backgroundColor: appcolor),
            // style: ElevatedButton.styleFrom(
            //   primary: Color.fromARGB(171, 3, 67, 52), // background
            //   onPrimary: Colors.white,

            //   // foreground
            // ),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(appcolor),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                )),
            onPressed: () async {
              if (Emailcontroller.text.isEmpty) {
                // Apptoast().showErrorToast('Enter Your Email');
                emailFocusNode.requestFocus();
                Fluttertoast.showToast(
                    msg: 'Enter Your Email',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.red,
                    textColor: Colors.white);
              } else if (Mobilenocontroller.text.isEmpty) {
                // Apptoast().showErrorToast('Enter Your Mobile No');
                Fluttertoast.showToast(
                    msg: 'Enter Your Mobile No',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.red,
                    textColor: Colors.white);
              } else {
                var data = {
                  "mobile": Mobilenocontroller.text.toString(),
                };
                var list = await loginpage().sendotpnum(data);
                print(list);
                // var list;
                Otp = list['otp'];
                if (list['message'] == "Success") {
                  Fluttertoast.showToast(
                      msg: 'OTP Send To Your Registerd Mobile No',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.green,
                      textColor: Colors.white);

                  startTimer();
                  setState(() {
                    loding = true;
                    OTP = true;
                  });
                }
                if (list['message'] == "Message Not Send") {
                  Fluttertoast.showToast(
                      msg: 'Please Tryagain Later',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white);
                }
              }
            },
            child: Container(
              child:
                  const Text("Submit", style: TextStyle(color: Colors.white)),
            ),
          )),
      SizedBox(height: screenHeight * 0.02),
    ])));
  }
}
