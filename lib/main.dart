import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';

// import 'package:nigdoc/AppWidget/DashboardWidget/veiw/Dashboardpage.dart';
import 'package:nigdoc/AppWidget/LoginWidget/veiw/Loginpage.dart';
import 'package:nigdoc/AppWidget/LoginWidget/veiw/Splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

var userResponse;
var token = null;
var storeBox;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  final LocalStorage storage = new LocalStorage('doctor_store');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocalStorage storage = new LocalStorage('doctor_store');

    userResponse = storage.getItem('userResponse');
    return MaterialApp(debugShowCheckedModeBanner: false, home: docWrapper());
  }
}

class docWrapper extends StatefulWidget {
  const docWrapper({super.key});

  @override
  State<docWrapper> createState() => _docWrapperState();
}

class _docWrapperState extends State<docWrapper> {
  late SharedPreferences pref;
  bool? isLoggedIn = false;
  @override
  void initState() {
    initPreferences();
    // TODO: implement initState
    super.initState();
  }

  void initPreferences() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = pref.getBool('isLogin');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Splashscreen();
  }
}
