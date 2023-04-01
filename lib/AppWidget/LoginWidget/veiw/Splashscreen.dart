import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/LoginWidget/veiw/Loginpage.dart';
import 'package:nigdoc/AppWidget/LoginWidget/veiw/intropage.dart';
// import 'package:nigdoc/AppWidget/LoginWidget/veiw/onBoard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/colors.dart' as Customcolor;

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late SharedPreferences pref;
  bool? isLoggedIn = false;
  int? initScreen;
  @override
  void initState() {
    initPreferences();
    // TODO: implement initState
    super.initState();
    new Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => isLoggedIn == true
                      ? Dash()
                      : initScreen == 0 || initScreen == null
                          ? intropage()
                          : Loginpage()),
            ));
  }

  void initPreferences() async {
    pref = await SharedPreferences.getInstance();
 
      isLoggedIn = pref.getBool('isLogin');
      initScreen = await pref.getInt("initScreen");
      await pref.setInt("initScreen", 1);
      print('initScreen ${initScreen}');

      
    
  }

  //  void initPreferences() async {
  //   pref = await SharedPreferences.getInstance();
  //   setState(() async {
  //     isLoggedIn = pref.getBool('isLogin');
  //     initScreen = await pref.getInt("initScreen");
  //     await pref.setInt("initScreen", 1);
  //     print('initScreen ${initScreen}');
  //   });
  // }

  //  @override void initState() {
  //   super.initState();
  //   new Future.delayed( const Duration(seconds: 2), () =>
  //   Navigator.pushReplacement( context,
  //   MaterialPageRoute(builder: (context) => Dash()),
  //      ));
  //    }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            color: Customcolor.appcolor,
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/splash.gif",
              gaplessPlayback: true,
              // fit: BoxFit.fill
            )));
  }
}
