import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/Admission/Admission.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/SearchBar.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class Admissionlist extends StatefulWidget {
  const Admissionlist({super.key});

  @override
  State<Admissionlist> createState() => _AdmissionlistState();
}

class _AdmissionlistState extends State<Admissionlist> {
   final LocalStorage storage = new LocalStorage('doctor_store');
  final DateFormate = "yyyy-MM-dd";
  TextEditingController fromdateInputController = TextEditingController();
  TextEditingController todateInputController = TextEditingController();
  TextEditingController searchText = TextEditingController();
   DateTime currentDate = DateTime.now();
  Future<void> selectDate(BuildContext context, data) async {
    var checkfield = data;
    // print(data);
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: custom_color.appcolor,
                onPrimary: Colors.white, 
                onSurface: custom_color.appcolor, 
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: custom_color.appcolor, 
                ),
              ),
            ),
            child: child!,
          );
        },
        initialDate: currentDate,
        firstDate: DateTime(DateTime.now().year-2, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    if (checkfield == "from") {
      // var formatter = new DateFormat('dd-MM-yyyy');
      fromdateInputController.text =
          DateFormat(DateFormate).format(pickedDate!);

      // fromdateInputController.text = pickedDate.toString().split(' ')[0];
      getadmissionlist();
    } else {
      todateInputController.text = DateFormat(DateFormate).format(pickedDate!);
      // todateInputController.text = pickedDate.toString().split(' ')[0];
      getadmissionlist();
    }
  }
  var accesstoken;
  bool isLoading = false;
  var admission_list;
  var searchList;
  var admissionlist;
   void initState() {
    super.initState();
    accesstoken = storage.getItem('userResponse')['access_token'];
    fromdateInputController.text = Helper().getCurrentDate();
    todateInputController.text = Helper().getCurrentDate();
    getadmissionlist();

    // print('ddd');
  }
  getadmissionlist() async {
    // var formatter = new DateFormat('yyyy-mm-dd');
    var formatter = new DateFormat('yyyy-MM-dd');
    var data = {
      "from_date": fromdateInputController.text.toString(),
      "to_date": todateInputController.text.toString(),
      
    };
    // this.setState(() {
    //   isLoading = true;
    // });
     var List = await PatientApi().getAdmissionList(accesstoken, data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      admission_list = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        filterItems(searchText.text);
        isLoading = true;
      });
    }
  }
   void filterItems(String text) {
    // setState(() {
    if (text.isEmpty) {
      setState(() {
        admissionlist = admission_list;
      });
    } 
    else if (text.length >= 3) {
      setState(() {
        admissionlist = admission_list.where((item) =>
            item['p_name']
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase()),
            // item['phone']
            //     .toString()
            //     .toLowerCase()
            //     .contains(text.toLowerCase())
                ).toList();
      });
    }
  }
  var list =0;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidht = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Admission()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admission List',style: TextStyle(color: Colors.white),),
           backgroundColor:custom_color.appcolor,
          leading: IconButton(onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Admission(),)
         );
          }, icon: Icon(Icons.arrow_back,
          color: Colors.white,),),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                
                 Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: screenWidht,
                      height: screenHeight * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: screenWidht * 0.45,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'From',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                labelText: 'From',
                                suffixIcon: Icon(
                                  Icons.date_range,
                                  color: custom_color.appcolor,
                                ),
                              ),
                              controller: fromdateInputController,
                              readOnly: true,
                              onTap: () async {
                                selectDate(context, 'from');
                              },
                            ),
                          ),
                          Container(
                            width: screenWidht * 0.45,
                            child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'To',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  labelText: 'To',
                                  suffixIcon: Icon(
                                    Icons.date_range,
                                    color: custom_color.appcolor,
                                  ),
                                ),
                                controller: todateInputController,
                                readOnly: true,
                                onTap: () async {
                                  selectDate(context, 'to');
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 3,
                  ),
                   Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: SearchBarWithIcons(
                                     controller: searchText,
                                     hintText: 'Search Admission List Here...',
                                     onTextChanged: (text) {
                                       setState(() {
                                         filterItems(text);
                                       });
                                     },
                                     onClearPressed: () {
                                       setState(() {
                                         searchText.clear();
                                         filterItems('');
                                       });
                                     },
                                     onSearchPressed: () {
                                     
                                     },
                                   ),
                         ),
                  // Center(child: 
                  //     Container(
                  //       height: screenHeight * 0.06,
                  //       width: screenWidht*0.95,
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           border:
                  //               Border.all(color: custom_color.appcolor,),
                  //           borderRadius: BorderRadius.all(Radius.circular(4))),
                  //       child: Row(
                  //         children: [
                  //           // Container(
                  //           //     width: screenWidth * 0.1,
                  //           //     height: screenHeight,
                  //           //     child: Icon(Icons.search,
                  //           //         color: custom_color.appcolor,)),
                  //           Container(
                  //             width: screenWidht * 0.65,
                  //             child: TextField(
                  //               controller: searchText,
                  //               onChanged: (text) {
                  //                 print(text);
                  //           filterItems(text);
                  //                 this.setState(() {});
                                 
                  //               },
                  //               decoration: new InputDecoration(
                  //                 filled: true,
                  //                 border: InputBorder.none,
                  //                 fillColor: Colors.white,
                  //                 hintText: 'Search Admission List Here...',
                  //               ),
                  //             ),
                  //           ),
                  //           searchText.text.isNotEmpty
                  //               ? Container(
                  //                   width: screenWidht * 0.06,
                  //                   height: screenHeight,
                  //                   child: IconButton(
                  //                     icon: Icon(
                  //                       Icons.close,
                  //                       color: Colors.red,
                  //                     ),
                  //                     onPressed: () {
                  //                       setState(() {
                  //                         searchText.clear();
                  //                         filterItems(searchText.text);
                  //                         searchList='';
                  //                       });
                  //                     },
                  //                   ))
                  //               : Container(),
                  //                Container(
                  //               width: screenWidht * 0.18,
                  //               height: screenHeight,
                  //               child: Icon(Icons.search,
                  //                   color: custom_color.appcolor,)),
                  //         ],
                  //       ),
                  //     ),),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                          // color: Colors.white,
                          // height: screenHeight * 0.7596,
                          child: Helper().isvalidElement(admissionlist) &&
                                  admissionlist.length > 0
                              ?
                               ListView.builder(
                                  itemCount: admissionlist.length,
                                  // itemCount: 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var data = admissionlist[index];
                                     list=index+1;
                                    // var paid = data['grand_total'] - data['balance'];
                                    return Center(
                                      child: Container(
                                        color: index % 2 == 0
                                            ? Color.fromARGB(
                                                255, 238, 242, 250)
                                            : Colors.white,
                                        width: screenWidht,
                                        // height: screenHeight * 0.20,
                                        // width: screenWidth * 0.90,
                                        // decoration:
                                        //     BoxDecoration(border: Border.all(color: Colors.grey)),
                                        child: Row(
                                          children: [
                                             Text('($list)'),
                                            Container(
                                               width: screenWidht*0.90,
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(1.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                         
                                                          Container(
                                                            // width: screenwidht * 0.47,
                                                            child: Row(
                                                              children: [
                                                                 Text(
                                                                  'Patient  Id : ',
                                                                  // style: TextStyle(
                                                                  //     fontWeight:
                                                                  //         FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),
                                                                ),
                                                                 Text(
                                                                    '${data['p_id'].toString()}')
                                                               
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Row(
                                                              children: [
                                                                //  Text(
                                                                //   'Admission Date : ',
                                                                //   // style: TextStyle(
                                                                //   //     fontWeight:
                                                                //   //         FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),
                                                                // ),
                                                                Icon(
                                                                    Icons
                                                                        .calendar_month,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            98,
                                                                            96,
                                                                            96),
                                                                  ),
                                                                Text(
                                                                    ' ${data['a_date'].substring(0 ,11)}')
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(1.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            //  width: screenwidht * 0.47,
                                                            child: Row(
                                                              children: [
                                                                 Text(
                                                                  'Name : ',
                                                                  // style: TextStyle(
                                                                  //     fontWeight:
                                                                  //         FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),
                                                                ),
                                                                Text(
                                                                    '${data['p_name'].toString()}')
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            // width: screenwidht * 0.47,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'Admission No : ',
                                                                  // style: TextStyle(
                                                                  //     fontWeight:
                                                                  //         FontWeight.bold,color: Color.fromARGB(255, 54, 50, 50)),
                                                                ),
                                                                Text(
                                                                    '${data['Admission_no'].toString()}')
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.only(left: 1),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Admission Dr : ',
                                                                // style: TextStyle(
                                                                //     // fontWeight:
                                                                //     //     FontWeight.bold
                                                                //         color: Color.fromARGB(255, 54, 50, 50)),
                                                              ),
                                                              Text(
                                                                      '${ data['d_name'].toString()}')
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          // width: screenwidht * 0.55,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Ward : ',
                                                                // style: TextStyle(
                                                                //     // fontWeight:
                                                                //     //     FontWeight.bold
                                                                //         color: Color.fromARGB(255, 54, 50, 50)),
                                                              ),
                                                              Text(
                                                                  '${data['ward_name']}')
                                                            ],
                                                          ),
                                                        ),
                                                      
                                                      ],
                                                    ),
                                                     Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.only(left: 1),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Bed No : ',
                                                                // style: TextStyle(
                                                                //     // fontWeight:
                                                                //     //     FontWeight.bold
                                                                //         color: Color.fromARGB(255, 54, 50, 50)),
                                                              ),
                                                              Text(
                                                                      '${ data['bed_number'].toString() }')
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          // width: screenwidht * 0.55,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Bed Category : ',
                                                                // style: TextStyle(
                                                                //     // fontWeight:
                                                                //     //     FontWeight.bold
                                                                //         color: Color.fromARGB(255, 54, 50, 50)),
                                                              ),
                                                              Text(
                                                                  '${data['bed_category_name'].toString()}')
                                                            ],
                                                          ),
                                                        ),
                                                      
                                                      ],
                                                    ),
                                                     Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.only(left: 1),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Amt : ',
                                                                // style: TextStyle(
                                                                //     // fontWeight:
                                                                //     //     FontWeight.bold
                                                                //         color: Color.fromARGB(255, 54, 50, 50)),
                                                              ),
                                                              Text(
                                                                      '${ data['grand_total'].toString()}')
                                                            ],
                                                          ),
                                                        ),
                                                       
                                                      
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Icon(Icons.menu)
                                            // PopupMenuButton(
                                            // itemBuilder: (context) => [
                                            
                                            //   PopupMenuItem(
                                            //         child: Row(
                                            //           children: [
                                            //             // Icon(
                                            //             //   Icons.edit,
                                            //             //   color:Customcolor.app_color,
                                            //             // ),
                                            //             Padding(
                                            //               padding:
                                            //                   EdgeInsets.only(
                                            //                       left: 0),
                                            //               child: Row(
                                            //                 children: [
                                            //                   Icon(
                                            //                     FontAwesomeIcons
                                            //                         .file,
                                            //                     color: Colors
                                            //                         .blue,
                                            //                   ),
                                            //                   Text(
                                            //                     '  Pay',
                                            //                     style: TextStyle(
                                            //                         fontSize:
                                            //                             16),
                                            //                   ),
                                            //                 ],
                                            //               ),
                                            //             ),
                                            //           ],
                                            //         ),
                                            //         onTap: (() async {
                                            //           // await storage.setItem('pendingAmount',data);
                                            //           //  Navigator.push(context, MaterialPageRoute(builder: (context)=>PendingPayment()));
                                            //         }),
                                            //       ),
                                                  
                                            // ]),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                              : Center(
                                  child: Text('No Data Found'),
                                )
                          // :
                          // Text('Nodata'),
                          ),
                    ),
                  )
              ],
            ),
          )),
      ));
  }
}