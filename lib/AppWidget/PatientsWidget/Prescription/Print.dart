import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Prescription/PrescriptionList.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;

class Prescriptionprint extends StatefulWidget {
  final select_print;
  const Prescriptionprint({super.key, required ,this.select_print});

  @override
  State<Prescriptionprint> createState() => _PrescriptionprintState();
}

class _PrescriptionprintState extends State<Prescriptionprint> {
  int? _printSelected;
   String _printVal = "";

   
  String _headerSelected="";
  String _headerval = "";
  var reoportbillid;
   Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
  var userResponse;
  var accesstoken;
  var data;
  @override
  void initState(){
    init();
    
   
    super.initState();
    //  initilzeMethod();
  }
   init() async {
    // await storage.ready;
    userResponse = await storage.getItem('userResponse');
    accesstoken = await userResponse['access_token'];
    data = widget.select_print;

    setState(() {
     
    });

   
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Prescription_List()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Prescription Print',style: TextStyle(color: Colors.white),),
          leading: IconButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Prescription_List()));
          }, icon: Icon(Icons.arrow_back,color: Colors.white,)
          ),
          backgroundColor:custom_color.appcolor ,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: [
                 SizedBox(height: screenHeight*0.01,),
                  Center(
                             child: Container(
                             child: Text('Choose Size & Formet',
                             style: TextStyle(fontSize: 20,
                             fontWeight: FontWeight.bold),),
                             ),
                             ),
                             SizedBox(height: screenHeight*0.01,),
                                  Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(width: screenWidth*0.12,),
                              Container(
                               // width: screenWidth * 0.50,
                                width: screenWidth*0.20,
                                child: Text(
                                  'Print',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                              ),
                              SizedBox(width: screenWidth*0.02,),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                       width:screenWidth*0.20,
                                      child: Row(
                                        children: [
                                          Radio<int>(
                                            value: 1,
                                            groupValue: _printSelected,
                                            activeColor: Colors.blue,
                                            onChanged: (value) {
                                          
                                              setState(() {
                                                 _printSelected = value as int;
                                                 _printVal = 'A4';
                                                print(_printVal);
                                              });
                                            },
                                          ),
                                          const Text("A4"),
                                          
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: screenWidth*0.18,
                                          child: Radio(
                                            value: 2,
                                            groupValue: _printSelected,
                                            activeColor: Colors.blue,
                                            onChanged: (value) {
                                              
                                              setState(() {
                                                 _printSelected = value as int;
                                                 _printVal = 'A5';
                                                print(_printVal);
                                              });
                                            },
                                          ),
                                           
                                        ),
                                        const Text("A5"),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          
                             Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(width: screenWidth*0.12,),
                              Container(
                               // width: screenWidth * 0.50,
                                width: screenWidth*0.20,
                                child: Text(
                                  'Header',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                              ),
                              SizedBox(width: screenWidth*0.02,),
                              Container(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                       width:screenWidth*0.20,
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: 'yes',
                                            groupValue: _headerSelected,
                                            activeColor: Colors.blue,
                                            onChanged: (value) {
                                              setState(() {
                                                 _headerSelected = value.toString();
                                                //  _headerval = 'Yes';
                                                
                                              });
                                            },
                                          ),
                                          const Text("Yes"),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(width: screenWidth*0.01,),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: screenWidth*0.18,
                                            child:
                                             Radio(
                                              value: "no",
                                              groupValue: _headerSelected,
                                              activeColor: Colors.blue,
                                              onChanged: (value) {
                                                
                                                setState(() {
            
                                                   _headerSelected=value.toString();
                                                 
                                                });
                                                setState(() {
                                                  
                                                });
                                              },
                                            ),
                                          ),
                                          const Text("No"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        
                           SizedBox(height: screenHeight*0.04,),
                           Row(
                        children: [
                          
                      SizedBox(width: screenWidth*0.12,),
                             Container(
                              width: screenWidth*0.30,
                               child: ElevatedButton( 
                                
                               style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                         
                                  RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                                            
                                                           
                                   ),
                                                         
                                   )
                                                       
                                   ),
                               child:Text('Cancel',
                               style: TextStyle(fontSize: 20,color: Colors.white),),
                               onPressed: (() {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>Prescription_List()));

                               }),),
                             ),
                             SizedBox(width: screenWidth*0.04,),
                             Container(
                              width: screenWidth*0.32,
                               child: ElevatedButton( 
                               style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                         
                                    RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                               
                                                           
                                     ),
                                                         
                                     )
                                                       
                                     ),
                                 child:Text('Confirm',
                                 style: TextStyle(fontSize: 20,color: Colors.white),),
                                 onPressed: (() {
                                reoportbillid =
                                data['presc_id'].toString();
                                                                            
                                 Codec<String, String>
                                  stringToBase64 =
                                  utf8.fuse(base64);
                                   final encoded =
                                 base64.encode(utf8.encode(reoportbillid));
                                _launchInBrowser(Uri.parse('https://nigdoc.com/users/patient_checkup.php?pre=${encoded}=&size=${Helper().isvalidElement(_printSelected)&& _printSelected == 1 ?"a4":"a5"}&header=${Helper().isvalidElement(_headerSelected)&& _headerSelected == 1 ?"yes":"no"}'));
                                  
                                 }),),
                             ),
                             SizedBox(height: screenHeight*0.04,),
                         ],
                       ),

                ],
              ),
            ),
          )),
      ));
  }
}