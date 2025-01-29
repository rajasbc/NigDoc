import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
//import 'package:nigdoc/AppWidget/DoctorWidget/Referral/AddReferralList.dart';
//import 'package:nigdoc/AppWidget/DoctorWidget/Referral/Edit%20Referral.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/StaffWidget/Referral/AddReferralList.dart';
import 'package:nigdoc/AppWidget/StaffWidget/Referral/EditReferral.dart';
import 'package:nigdoc/AppWidget/common/SearchBar.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
// import 'package:nigdoc/AppWidget/AppWidget/common/Colors.dart'as custom_color;
import '../../../AppWidget/common/Colors.dart' as custom_color;

class Referral extends StatefulWidget {
  const Referral({super.key});

  @override
  State<Referral> createState() => _ReferralState();
}


class _ReferralState extends State<Referral> {
  TextEditingController searchText = TextEditingController();
  var select_list;
var title = {'Name', 'Email', 'Number'};
var userResponse;
var accesstoken;
List referralList = [];
bool isLoading= false;
var list=0;
  @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];

    getreferralList();
    // TODO: implement initState
    super.initState();
  }
  var searchList;
  List test_List = [];
  @override
  Widget build(BuildContext context) {
    // test_List=Helper().isvalidElement(searchList)&&searchText.text.isNotEmpty?searchList: referralList;
    // test_List=Helper().isvalidElement(searchList)&&searchText.text.isNotEmpty?searchList: Helper().isvalidElement(referralList) && Helper().isvalidElement(referralList) ? referralList == null ? '' : referralList : '';
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Setting()));
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Referral List',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: custom_color.appcolor,
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
            )),
        body:isLoading? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: SafeArea(
              child: Container(
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.grey),
                //   borderRadius: BorderRadius.circular(5.0),
                // ),
                
                child: Column(
                  children: [
                    Container(
              // SizedBox(height: screenHeight*0.02,),
                 child:    Column(
                      children: [
                        SizedBox(height: screenHeight*0.02,),
                        Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: SearchBarWithIcons(
                                     controller: searchText,
                                     hintText: 'Search Referral List Here...',
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
                        //       Container(
                        //         height: screenHeight * 0.06,
                        //         width: screenWidth*0.96,
                        //         decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             border:
                        //                 Border.all(color: custom_color.appcolor),
                        //             borderRadius: BorderRadius.all(Radius.circular(4))),
                        //         child: Row(
                        //           children: [
                        //             // Container(
                        //             //     width: screenWidth * 0.1,
                        //             //     height: screenHeight,
                        //             //     child: Icon(Icons.search,
                        //             //         color: custom_color.appcolor)),
                        //             Container(
                        //               width: screenWidth * 0.65,
                        //               child: TextField(
                        //                 controller: searchText,
                        //                 onChanged: (text) {
                        //                   print(text);
                        //             filterItems(text);
                        //                   this.setState(() {});
                        //                   // // var list = ProductListItem;
                        //                   //   searchList =  referralList.where((element) {
                        //                   //     var treatList = element['name'].toString().toLowerCase();
                        //                   //     return treatList.contains(text.toLowerCase());
                        //                   //     // return true;
                        //                   //   }).toList();
                        //                   //   this.setState(() {});
                        //                 },
                        //                 decoration: new InputDecoration(
                        //                   filled: true,
                        //                   border: InputBorder.none,
                        //                   fillColor: Colors.white,
                        //                   hintText: 'Search Referral List Here...',
                        //                 ),
                        //               ),
                        //             ),
                        //             searchText.text.isNotEmpty
                        //                 ? Container(
                        //                     width: screenWidth * 0.08,
                        //                     height: screenHeight,
                        //                     child: IconButton(
                        //                       icon: Icon(
                        //                         Icons.close,
                        //                         color: Colors.red,
                        //                       ),
                        //                       onPressed: () {
                        //                         setState(() {
                        //                           searchText.clear();
                        //                           filterItems(searchText.text);
                        //                           // searchList='';
                        //                         });
                        //                       },
                        //                     ))
                        //                 : Container(),
                        //                  Container(
                        //                 width: screenWidth * 0.22,
                        //                 height: screenHeight,
                        //                 child: Icon(Icons.search,
                        //                     color: custom_color.appcolor)),
                        //           ],
                        //         ),
                        //       ),),
                      ],
                    ),
                    ),
                    SizedBox(height: screenHeight*0.02,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:Helper().isvalidElement(test_List) &&
                          test_List.length > 0?  ListView.builder(
                        shrinkWrap: true,
                        itemCount: test_List.length,
                        itemBuilder: (BuildContext context, int index) {
                           var data = test_List[index];

                                 list=index+1;
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                color: index % 2 == 0
                                    ? custom_color.lightcolor
                                    : Colors.white,
                                width: screenWidth,
                                // height: screenHeight * 0.20,
                                // width: screenWidth * 0.90,
                                // decoration:
                                //     BoxDecoration(border: Border.all(color: Colors.grey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                       SizedBox(width: screenWidth*0.02,),
                                                 Text('($list)',style: TextStyle(fontWeight: FontWeight.bold),),
                                                            SizedBox(width: screenWidth*0.01,),
                                      Container(
                                        width: screenWidth*0.68,
                                        // color: Colors.red,
                                        child: Column(
                                          children: [
                                            
                                            Container(
                                              // color: Colors.amber,
                                              width: screenWidth * 0.60,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Name : ${data['name'].toString()}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  //  Text(
                                                  //   'Name :',
                                                  //   style: TextStyle(
                                                  //       fontWeight:
                                                  //           FontWeight.bold),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: screenWidth * 0.60,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Mobile No : ${data['mobile_no'].toString()}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: screenWidth*0.60,
                                              child: Text(
                                                'Email : ${data['email_id'].toString()}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            // Container(
                                            //   padding: const EdgeInsets.only(
                                            //       left: 320, bottom: 0, top: 0),
                                            //   child: PopupMenuButton(
                                            //     itemBuilder: (context) => [
                                            //       PopupMenuItem(
                                            //         child: Row(
                                            //           children: [
                                            //             Icon(
                                            //               Icons.edit,
                                            //               color: custom_color.appcolor,
                                            //             ),
                                            //             Padding(
                                            //               padding:
                                            //                   EdgeInsets.only(left: 10),
                                            //               child: Text(
                                            //                 'Edit',
                                            //                 style:
                                            //                     TextStyle(fontSize: 16),
                                            //               ),
                                            //             ),
                                            //           ],
                                            //         ),
                                            //         onTap: (() {
                                            //           Navigator.push(
                                            //               context,
                                            //               MaterialPageRoute(
                                            //                   builder: (context) =>
                                            //                       Edit_Referral()));
                                            //         }),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: screenWidth*0.00,),
                                      Container(
                                         child:PopupMenuButton(
                                           itemBuilder: (context) => [
                                             PopupMenuItem(
                                               child: Row(
                                                 children: [
                                                   Icon(
                                                     Icons.edit,
                                                     color: custom_color.appcolor,
                                                   ),
                                                   SizedBox(width: screenWidth*0.02,),
                                                   Text(
                                                     'Edit',
                                                     style:
                                                         TextStyle(fontSize: 16),
                                                   ),
                                                 ],
                                               ),
                                               onTap: (() {
                                                 Navigator.push(
                                                     context,
                                                     MaterialPageRoute(
                                                         builder: (context) =>
                                                             Edit_Referral(select_referral : data)));
                                               }),
                                             ),
                                           ],
                                         ),
                                        width: screenWidth*0.2,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ):Center(child: Center(child: Text('No Data Found'))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ):Center(
            child: Container(child:SpinLoader())),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Add_referralList()));
          }),
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
          backgroundColor: custom_color.appcolor,
        ),
      ),
    );
  }
  getreferralList() async {
    var List = await PatientApi().getreferralList(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        isLoading=true;
        referralList = List['list'];
        filterItems(searchText.text);
      });
     
    }
  }
  void filterItems(String text) {
    // setState(() {
    if (text.isEmpty) {
      setState(() {
        test_List = referralList;
      });
    } 
    else if (text.length >= 3) {
      setState(() {
        test_List = referralList.where((item) =>
            item['name']
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase())||
            item['mobile_no']
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase())
                ).toList();
      });
    }
  }
}
