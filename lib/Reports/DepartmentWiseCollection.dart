import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/SearchBar.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/Reports/report.dart';
import '../../AppWidget/common/Colors.dart'as custom_color;

class Departmentcollection extends StatefulWidget {
  const Departmentcollection({super.key});

  @override
  State<Departmentcollection> createState() => _DepartmentcollectionState();
}

class _DepartmentcollectionState extends State<Departmentcollection> {
  TextEditingController fromdateInputController = TextEditingController();
  TextEditingController todateInputController = TextEditingController();
  TextEditingController searchText = TextEditingController();
  var list=0;
  var userResponse;
  var accesstoken;
  bool isLoading = true;
  var searchList;
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
  List depList = [];
   List depList1 = [];

   final DateFormate = "yyyy-MM-dd";
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
      getdepreportList();
      // fromdateInputController.text = pickedDate.toString().split(' ')[0];
      // getsummaryList();
      // get();
      // getdoctorlist();
    } else {
      todateInputController.text = DateFormat(DateFormate).format(pickedDate!);
     getdepreportList();
      // getsummaryList();
      // get();
      // getdoctorlist();
    }
  }
  @override
  Widget build(BuildContext context) {
    // depList1 =
        // Helper().isvalidElement(searchList) && searchText.text.isNotEmpty
        //     ? searchList
        //     : depList;
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
              'Department Collection',
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
                      SizedBox(height: screenHeight*0.02),
                      // Center(
                      //       child: Container(
                      //         height: screenHeight * 0.06,
                      //         width: screenWidth,
                      //         decoration: BoxDecoration(
                      //             // color: Colors.white,
                      //             border:
                      //                 Border.all(color: custom_color.appcolor),
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(4))),
                      //         child: Row(
                      //           children: [
                      //             Container(
                      //                 width: screenWidth * 0.1,
                      //                 height: screenHeight,
                      //                 child: Icon(Icons.search,
                      //                     color: custom_color.appcolor)),
                      //             Container(
                      //               width: screenWidth * 0.71,
                      //               child: TextField(
                      //                 controller: searchText,
                      //                 onChanged: (text) {
                      //                   // Ensure the input is at least 3 characters long before filtering
                      //                   if (text.length >= 3) {
                      //                     setState(() {
                      //                       searchList =
                      //                           depList.where((element) {
                      //                         var groupList1 =
                      //                             element['dep_name']
                      //                                 .toString()
                      //                                 .toLowerCase();
                      //                         return groupList1
                      //                             .contains(text.toLowerCase());
                      //                       }).toList();
                      //                     });
                      //                   } else {
                      //                     setState(() {
                      //                       searchList = [];
                      //                     });
                      //                   }
                      //                 },
                      //                 decoration: InputDecoration(
                      //                   // filled: true,
                      //                   border: InputBorder.none,
                      //                   // fillColor: Colors.white,
                      //                   hintText:
                      //                       'Search Department List Here...',
                      //                 ),
                      //               ),
                      //             ),

                      //             searchText.text.isNotEmpty
                      //                 ? Container(
                      //                     width: screenWidth * 0.06,
                      //                     height: screenHeight,
                      //                     child: IconButton(
                      //                       icon: Icon(
                      //                         Icons.close,
                      //                         color: Colors.red,
                      //                       ),
                      //                       onPressed: () {
                      //                         setState(() {
                      //                           searchText.text = '';
                      //                           searchList = '';
                      //                         });
                      //                       },
                      //                     ))
                      //                 : Container(),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      // SizedBox(height: screenHeight*0.02),
                      //  isLoading?Helper().isvalidElement(depList1) && depList1.length > 0 ?
                      Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: SearchBarWithIcons(
                            
                                     controller: searchText,
                                     hintText: 'Search Department Name Here...',
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
                     Container(
                      height:screenHeight,
                      child: 
                      Column(
                        children: [
                          //    Container(
                          //     height: screenHeight * 0.06,
                          //     width: screenWidth,
                          //     decoration: BoxDecoration(
                          //         // color: Colors.white,
                          //         border:
                          //             Border.all(color: custom_color.appcolor),
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(4))),
                          //     child: Row(
                          //       children: [
                          //         Container(
                          //             width: screenWidth * 0.1,
                          //             height: screenHeight,
                          //             child: Icon(Icons.search,
                          //                 color: custom_color.appcolor)),
                          //         Container(
                          //           width: screenWidth * 0.71,
                          //           child: TextField(
                          //             controller: searchText,
                          //             onChanged: (text) {
                          //               // Ensure the input is at least 3 characters long before filtering
                          //               if (text.length >= 3) {
                          //                 setState(() {
                          //                   searchList =
                          //                       depList.where((element) {
                          //                     var groupList1 =
                          //                         element['dep_name']
                          //                             .toString()
                          //                             .toLowerCase();
                          //                     return groupList1
                          //                         .contains(text.toLowerCase());
                          //                   }).toList();
                          //                 });
                          //               } else {
                          //                 setState(() {
                          //                   searchList = [];
                          //                 });
                          //               }
                          //             },
                          //             decoration: InputDecoration(
                          //               // filled: true,
                          //               border: InputBorder.none,
                          //               // fillColor: Colors.white,
                          //               hintText:
                          //                   'Search Department Name Here...',
                          //             ),
                          //           ),
                          //         ),

                          //         searchText.text.isNotEmpty
                          //             ? Container(
                          //                 width: screenWidth * 0.06,
                          //                 height: screenHeight,
                          //                 child: IconButton(
                          //                   icon: Icon(
                          //                     Icons.close,
                          //                     color: Colors.red,
                          //                   ),
                          //                   onPressed: () {
                          //                     setState(() {
                          //                       searchText.text = '';
                          //                       searchList = '';
                          //                     });
                          //                   },
                          //                 ))
                          //             : Container(),
                          //       ],
                          //     ),
                          
                          // ),
                       isLoading?Helper().isvalidElement(depList1) && depList1.length > 0 ?
                          Container(
                              height: screenHeight * 0.80,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: depList1.length,
                              // itemCount: 10,
                              itemBuilder: (BuildContext context, int index){
                                list=index+1;
                                var data=depList1[index];
                                return Container(
                                  child: Column(
                                    children: [
                                      Card(
                                        color: index % 2 == 0
                                                      ? custom_color.lightcolor
                                                      : Colors.white,
                                                      child: ListTile(
                                          leading: Text('$list',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                          title: SizedBox(child: Text('Department Name : ${data['dep_name']}',style: TextStyle(fontWeight: FontWeight.bold))),
                                          // subtitle: SizedBox(child: Text('Total Fees : ${data['total_fees']}')),
                                          // trailing:SizedBox(child: Text('Paid : ${data['paid']}')),
                                          
                                          subtitle: Column(
                                            children: [
                                              Container(
                                                width: screenWidth*0.77,
                                                child: Text('Total Fees : ${data['total_fees']}',style: TextStyle(fontWeight: FontWeight.bold),)),
                                                // SizedBox(height: screenHeight*0.01,),
                                              Container(
                                                 width: screenWidth*0.77,
                                                child: Text('Paid : ${data['paid']}',style: TextStyle(fontWeight: FontWeight.bold))),
                                                // SizedBox(height: screenHeight*0.01,),
                                              Container(
                                                 width: screenWidth*0.77,
                                                child: Text('Balance : ${data['balance']}',style: TextStyle(fontWeight: FontWeight.bold)))
                                            ],
                                          ),
                                          
                                          
                            
                                    //                             trailing: PopupMenuButton(itemBuilder: (context)=>[
                                    //                               PopupMenuItem(child: Row(
                                    //                                       children: [
                                    //                                         Icon(Icons.edit,color: custom_color.appcolor,),
                                    //                                         Padding(padding: EdgeInsets.only(left: 10),
                                    //                                         child: Text('Edit',style: TextStyle(fontSize: 16),),)
                                    //                                       ],
                                    //                                     ),
                                    //                                     onTap: () {
                                    //                                        Navigator.push(
                                    //   context, MaterialPageRoute(builder: (context)=> Edittreatment(medicinelist:data),)
                                    //  );
                                              
                                    //                                     },
                                    //                                     ),
                            
                                                  
                            
                            
                                    //                             ]
                                          
                                    //                             ),
                                                 
                                        ),
                                      )
                                    ],
                                  ),
                                  
                                );
                                
                            }),
                          ):Container(child:
            Text('No Data Found')
          ):Container(child: SpinLoader(),)
                        ],
                      ),
                      
                       )
                       
          //              :Container(child:
          //   Text('No Data Found')
          // ):Container(child: SpinLoader(),)
                    ],
                  ),
                ),
              ),
            )),
      ));
  }
  getdepreportList() async {
    // var formatter = new DateFormat('yyyy-MM-dd');
    isLoading = false;
    var data = {
      "from_date": fromdateInputController.text.toString(),
      "to_date": todateInputController.text.toString(),
     
    };
    // this.setState(() {
    //   isLoading = true;
    // });
    var list = await PatientApi().getDepartmentWisReport(accesstoken, data);
    if (Helper().isvalidElement(list) &&
        Helper().isvalidElement(list['status']) &&
        list['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      depList = list['list'];
       filterItems(searchText.text);
      // for(var data in prescriptionList){
     
      this.setState(() {
        isLoading = true;
      });
    }
  }
  void filterItems(String text) {
   
    if (text.isEmpty) {
      setState(() {
        depList1 = depList;
      });
    } else if (text.length >= 3) {
      setState(() {
        depList1 = depList
            .where(
              (item) => item['dep_name']
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
}