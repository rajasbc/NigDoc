import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/Reports/report.dart';
import '../../AppWidget/common/Colors.dart'as custom_color;

class collectionreport extends StatefulWidget {
  const collectionreport({super.key});

  @override
  State<collectionreport> createState() => _collectionreportState();
}

class _collectionreportState extends State<collectionreport> {
  TextEditingController fromdateInputController = TextEditingController();
  TextEditingController todateInputController = TextEditingController();
  var list=0;
  var userResponse;
  var accesstoken;
  bool isLoading = true;
  @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];
    fromdateInputController.text = Helper().getCurrentDate();
    todateInputController.text = Helper().getCurrentDate();

    // getsummaryList();
    // TODO: implement initState
    super.initState();
  }
  List collectionreportList = [];

   final DateFormate = "dd-MM-yyyy";
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
        firstDate: DateTime(DateTime.now().year-3, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    if (checkfield == "from") {
      // var formatter = new DateFormat('dd-MM-yyyy');
      fromdateInputController.text =
          DateFormat(DateFormate).format(pickedDate!);
     getcollectionreportList();
      // fromdateInputController.text = pickedDate.toString().split(' ')[0];
      // getsummaryList();
      // get();
      // getdoctorlist();
    } else {
      todateInputController.text = DateFormat(DateFormate).format(pickedDate!);
     getcollectionreportList();
      // getsummaryList();
      // get();
      // getdoctorlist();
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
     Map<String, String> data = {
      'date': '',
      'patient_name':''
      
    };
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>report()));
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Collection Report',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor:custom_color.appcolor,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => report(),
                    ));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
            
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight*0.01),
                      Container(
                        width: screenWidth,
                        height: screenHeight * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: screenWidth * 0.45,
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
                              width: screenWidth * 0.45,
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
                      SizedBox(height: screenHeight*0.02,),
                    isLoading?  Helper().isvalidElement(collectionreportList) && collectionreportList.length > 0 ?
                     Container(
                      height:screenHeight * 0.80,
                      

                    //  width: screenWidth,
                      // padding:EdgeInsets.all(15),
                      child: 
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: collectionreportList.length,
                        // itemCount: 10,
                        itemBuilder: (BuildContext context, int index){
                          list=index+1;
                          var data=collectionreportList[index];
                          return Container(
                            child: Column(
                              children: [
                                Card(
                                  color: index % 2 == 0
                                                ? custom_color.lightcolor
                                                : Colors.white,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          SizedBox(width: screenWidth*0.01,),
                                                          // Text('1'),
                                           Text('($list)',style: TextStyle(fontWeight: FontWeight.bold),),
                                                      SizedBox(width: screenWidth*0.02,),
                                                          Column(
                                                            children: [
                                                              SizedBox(height: screenHeight*0.02,),
                                                              Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    // color: Colors.amber,
                                                    width: screenWidth * 0.36,
                                                    child: Row(
                                                      children: [
                                                      //  Text('Date')
                                                        Text("Date : ${data['date'].substring(0 ,10)}")
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    // color: Colors.purple,
                                                    width: screenWidth * 0.36,
                                                    child: Row(
                                                      children: [ 
                                                      // Text('Expense :')
                                                        Text('Expense : ${data['expense']}')
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: screenHeight*0.01,),
                                               Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    // color: Colors.amber,
                                                    width: screenWidth * 0.36,
                                                    child: Row(
                                                      children: [
                                                      //  Text('Date')
                                                        Text("Amount : ${data['amount'].toString().toUpperCase()}")
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    // color: Colors.purple,
                                                    width: screenWidth * 0.36,
                                                    child: Row(
                                                      children: [
                                                      //  Text('Amount :')
                                                        Text('Collection : ${data['collection'].toString()}')
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // SizedBox(height: screenHeight*0.01,),
                                              // Row(
                                              //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     Container(
                                              //       // color: Colors.amber,
                                              //       width: screenWidth * 0.36,
                                              //       child: Row(
                                              //         children: [
                                              //         Text('Collection :')
                                              //           // Text("Collection : ${data['pre_amount'].toString()}")
                                              //         ],
                                              //       ),
                                              //     ),
                                              //     Container(
                                              //       // color: Colors.purple,
                                              //       width: screenWidth * 0.36,
                                              //       child: Row(
                                              //         children: [
                                              //         Text('Action'),
                                              //           // Text('Action : ${data['total_fees'].toString()}')
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              SizedBox(height: screenHeight*0.01,),
                                              // Row(
                                              //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     Container(
                                              //       // color: Colors.amber,
                                              //       width: screenWidth * 0.40,
                                              //       child: Row(
                                              //         children: [
                                                      
                                              //           Text("Paid : ${data['paid'].toString().toUpperCase()}")
                                              //         ],
                                              //       ),
                                              //     ),
                                              //     Container(
                                              //       // color: Colors.purple,
                                              //       width: screenWidth * 0.46,
                                              //       child: Row(
                                              //         children: [
                                                      
                                              //           Text('Discount : ${data['discount'].toString()}')
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              // SizedBox(height: screenHeight*0.01,),
                                              // Row(
                                              //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     Container(
                                              //       // color: Colors.amber,
                                              //       width: screenWidth * 0.85,
                                              //       child: Row(
                                              //         children: [
                                                        
                                              //           Text("Balance : ${data['balance'].toString()}")
                                              //         ],
                                              //       ),
                                              //     ),
                                              //     // Container(
                                              //     //   color: Colors.purple,
                                              //     //   width: screenWidth * 0.44,
                                              //     //   child: Row(
                                              //     //     children: [
                                              //     //       Text(
                                              //     //         'Fees :',
                                              //     //         style: TextStyle(
                                              //     //             fontWeight: FontWeight.bold),
                                              //     //       ),
                                              //     //       // Text('${data['contact_no'].toString()}')
                                              //     //     ],
                                              //     //   ),
                                              //     // ),
                                              //   ],
                                              // ),
                                              SizedBox(height: screenHeight*0.01,),
                                                            ],
                                                          ),
                                                          
//                                                           PopupMenuButton(itemBuilder: (context)=>[
//                                       PopupMenuItem(child: Row(
//                                               children: [
//                                                 Icon(Icons.edit,color: custom_color.appcolor,),
//                                                 Padding(padding: EdgeInsets.only(left: 10),
//                                                 child: Text('Edit',style: TextStyle(fontSize: 16),),)
//                                               ],
//                                             ),
//                                             onTap: () {
//           //                                      Navigator.push(
//           // context, MaterialPageRoute(builder: (context)=> Edittreatment(medicinelist:data),)
//         //  );
// //                                          
//                                             },
//                                             ),

                                            


//                                     ]
                                    
//                                     ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                
//                                   child: ListTile(
//                                     // title: SizedBox(child: Text('${data['treatment']}')),
                                    
//                                     leading: Text('$list'),

//                                     trailing: PopupMenuButton(itemBuilder: (context)=>[
//                                       PopupMenuItem(child: Row(
//                                               children: [
//                                                 Icon(Icons.edit,color: custom_color.appcolor,),
//                                                 Padding(padding: EdgeInsets.only(left: 10),
//                                                 child: Text('Edit',style: TextStyle(fontSize: 16),),)
//                                               ],
//                                             ),
//                                             onTap: () {
//                                                Navigator.push(
//           context, MaterialPageRoute(builder: (context)=> Edittreatment(medicinelist:data),)
//          );
// //                                          
//                                             },
//                                             ),

                                            


//                                     ]
                                    
//                                     ),
                     
//                                   ),
                                   
                                )
                              ],
                            ),
                            
                          );
                          
                      }),
                      
                       )
                       
                       :Container(child:
            Text('No Data Found')
          ):Container(child: Center(child: SpinLoader()),)
                    ],
                  ),
                ),
              ),
            )),
      ));
  }
  getcollectionreportList() async {
    // var formatter = new DateFormat('yyyy-MM-dd');
    isLoading = false;
    var data = {
      "from_date": fromdateInputController.text.toString(),
      "to_date": todateInputController.text.toString(),
     
    };
    // this.setState(() {
    //   isLoading = true;
    // });
    var list = await PatientApi().getcollectionreport(accesstoken, data);
    if (Helper().isvalidElement(list) &&
        Helper().isvalidElement(list['status']) &&
        list['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      collectionreportList = list['list'];
      // for(var data in prescriptionList){
      //        if(DoctorDropdownvalue == 'All'){
      //         presc_list.add(data);
      //        }
      // }
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isLoading = true;
      });
    }
  }
}