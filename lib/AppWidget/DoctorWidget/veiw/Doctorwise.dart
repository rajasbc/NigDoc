import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nigdoc/AppWidget/DoctorWidget/Api.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/Reports/report.dart';
import '../../../AppWidget/common/Colors.dart'as custom_color;

class doctor_wise extends StatefulWidget {
  const doctor_wise({super.key});

  @override
  State<doctor_wise> createState() => _doctor_wiseState();
}

class _doctor_wiseState extends State<doctor_wise> {
  TextEditingController fromdateInputController = TextEditingController();
  TextEditingController todateInputController = TextEditingController();
  var list=0;
  var userResponse;
  var accesstoken;
  bool isLoading = true;
   var DoctorList;
   String DoctorDropdownvalue = '';
  
  @override
  void initState() {
     accesstoken = storage.getItem('userResponse')['access_token'];
    userResponse = storage.getItem('userResponse');
    // accesstoken=userResponse['access_token'];
    fromdateInputController.text = Helper().getCurrentDate();
    todateInputController.text = Helper().getCurrentDate();
    getdoctorlist();
    getdoctorwiseList();
    // getsummaryList();
    // TODO: implement initState
    super.initState();
  }
  List reportList = [];

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
       getdoctorwiseList();
      // fromdateInputController.text = pickedDate.toString().split(' ')[0];
      // getsummaryList();
      // get();
      // getdoctorlist();
    } else {
      todateInputController.text = DateFormat(DateFormate).format(pickedDate!);
      getdoctorwiseList();
      // getsummaryList();
      // get();
      // getdoctorlist();
    }
  }
  String selected_level ='OUT';

