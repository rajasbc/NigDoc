import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
// import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Dashboardpage.dart';
import 'package:nigdoc/AppWidget/LoginWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isloading = false;
  late SharedPreferences pref;

  @override
  void initState() {
   
// initPreferences();
    // FlutterNativeSplash.remove();
  // }
initPreferencess();
  }
  initPreferencess() async{
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
              Container(
                height: screenHeight * 0.30,
              ),
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    // color: Colors.red,
                    height: screenHeight * 0.70,
                    width: screenWidth * 0.80,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 140),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: Emailcontroller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email'),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: passwordcontroller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password'),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: screenWidth * 0.40,
                          child: ElevatedButton(
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
                                    // var user = UserData.fromMap(user_data);

                                    if (logindata['access_token'] != null) {
                                      Emailcontroller.text = '';
                                      passwordcontroller.text = '';
                                      // await storeBox?.put('userResponse', user_data);
                                      this.setState(() {});

                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => MyApp()),
                                      // );
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           DashboardScreen()),
                                      // );
                                      // Navigator.pop(context,true);
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()),
// );

                                      // SharedPreferences SharedPreference = await SharedPreferences.getInstance();
                                     await pref.setString('access_token',
                                         await logindata['access_token']);
                                      pref.setBool('isLogin', true);
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                docWrapper()),
                                      );

                                      // Navigator.push(
                                      //                                 context,
                                      //                                 MaterialPageRoute(
                                      //                                     builder: (context) => MyApp()),
                                      //                               );
                                      Fluttertoast.showToast(
                                          msg: "login successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      // Navigator.pop(context,true);
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()),
// );
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyApp()),
                                      );
                                      this.setState(() {
                                        isloading = false;
                                      });
                                      // Fluttertoast.showToast(
                                      //     msg: "${user_data['lab_profile']['name']} ! login successfully",
                                      //     toastLength: Toast.LENGTH_SHORT,
                                      //     gravity: ToastGravity.CENTER,
                                      //     timeInSecForIosWeb: 1,
                                      //     backgroundColor: Colors.red,
                                      //     textColor: Colors.white,
                                      //     fontSize: 16.0);
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

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => Dashboardpage(),
                                //     ));
                                this.setState(() {
                                  isloading = false;
                                });
                              },
                              child: Text('Login')),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
