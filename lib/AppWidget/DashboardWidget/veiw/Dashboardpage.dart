import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/DashboardApi.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Nigdocmenubar.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/Colors.dart' as custom_colors;

class Dashboardpage extends StatefulWidget {
  const Dashboardpage({super.key});

  @override
  State<Dashboardpage> createState() => _DashboardpageState();
}

class _DashboardpageState extends State<Dashboardpage> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  void initState() {
    super.initState();
    // userResponse = storage.getItem('userResponse');
    // accesstoken = userResponse['access_token'];
    initPreferences();
    // FlutterNativeSplash.remove();
    // method();
    this.setState(() {
      // userResponse = storage.getItem('userResponse');
    });
  }

  initPreferences() async {
    pref = await SharedPreferences.getInstance();
    await getFcmToken();
  }

  Future getFcmToken() async {
    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission();
    }
    FirebaseMessaging firebaseMessage = FirebaseMessaging.instance;
    if (storage.getItem('fcm_token') == null) {
      String? deviceToken = await firebaseMessage.getToken();
      print("deviceTokenn ${deviceToken}");
      await storage.setItem('fcm_token', deviceToken);
      await updateFcm(deviceToken);
    } else {
      var deviceToken = storage.getItem('fcm_token');
      print("deviceTokenn ${deviceToken}");
      await updateFcm(deviceToken);
    }
  }

  updateFcm(deviceToken) async {
    var data = {
      'device_id': await storage.getItem('device_id'),
      'email': await storage.getItem('userResponse')['clinic_profile']['email'],
      'fcm': deviceToken,
      'status': 'Active'
    };
    var result = await DashboardApi().updateFCM(data);
    print(result);
  }

  late SharedPreferences pref;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: SafeArea(
          child: Drawer(
        elevation: 50,
        child: Nigdocmenubar(),
      )),
      appBar: AppBar(
        title: Text('Dashboard'),
        // backgroundColor: Colors.amber,
        actions: [
          IconButton(
              onPressed: () {
                Helper().appLogoutCall(context, 'logout');
              },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: screenHeight * 0.10,
                width: screenWidth * 0.90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Patient Count',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: screenHeight * 0.10,
                width: screenWidth * 0.90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Prescription Count',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: screenHeight * 0.10,
                width: screenWidth * 0.90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Appointment Count',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: screenHeight * 0.10,
                width: screenWidth * 0.90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Pending Appointment Count',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