var title =[
     'OUT',
     'IN',
     
];
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting()));
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Doctor Wise',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor:custom_color.appcolor,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setting(),
                    ));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: screenHeight,
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
                    Container(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.95,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.all(Radius.circular(5))
                              // border: OutlineInputBorder()
                              ),
                      child: Helper().isvalidElement(DoctorList)&&DoctorList.length>0? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: DropdownButtonFormField(
                            menuMaxHeight: 300,
                            // validator: (value) => validateDrops(value),
                            // isExpanded: true,
                            decoration: InputDecoration.collapsed(hintText: ''),
                            isExpanded: true,
                            hint: Padding(
                              padding:
                                  const EdgeInsets.only(top: 0, left: 2, right: 0,),
                              child: Text(
                                'Select Doctor *',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 112, 107, 107)),
                              ),
                            ),
                            // value:' _selectedState[i]',
                            onChanged: (selecteddoctor) {
                              setState(() {
                                DoctorDropdownvalue=selecteddoctor.toString();
                                getdoctorwiseList();
                                // selectedDoctor = selectedDoctor;
                                // print("Stae value");
                                // print(newValue);
                                // _selectedState[i]= newValue;
                                // getMyDistricts(newValue, i);
                              });
                            },
                            items: DoctorList.map<DropdownMenuItem<String>>((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['name'].toString()),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                      :DropdownButtonFormField(
                        // menuMaxHeight: 300,
                                                                // validator: (value) => validateDrops(value),
                                                                // isExpanded: true,
                                                                hint: Text(
                                                                    'No Doctor List'),
                                                                // value:' _selectedState[i]',
                                                                onChanged:
                                                                    (Pharmacy) {
                                                                  setState(() {});
                                                                },
                                                                items: [].map<
                                                                    DropdownMenuItem<
                                                                        String>>((item) {
                                                                  return new DropdownMenuItem(
                                                                    child:
                                                                        new Text(
                                                                            ''),
                                                                    value: '',
                                                                  );
                                                                }).toList(),
                                                              ),
                    ),
                     SizedBox(height: screenHeight*0.02,),
                     Container(
                       height: screenHeight * 0.07,
                       width: screenWidth * 0.96,
                       decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                       borderRadius: BorderRadius.circular(5.0)
                           // border: OutlineInputBorder()
                           ),
                       child: Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Center(
                           child: DropdownButtonFormField(
                           
                             decoration: InputDecoration.collapsed(hintText: ''),
                             isExpanded: true,
                             hint: Padding(
                             padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
                               child: Text(
                                //  'Title ',
                                 selected_level
                                 // '${data['title'] == ''? selected_level :selected_level}'  
                                
                               ),
                             ),
                            
                             onChanged: (selectedstaffs) {
                               selected_level=selectedstaffs.toString();
                               getdoctorwiseList();
                               setState(() {
                                
                               });
                             },
                             items: title.map<DropdownMenuItem<String>>((item) {
                               return new DropdownMenuItem(
                                 child: Padding(
                                   padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                                   child: new Text(item,style: TextStyle(fontSize: 15),),
                                 ),
                                 value: item.toString(),
                               );
                             }).toList(),
                           ),
                         ),
                       ),
                     ),
                  SizedBox(height: screenHeight*0.02,),
                     isLoading?Helper().isvalidElement(reportList) && reportList.length > 0 ?
                   Expanded(
                     child: SingleChildScrollView(
                       child: Container(
                        // height:screenHeight * 0.80,
                        
                       
                                           //  width: screenWidth,
                        // padding:EdgeInsets.all(15),
                        child: 
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          
                          itemCount: reportList.length,
                          // itemCount: 101,
                          itemBuilder: (BuildContext context, int index){
                            list=index+1;
                            var data=reportList[index];
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
                                                      width: screenWidth * 0.38,
                                                      child: Row(
                                                        children: [
                                                        //  Text("Date : ")
                                                          Text("Date : ${data['date'].substring(0 ,10)}")
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      // color: Colors.purple,
                                                      width: screenWidth * 0.43,
                                                      child: Row(
                                                        children: [
                                                        
                                                          Text('Pat No : ${data['patient_id']}')
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
                                                      width: screenWidth * 0.38,
                                                      child: Row(
                                                        children: [
                                                         
                                                          Text("Dr Name : ${data['doctor_name'].toString().toUpperCase()}")
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      // color: Colors.purple,
                                                      width: screenWidth * 0.43,
                                                      child: Row(
                                                        children: [
                                                         
                                                          Text('Name : ${data['name'].toString()}')
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
                                                      width: screenWidth * 0.38,
                                                      child: Row(
                                                        children: [
                                                        
                                                          Text("Moblie : ${data['mobile'].toString()}")
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      // color: Colors.purple,
                                                      width: screenWidth * 0.43,
                                                      child: Row(
                                                        children: [
                                                        
                                                          Text('Email : ${data['email'].toString()}')
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: screenHeight*0.01,),
                                                // Container(
                                                //   // color: Colors.amber,
                                                //   width: screenWidth * 0.80,
                                                //   child: Row(
                                                //     children: [
                                                    
                                                //       Text("Prescription : ${data['paid'].toString().toUpperCase()}")
                                                //     ],
                                                //   ),
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
                                                // SizedBox(height: screenHeight*0.01,),
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
                        
                         ),
                     ),
                   )
                     
                                 :Container(child:
                      Text('No Data Found')
                    ):Container(child: SpinLoader(),)
                  ],
                ),
              ),
            )),
      ));
  }
  getdoctorwiseList() async {
    // var formatter = new DateFormat('yyyy-MM-dd');
    isLoading = false;
    var data = {
      "from_date": fromdateInputController.text.toString(),
      "to_date": todateInputController.text.toString(),
      "patient_type":selected_level.toString(),
      "doctor_id":DoctorDropdownvalue.toString(),
    };
    // this.setState(() {
    //   isLoading = true;
    // });
    var list = await PatientApi().getdoctorWise(accesstoken, data);
    if (Helper().isvalidElement(list) &&
        Helper().isvalidElement(list['status']) &&
        list['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      reportList = list['list'];
     
      this.setState(() {
        isLoading = true;
      });
    }
  }
   getdoctorlist() async {
   
   var doctorlist = await api().getdoctorlist(accesstoken);
    if (Helper().isvalidElement(doctorlist) &&
        Helper().isvalidElement(doctorlist['status']) &&
        doctorlist['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      DoctorList = doctorlist['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
      this.setState(() {
        isLoading = true;
      });
    }
  }
}