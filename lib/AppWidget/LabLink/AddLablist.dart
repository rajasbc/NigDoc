import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/LabLink/LabList.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class AddLablist extends StatefulWidget {
  const AddLablist({super.key});

  @override
  State<AddLablist> createState() => _AddLablistState();
}

class _AddLablistState extends State<AddLablist> {
  TextEditingController Searchcontroller = TextEditingController();
  List labList = [];
  var accesstoken;
  var list = 0;
  var userResponse;
  bool searchList = false;
  var selected_status;
var status =[
     'ENABLED',
     'DISABLED'
];
  @override
  void initState() {
    init();

    super.initState();
    //  initilzeMethod();
  }

  init() async {
    // await storage.ready;
    userResponse = await storage.getItem('userResponse');
    accesstoken = await userResponse['access_token'];
    //subcategory = await storage.getItem('list');
  }
var labtype = 'lab';
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
     Map<String, String> data = {
      'name': ''
    };
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LabList()));
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Add Lab List',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LabList()));
              },
              icon: Icon(
                Icons.arrow_back,
              ),
              color: Colors.white,
            ),
            backgroundColor: custom_color.appcolor,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Center(
                      child: Container(
                        height: screenHeight * 0.06,
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: custom_color.appcolor),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Row(
                          children: [
                            // Container(
                            //     width: screenWidth * 0.1,
                            //     height: screenHeight,
                            //     child: Icon(Icons.search,
                            //         color: custom_color.appcolor)),
                            Container(
                              width: screenWidth * 0.65,
                              child: TextField(
                                controller: Searchcontroller,
                                
                                onChanged: (text) async {
                                  if (text.isEmpty) {
                                  setState(() {
                                    labList.clear();
                                    // ProductListItem = Product_List;
                                  });
                                } else if (text.length >= 3) {
                                  setState(() async{
                                   
                                    var data = {
                                    "searchname":
                                        Searchcontroller.text.toString(),
                                    "mobile_no":
                                        Searchcontroller.text.toString(),
                                  };
                                  var List = await PatientApi()
                                      .searchlab(accesstoken, data);
                                  print(List);
                                  labList = List['list'];
                                  print(labList);

                                  this.setState(() {});
      });
    }
                                  // print(text);
                                  // var data = {
                                  //   "searchname":
                                  //       Searchcontroller.text.toString(),
                                  //   "mobile_no":
                                  //       Searchcontroller.text.toString(),
                                  // };
                                  // var List = await PatientApi()
                                  //     .searchlab(accesstoken, data);
                                  // print(List);
                                  // labList = List['list'];
                                  // print(labList);
                                  // this.setState(() {});
                                },
                                decoration: new InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  hintText: 'Search Lab Name or Number',
                                ),
                              ),
                            ),
                            Searchcontroller.text.isNotEmpty
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
                                          Searchcontroller.text = '';
                                          labList.clear();
                                          // labList='';
                                        });
                                      },
                                    ))
                                : Container(),
                                Container(
                                width: screenWidth * 0.18,
                                height: screenHeight,
                                child: Icon(Icons.search,
                                    color: custom_color.appcolor)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        child: Helper().isvalidElement(labList) &&
                                labList.length > 0
                            ? Container(
                                height: screenHeight * 0.75,
                                width: screenWidth,
                                padding: EdgeInsets.all(5),
                                child: ListView.builder(
                                    // shrinkWrap: true,
                                    itemCount: labList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      list = index + 1;
                                      var data = labList[index];
                                      return InkWell(
                                        onTap: () {
                                          var data1= data;
                                          // print(data1);
                                          // pop(data1);
                                          showDialog(
                              context: context,
                              builder: ((context) => AlertDialog(
                                    actions: [
                                      Padding(padding: EdgeInsets.all(10)),
                                      Container(
                                        height: screenHeight * 0.04,
                                        width: screenWidth * 0.14,
                                      ),
                                      Container(
                                        child: Column(
                      children: [
                        SizedBox(height: screenHeight*0.02,),
                                   
                                       Padding(
                                       padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                      //padding: const EdgeInsets.all(20),
                      child: Container(
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.96,
                        
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0)
                            // border: OutlineInputBorder()
                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          
                          child: Center(
                            child: DropdownButtonFormField(
                            
                              decoration: InputDecoration.collapsed(hintText: ''),
                              isExpanded: true,
                              hint: Padding(
                             
                              padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
                                child: Text(
                                  'Status',
                                 
                                ),
                                
                              ),
                             
                              onChanged: (selected) {
                                selected_status = selected;
                                setState(() {
                                 
                                });
                              },
                              items: status.map<DropdownMenuItem<String>>((item) {
                                return new DropdownMenuItem(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
                                    child: new Text(item,style: TextStyle(fontSize: 15),),
                                  ),
                                  value: item.toString(),
                                );
                              }).toList(),
                            ),
                            
                          ),
                        ),
                      ),
                                        ),
                       SizedBox(height: screenHeight*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all<Color>(
                                          custom_color.appcolor),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      )),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddLablist()));
                                  },
                                  child: Text(
                                    'Cancel',
                                    style:
                                        TextStyle(color: Colors.white, fontSize: 20),
                                  )),
                            ),
                            // SizedBox(width: screenWidth*0.02,),
                            Container(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all<Color>(
                                        custom_color.appcolor),
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                                child: Text(
                                  'Update',
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                onPressed: (() async {
                                             if(selected_status == null){
                                            NigDocToast().showErrorToast('Select Status');
                                           }else{
                                         var item = {
                                          "pharmacy_name":data['name'].toString(),
                                          "link_type":labtype.toString(),
                                          "shop_id":data['id'].toString(),                                       
                                          "status":selected_status.toString(),
                                          'email':data['email'].toString(),
                                          'mobile_no':data['mobile_no'].toString(),
                        
                                          };
                                         var list = await PatientApi()
                                   .Addlablink( accesstoken, item);
                                    if (list['message'] ==
                                        " Add successfully") {
                                      NigDocToast().showSuccessToast(
                                          ' Add successfully');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LabList()));
                                    } else {
                                      NigDocToast()
                                          .showErrorToast('Please TryAgain later');
                                    }
                                                                    }
                                }),
                              ),
                            ),
                          ],
                        ),
                      ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.04,
                                      ),
                                    ],
                                  )));
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Card(
                                                  color: index % 2 == 0
                                                      ? custom_color.lightcolor
                                                      : Colors.white,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: 
                                                     ListTile(
                                      leading: Text('$list',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                      title: SizedBox(child: Text('Lab Name : ${data['name']}',style: TextStyle(fontWeight: FontWeight.bold))),
                                      // subtitle: SizedBox(child: Text('Total Fees : ${data['total_fees']}')),
                                      // trailing:SizedBox(child: Text('Paid : ${data['paid']}')),
                                      
                                      subtitle: Column(
                                        children: [
                                          Container(
                                            width: screenWidth*0.77,
                                            child: Text('Mobile: ${data['mobile_no']}',style: TextStyle(fontWeight: FontWeight.bold),)),
                                            SizedBox(height: screenHeight*0.01,),
                                          Container(
                                             width: screenWidth*0.77,
                                            child: Text('Address : ${data['address1']}',style: TextStyle(fontWeight: FontWeight.bold))),
                                            SizedBox(height: screenHeight*0.01,),
                                          // Container(
                                          //    width: screenWidth*0.77,
                                          //   child: Text('Balance : ${data['balance']}',style: TextStyle(fontWeight: FontWeight.bold)))
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
                                                    // Container(
                                                    //   child: Column(
                                                    //     children: [
                                                    //       Row(
                                                    //         // mainAxisAlignment:
                                                    //         //     MainAxisAlignment
                                                    //         //         .spaceBetween,
                                                    //         children: [
                                                    //           Container(
                                                    //             // color: Colors.amber,
                                                    //             width: screenWidth * 0.52,
                                                    //             child: Row(
                                                    //               children: [
                                                    //                 Text(
                                                    //                   'Name : ${data['name'].toString()}',
                                                    //                   style: TextStyle(
                                                    //                       fontWeight:
                                                    //                           FontWeight.bold),
                                                    //                 ),
                                                    //                 // Flexible(child: Text("${data['name']}")),
                                                    //               ],
                                                    //             ),
                                                    //           ),
                                                    //           Row(
                                                    //             children: [
                                                    //               Text(
                                                    //                 'Mobile : ${data['mobile_no']}',
                                                    //                 style: TextStyle(
                                                    //                     fontWeight:
                                                    //                         FontWeight
                                                    //                             .bold),
                                                    //               ),
                                                    //               //  Flexible(child: Text("${data['mobile_no']}")),
                                                    //               // Text("9876543210"),
                                                    //             ],
                                                    //           ),
                                                    //         ],
                                                    //       ),
                                                    //       SizedBox(
                                                    //         height: 5,
                                                    //       ),
                                                    //       // Row(
                                                    //       //   mainAxisAlignment:
                                                    //       //       MainAxisAlignment.spaceBetween,
                                                    //       //   children: [
                                                    //       //     Row(
                                                    //       //       children: [
                                                    //       //         Text(
                                                    //       //           'Email : "${data['email']}',
                                                    //       //           style: TextStyle(
                                                    //       //               fontWeight:
                                                    //       //                   FontWeight.bold),
                                                    //       //         ),
                                                    //       //         // Text("Saveetha@gmail.com"),
                                                    //       //         //  Flexible(child: Text("${data['email']}")),
                                                    //       //       ],
                                                    //       //     ),
                                                    //       //     Row(
                                                    //       //       children: [
                                                    //       //         Text(
                                                    //       //           'City : ',
                                                    //       //           style: TextStyle(
                                                    //       //               fontWeight:
                                                    //       //                   FontWeight.bold),
                                                    //       //         ),
                                                    //       //         // Text("Dharmapuri"),
                                                    //       //       ],
                                                    //       //     ),
                                                    //       //   ],
                                                    //       // ),
                                                    //       //  SizedBox(
                                                    //       //   height: 5,
                                                    //       // ),
                                                    //       Row(
                                                    //         mainAxisAlignment:
                                                    //             MainAxisAlignment
                                                    //                 .spaceBetween,
                                                    //         children: [
                                                    //           Row(
                                                    //             children: [
                                                    //               Text(
                                                    //                 'Address : ${data['address1']}',
                                                    //                 style: TextStyle(
                                                    //                     fontWeight:
                                                    //                         FontWeight
                                                    //                             .bold),
                                                    //               ),
                                                    //               // Text("qwertyui8o9pdfg"),
                                                    //             ],
                                                    //           ),
                                                    //           Row(
                                                    //             children: [
                                                    //               // Text(
                                                    //               //   'Status: ',
                                                    //               //   style: TextStyle(
                                                    //               //       fontWeight:
                                                    //               //           FontWeight.bold),
                                                    //               // ),
                                                    //               // Text("${data['status'].toString()}",style: TextStyle(color: data['status'].toString().toLowerCase()=='enabled'?Colors.green:Colors.red),),
                                                    //             ],
                                                    //           ),
                                                    //         ],
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    }))
                            : Center(child: Text('No Data Found')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  // pop(data) {
  //   double screenHeight = MediaQuery.of(context).size.height;
  //   double screenWidth = MediaQuery.of(context).size.width;
  //   showDialog(
  //       context: context,
  //       builder: ((context) => AlertDialog(
  //             actions: [
  //               Padding(padding: EdgeInsets.all(10)),
  //               Container(
  //                 height: screenHeight * 0.04,
  //                 width: screenWidth * 0.14,
  //               ),
  //               Container(
  //                 child: Column(
  //                   children: [
  //                     SizedBox(height: screenHeight*0.02,),
             
  //                Padding(
  //                padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
  //                   //padding: const EdgeInsets.all(20),
  //                   child: Container(
  //                     height: screenHeight * 0.07,
  //                     width: screenWidth * 0.96,
                      
  //                     decoration: BoxDecoration(border: Border.all(color: Colors.grey),
  //                     borderRadius: BorderRadius.circular(5.0)
  //                         // border: OutlineInputBorder()
  //                         ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(10),
                        
  //                       child: Center(
  //                         child: DropdownButtonFormField(
                          
  //                           decoration: InputDecoration.collapsed(hintText: ''),
  //                           isExpanded: true,
  //                           hint: Padding(
                           
  //                           padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
  //                             child: Text(
  //                               'Status',
                               
  //                             ),
                              
  //                           ),
                           
  //                           onChanged: (selected) {
  //                             selected_status = selected;
  //                             setState(() {
                               
  //                             });
  //                           },
  //                           items: status.map<DropdownMenuItem<String>>((item) {
  //                             return new DropdownMenuItem(
  //                               child: Padding(
  //                                 padding: const EdgeInsets.only(top: 7, left: 8, right: 8),
  //                                 child: new Text(item,style: TextStyle(fontSize: 15),),
  //                               ),
  //                               value: item.toString(),
  //                             );
  //                           }).toList(),
  //                         ),
                          
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                    SizedBox(height: screenHeight*0.02,),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         Container(
  //                           child: ElevatedButton(
  //                               style: ButtonStyle(
  //                                   backgroundColor: WidgetStateProperty.all<Color>(
  //                                       custom_color.appcolor),
  //                                   shape: WidgetStateProperty.all<
  //                                       RoundedRectangleBorder>(
  //                                     RoundedRectangleBorder(
  //                                       borderRadius: BorderRadius.circular(10),
  //                                     ),
  //                                   )),
  //                               onPressed: () {
  //                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>AddLablist()));
  //                               },
  //                               child: Text(
  //                                 'Cancel',
  //                                 style:
  //                                     TextStyle(color: Colors.white, fontSize: 20),
  //                               )),
  //                         ),
  //                         // SizedBox(width: screenWidth*0.02,),
  //                         Container(
  //                           child: ElevatedButton(
  //                             style: ButtonStyle(
  //                                 backgroundColor: WidgetStateProperty.all<Color>(
  //                                     custom_color.appcolor),
  //                                 shape: WidgetStateProperty.all<
  //                                     RoundedRectangleBorder>(
  //                                   RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(10),
  //                                   ),
  //                                 )),
  //                             child: Text(
  //                               'Update',
  //                               style: TextStyle(color: Colors.white, fontSize: 20),
  //                             ),
  //                             onPressed: (() async {
  //                                          if(selected_status == null){
  //                                         NigDocToast().showErrorToast('Select Status');
  //                                        }else{
  //                                      var item={
  //                                       "pharmacy_name":data1['pharmacy_name'].toString(),
  //                                       "link_type":data1['link_type'].toString(),
  //                                       "shop_id":data1['shop_id'].toString(),                                       
  //                                       "status":selected_status.toString(),
                      
  //                                       };
  //                                      var list = await PatientApi()
  //                                .Addlablink( accesstoken, item);
  //                                 if (list['message'] ==
  //                                     "Add successfully") {
  //                                   NigDocToast().showSuccessToast(
  //                                       'Add successfully');
  //                                   Navigator.push(
  //                                       context,
  //                                       MaterialPageRoute(
  //                                           builder: (context) => LabList()));
  //                                 } else {
  //                                   NigDocToast()
  //                                       .showErrorToast('Please TryAgain later');
  //                                 }
  //                                                                 }
  //                             }),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: screenHeight * 0.04,
  //               ),
  //             ],
  //           )));
  // }
}
