import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/Colors.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/MedicineStock/MedicineStock.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class stock extends StatefulWidget {
  const stock({super.key});

  @override
  State<stock> createState() => _stockState();
}

class _stockState extends State<stock> {
   final LocalStorage storage = new LocalStorage('doctor_store');
  final DateFormate = "yyyy-MM-dd";
  TextEditingController fromdateInputController = TextEditingController();
  TextEditingController todateInputController = TextEditingController();
  TextEditingController searchinjection = TextEditingController();
  TextEditingController searchmedicine = TextEditingController();

  var accesstoken;
  bool isLoading = false;
  var inpatient_list;
  var inpatientlist;
  var SelectedPharmacy;
  var medicineList;
   
var injectionList;
 bool valid=false;
 bool MedicineLoader=false;
 var list = 0;
 var injection_List;
 var medicine_List;
  void initState() {
    super.initState();
    accesstoken = storage.getItem('userResponse')['access_token'];
    fromdateInputController.text = Helper().getCurrentDate();
    todateInputController.text = Helper().getCurrentDate();
    getInjectionList();
    getMedicineList();

    // print('ddd');
  }
   getInjectionList() async {
    var List = await PatientApi().getinjectionList(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
       injectionList = List['list'];
      setState(() {
       
        isLoading = true;
        filterItems(searchinjection.text);
        // filterItems(searchText.text);
      });
    }
  }
   void filterItems(String text) {
   
    if (text.isEmpty) {
      setState(() {
        injection_List = injectionList;
      });
    } else if (text.length >= 3) {
      setState(() {
        injection_List = injectionList
            .where(
              (item) => item['injections_name']
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()),
              // item['phone']
              //     .toString()
              //     .toLowerCase()
              //     .contains(text.toLowerCase())
            )
            .toList();
      });
    }
  }
   getMedicineList() async {
    var data = {
      "shop_id": Helper().isvalidElement(SelectedPharmacy)?  SelectedPharmacy.toString():'',
    };

    var List = await PatientApi().medicineList(accesstoken, data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        //  MediAndLabNameList = List['list'];
        medicineList = List['list'];
        MedicineLoader=true;
        valid=true;
        isLoading=true;
        filtermedicine(searchmedicine.text);
        // filterItems(searchText.text);
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }
   void filtermedicine(String text) {
   
    if (text.isEmpty) {
      setState(() {
        medicine_List = medicineList;
      });
    } else if (text.length >= 3) {
      setState(() {
        medicine_List = medicineList
            .where(
              (item) => item['name']
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()),
              // item['phone']
              //     .toString()
              //     .toLowerCase()
              //     .contains(text.toLowerCase())
            )
            .toList();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height;
    double screenWidht = MediaQuery.of(context).size.width;
     Map<String, String> injectionList = {'injection_exp_date': ''};
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MedicineStock()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Stock List', style: TextStyle(color: Colors.white),),
           backgroundColor: custom_color.appcolor,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicineStock(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body:Container(
          child: Column(
            children: [
               Expanded(
                    child: SingleChildScrollView(
                      
                      child: Column(
                        children: [
                      
                         
                          injection(screenHeight,screenWidht),
                          medicine(screenHeight,screenWidht)
                          

                        ],
                      ),
                    ),
                  )
            ],
          ),
        ) ,
      ));
  }
   injection(screenHeight,screenWidth){
 return Padding(
   padding: const EdgeInsets.all(5.0),
   
   child: Column(
     children: [
      Container(
            height: screenHeight * 0.05,
            width: screenWidth,
            color: appcolor,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Injection List',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // color: Colors.amber,
          ),
          SizedBox(height:screenHeight*0.01),
           Center(
                          child: Container(
                            height: screenHeight * 0.06,
                            // width: screenWidth * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: custom_color.appcolor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Row(
                              children: [
                              
                                Container(
                                  width: screenWidth * 0.65,
                                  child: TextField(
                                    controller: searchinjection,
                                    onChanged: (text) {
                                      print(text);
                                      filterItems(text);
                                      this.setState(() {});
                            
                                    },
                                    decoration: new InputDecoration(
                                      filled: true,
                                      border: InputBorder.none,
                                      fillColor: Colors.white,
                                      hintText: 'Search Injection Name Here...',
                                    ),
                                  ),
                                ),
                                searchinjection.text.isNotEmpty
                                    ? Container(
                                        width: screenWidth * 0.06,
                                        height: screenHeight,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              searchinjection.clear();
                                              filterItems(searchinjection.text);
                                           
                                              // searchText.text = '';
                                              // searchList='';
                                            });
                                          },
                                        ))
                                    : Container(),
                                Container(
                                    width: screenWidth* 0.18,
                                    height: screenHeight,
                                    child: Icon(Icons.search,
                                        color: custom_color.appcolor)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight*0.01,),
       Container(
        
           // height: screenHeight * 0.7596,
           child: Helper().isvalidElement(injection_List) &&
                   injection_List.length > 0
               ? 
                  Container(
                    child: ListView.builder(
                       itemCount: injection_List.length,
                       physics: NeverScrollableScrollPhysics(),
                        // itemCount: 2,
                        shrinkWrap: true,
                       itemBuilder:
                           (BuildContext context, int index) {
                         var data = injection_List[index];
                         list = index + 1;
                         return Center(
                           child: Container(
                             color: index % 2 == 0
                                 ? Color.fromARGB(
                                     255, 238, 242, 250)
                                 : Colors.white,
                             width: screenWidth,
                             // height: screenHeight * 0.20,
                             // width: screenWidth * 0.90,
                             // decoration:
                             //     BoxDecoration(border: Border.all(color: Colors.grey)),
                             child: Row(
                               children: [
                                Text('($list)'),
                                 Container(
                                    width: screenWidth*0.90,
                                   child: Padding(
                                     padding: const EdgeInsets.all(4.0),
                                     child: Column(
                                       children: [
                                         Container(
                                           // color: Colors.yellow,
                                            // width: screenWidth*0.4,
                                           child: Row(
                                             children: [
                                              
                                                Text(
                                                   'Injection Name : ',style: TextStyle(
                                                           fontWeight:
                                                               FontWeight
                                                                   .bold),),
                                               Text(
                                                   '  ${data['injections_name'].toString()}')
                                             ],
                                           ),
                                         ),
                                         Container(
                                           // color: Colors.blue,
                                            // width: screenWidth*0.5,
                                           child: Row(
                                             children: [
                                               // Icon(
                                               //   Icons.calendar_month,
                                               //   // color: custom_color.appcolor,
                                               //   // color: Color
                                               //   //     .fromARGB(
                                               //   //         255,
                                               //   //         98,
                                               //   //         96,
                                               //   //         96),
                                               // ),
                                                Text(
                                                   'Qty :', style: TextStyle(
                                                     fontWeight: FontWeight.bold),),
                                               Text(
                                                   ' ${data['injection_qty'].toString()}')
                                             ],
                                           ),
                                         ),
                                         Padding(
                                           padding:
                                               const EdgeInsets.all(1.0),
                                           child: Container(
                                             child: Row(
                                               children: [
                                               
                                                  Text(
                                                     'Amt : ', style: TextStyle(
                                                       fontWeight:
                                                           FontWeight
                                                               .bold),),
                                                 Text(
                                                     ' ${data['injection_amount'].toString()}')
                                               ],
                                             ),
                                           ),
                                         ),
                                         Padding(
                                           padding:
                                               const EdgeInsets.all(1.0),
                                           child: Row(
                                             // mainAxisAlignment:
                                             //     MainAxisAlignment
                                             //         .spaceBetween,
                                             children: [
                                                Container(
                                                 // color: Colors.deepOrange,
                                                  width: screenWidth*0.8,
                                                 child: Row(
                                                   children: [
                                                     Text(
                                                       'Exp Date : ',
                                                       style: TextStyle(
                                                           fontWeight:
                                                               FontWeight
                                                                   .bold),
                                                     ),
                                                     Text(
                                                         '${data['injection_exp_date'].toString().substring(0,10)}')
                                                   ],
                                                 ),
                                               ),
                                              //  Container(
                                              //    // color: Colors.blue,
                                              //     width: screenWidth*0.5,
                                              //    // width: screenwidht * 0.55,
                                              //    child: Row(
                                              //      children: [
                                              //        Text(
                                              //          'Total Dis : ',
                                              //          style: TextStyle(
                                              //              fontWeight: FontWeight.bold),
                                              //        ),
                                              //        Text(
                                              //            '${data['discount'].toString()}.00')
                                              //      ],
                                              //    ),
                                              //  ),
                                             
                                          
                                             ],
                                           ),
                                         ),
                                        //   Padding(
                                        //    padding:
                                        //        const EdgeInsets.all(1.0),
                                        //    child: Row(
                                        //      mainAxisAlignment:
                                        //          MainAxisAlignment
                                        //              .spaceBetween,
                                        //      children: [
                                        //        Container(
                                        //          child: Row(
                                        //            children: [
                                        //              Text(
                                        //                'Bal : ',
                                        //                style: TextStyle(
                                        //                    fontWeight: FontWeight.bold),
                                        //              ),
                                        //              Text(
                                        //                  '${data['balance'].toString()}')
                                        //            ],
                                        //          ),
                                        //        ),
                                              
                                        //      ],
                                        //    ),
                                        //  ),
                                        
                                       ],
                                     ),
                                   ),
                                 ),
                                  
                               ],
                             ),
                           ),
                         );
                       }),
                  )
               : Center(
                   child: Text(''),
                 )
           
           ),
     ],
   ),
 );
   }
   medicine(screenHeight,screenWidth){
 return Padding(
   padding: const EdgeInsets.all(5.0),
   
   child: Column(
     children: [
       Container(
            height: screenHeight * 0.05,
            width: screenWidth,
            color: appcolor,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Medicine List',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // color: Colors.amber,
          ),
          SizedBox(height: screenHeight*0.01,),
           Center(
                          child: Container(
                            height: screenHeight * 0.06,
                            // width: screenWidth * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: custom_color.appcolor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Row(
                              children: [
                              
                                Container(
                                  width: screenWidth * 0.65,
                                  child: TextField(
                                    controller: searchmedicine,
                                    onChanged: (text) {
                                      print(text);
                                      filtermedicine(text);
                                      this.setState(() {});
                            
                                    },
                                    decoration: new InputDecoration(
                                      filled: true,
                                      border: InputBorder.none,
                                      fillColor: Colors.white,
                                      hintText: 'Search Medicine Name Here...',
                                    ),
                                  ),
                                ),
                                searchmedicine.text.isNotEmpty
                                    ? Container(
                                        width: screenWidth * 0.06,
                                        height: screenHeight,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              searchmedicine.clear();
                                              filtermedicine(searchmedicine.text);
                                           
                                              // searchText.text = '';
                                              // searchList='';
                                            });
                                          },
                                        ))
                                    : Container(),
                                Container(
                                    width: screenWidth* 0.18,
                                    height: screenHeight,
                                    child: Icon(Icons.search,
                                        color: custom_color.appcolor)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight*0.01,),
       Container(
        
           // height: screenHeight * 0.7596,
           child: Helper().isvalidElement(medicine_List) &&
                   medicine_List.length > 0
               ? 
                  Container(
                    child: ListView.builder(
                       itemCount: medicine_List.length,
                       physics: NeverScrollableScrollPhysics(),
                        // itemCount: 2,
                        shrinkWrap: true,
                       itemBuilder:
                           (BuildContext context, int index) {
                             list = index + 1;
                         var data = medicine_List[index];
                         return Center(
                           child: Container(
                             color: index % 2 == 0
                                 ? Color.fromARGB(
                                     255, 238, 242, 250)
                                 : Colors.white,
                             width: screenWidth,
                             // height: screenHeight * 0.20,
                             // width: screenWidth * 0.90,
                             // decoration:
                             //     BoxDecoration(border: Border.all(color: Colors.grey)),
                             child: Row(
                               children: [
                                 Text('($list)'),
                                 Container(
                                    width: screenWidth*0.90,
                                   child: Padding(
                                     padding: const EdgeInsets.all(4.0),
                                     child: Column(
                                       children: [
                                         Container(
                                           // color: Colors.yellow,
                                            // width: screenWidth*0.4,
                                           child: Row(
                                             children: [
                                              
                                                Text(
                                                   'Medicine Name : ',style: TextStyle(
                                                           fontWeight:
                                                               FontWeight
                                                                   .bold),),
                                               Text(
                                                   '  ${data['name'].toString()}')
                                             ],
                                           ),
                                         ),
                                         Container(
                                           // color: Colors.blue,
                                            // width: screenWidth*0.5,
                                           child: Row(
                                             children: [
                                               // Icon(
                                               //   Icons.calendar_month,
                                               //   // color: custom_color.appcolor,
                                               //   // color: Color
                                               //   //     .fromARGB(
                                               //   //         255,
                                               //   //         98,
                                               //   //         96,
                                               //   //         96),
                                               // ),
                                                Text(
                                                   'Qty :', style: TextStyle(
                                                     fontWeight: FontWeight.bold),),
                                                    //  totalqty
                                               Text(
                                                   ' ${data['totalqty'].toString()}')
                                             ],
                                           ),
                                         ),
                                         Padding(
                                           padding:
                                               const EdgeInsets.all(1.0),
                                           child: Container(
                                             child: Row(
                                               children: [
                                               
                                                  Text(
                                                     'Amt : ', style: TextStyle(
                                                       fontWeight:
                                                           FontWeight
                                                               .bold),),
                                                               
                                                 Text(
                                                     ' ${data['cost'].toString()}')
                                               ],
                                             ),
                                           ),
                                         ),
                                         Padding(
                                           padding:
                                               const EdgeInsets.all(1.0),
                                           child: Row(
                                             // mainAxisAlignment:
                                             //     MainAxisAlignment
                                             //         .spaceBetween,
                                             children: [
                                                Container(
                                                 // color: Colors.deepOrange,
                                                  width: screenWidth*0.4,
                                                 child: Row(
                                                   children: [
                                                     Text(
                                                       'Exp Date : ',
                                                       style: TextStyle(
                                                           fontWeight:
                                                               FontWeight
                                                                   .bold),
                                                     ),
                                                    //  Text(
                                                    //      '${data['expiry_date'].toString()}')
                                                     Text(
                                                         '${data['expiry_date']==null ? "000.00.00" :data['expiry_date']}')
                                                    // Text(
                                                    //      '${data['expiry_date']==null ? "000.00.00" :data['expiry_date']}')
                                                   ],
                                                 ),
                                               ),
                                              //  Container(
                                              //    // color: Colors.blue,
                                              //     width: screenWidth*0.5,
                                              //    // width: screenwidht * 0.55,
                                              //    child: Row(
                                              //      children: [
                                              //        Text(
                                              //          'Total Dis : ',
                                              //          style: TextStyle(
                                              //              fontWeight: FontWeight.bold),
                                              //        ),
                                              //        Text(
                                              //            '${data['discount'].toString()}.00')
                                              //      ],
                                              //    ),
                                              //  ),
                                             
                                          
                                             ],
                                           ),
                                         ),
                                        //   Padding(
                                        //    padding:
                                        //        const EdgeInsets.all(1.0),
                                        //    child: Row(
                                        //      mainAxisAlignment:
                                        //          MainAxisAlignment
                                        //              .spaceBetween,
                                        //      children: [
                                        //        Container(
                                        //          child: Row(
                                        //            children: [
                                        //              Text(
                                        //                'Bal : ',
                                        //                style: TextStyle(
                                        //                    fontWeight: FontWeight.bold),
                                        //              ),
                                        //              Text(
                                        //                  '${data['balance'].toString()}')
                                        //            ],
                                        //          ),
                                        //        ),
                                              
                                        //      ],
                                        //    ),
                                        //  ),
                                        
                                       ],
                                     ),
                                   ),
                                 ),
                                  
                               ],
                             ),
                           ),
                         );
                       }),
                  )
               : Center(
                   child: Text(''),
                 )
           
           ),
     ],
   ),
 );
   }
   
}