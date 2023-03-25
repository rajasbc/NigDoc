import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';

class ClinicConfig extends StatefulWidget {
  const ClinicConfig({super.key});

  @override
  State<ClinicConfig> createState() => _ClinicConfigState();
}

class _ClinicConfigState extends State<ClinicConfig> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dash(),
              ));
          return true;},
          child: Scaffold(
             resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'Pharmacy List',
              style: TextStyle(color: Colors.white),
            ),
            // backgroundColor: ,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dash(),
                    ));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body:Container()

          ),

          );
  }
}