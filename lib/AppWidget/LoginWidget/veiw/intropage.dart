import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:nigdoc/AppWidget/LoginWidget/veiw/Loginpage.dart';
import '../../Common/colors.dart' as Customcolor;

class intropage extends StatefulWidget {
  const intropage({super.key});

  @override
  State<intropage> createState() => _intropageState();
}

class _intropageState extends State<intropage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 50;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.black,
      child: OnBoardingSlider(
        finishButtonText: 'Get Started',
        finishButtonStyle: FinishButtonStyle(
        backgroundColor: Customcolor.appcolor,
      ),

        onFinish: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => Loginpage(),
            ),
          );
          // current_device == 'Device Match' ?
          //       Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) => SecurepinPage(),
          //   ),
          // )
          // :  Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) => LoginPage(),
          //   ),
          // );
        },
        // finishButtonColor:  Color.fromARGB(255, 94, 83, 10),
        skipTextButton: Text(
          'Skip',
          style: TextStyle(
            fontSize: 16,
            color: Customcolor.appcolor,
            fontWeight: FontWeight.w600,
          ),
        ),
        // trailing: Text(
        //   'Login',
        //   style: TextStyle(
        //     fontSize: 16,
        //     color: kDarkBlueColor,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        trailingFunction: () {
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) => LoginPage(),
          //   ),
          // );
        },
        controllerColor: Customcolor.appcolor,
        totalPage: 3,
        headerBackgroundColor: Colors.white,
        pageBackgroundColor: Colors.white,
        background: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/1.jpg',
                // height: 400,
                height: screenHeight * 0.9,
                width: screenWidth * 1,
                //  fit: BoxFit.fill
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/2.jpg',
                // height: 400,
                height: screenHeight * 0.9,
                width: screenWidth * 1,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/3.jpg',
                // height: 400,
                height: screenHeight * 0.9,
                width: screenWidth * 1,
              ),
            ],
          ),
        ],
        speed: 1.8,
        pageBodies: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    // height: 480,
                    ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[],
            ),
          ),
        ],
      ),
    );
  }
}
