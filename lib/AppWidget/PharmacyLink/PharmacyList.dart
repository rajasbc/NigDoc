import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/PharmacyLink/Addpharmacy.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/common/SearchBar.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart'as custom_color;

class PharmacyList extends StatefulWidget {
  const PharmacyList({super.key});

  @override
  State<PharmacyList> createState() => _PharmacyListState();
}

class _PharmacyListState extends State<PharmacyList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  TextEditingController  Searchcontroller = TextEditingController();
  var list;
  var accesstoken;
  List Pharmacylist = [];
  bool isloading=false;
  List labListItem = [];
  var searchList;
  List Pharmacy_List = [];
  @override
  void initState() {
    var userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];
    getMediAndLabNameList();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // Pharmacy_List=Helper().isvalidElement(searchList)&&Searchcontroller.text.isNotEmpty?searchList: Pharmacylist;
    //  Pharmacy_List=Helper().isvalidElement(searchList)&&Searchcontroller.text.isNotEmpty?searchList: Helper().isvalidElement(Pharmacylist) && Helper().isvalidElement(Pharmacylist) ? Pharmacylist == null ? '' : Pharmacylist : '';
    double screenHeight = MediaQuery.of(context).size.height - 50;
    double screenWidth = MediaQuery.of(context).size.width;
    return new WillPopScope(
        onWillPop: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Setting(),
              ));
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'Pharmacy List',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor:custom_color.appcolor ,
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
          body:isloading? Container(
            height: screenHeight,
            width: screenWidth,
            child:Column(
              children: [
                
                SizedBox(height: screenHeight*0.02,),
                Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: SearchBarWithIcons(
                                     controller: Searchcontroller,
                                     hintText: 'Search Pharmacy List Here...',
                                     onTextChanged: (text) {
                                       setState(() {
                                         filterItems(text);
                                       });
                                     },
                                     onClearPressed: () {
                                       setState(() {
                                         Searchcontroller.clear();
                                         filterItems('');
                                       });
                                     },
                                     onSearchPressed: () {
                                      
                                       
                                     },
                                   ),
                         ),
                // Center(child: 
                // Container(
                //   height: screenHeight * 0.06,
                //   width: screenWidth*0.9,
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       border:
                //           Border.all(color:custom_color.appcolor),
                //       borderRadius: BorderRadius.all(Radius.circular(4))),
                //   child: Row(
                //     children: [
                //       // Container(
                //       //     width: screenWidth * 0.1,
                //       //     height: screenHeight,
                //       //     child: Icon(Icons.search,
                //       //         color: custom_color.appcolor)),
                //       Container(
                //         width: screenWidth * 0.65,
                //         child: TextField(
                //           controller: Searchcontroller,
                //           onChanged: (text) {
                //              filterItems(text);
                //             // print(text);
                          
                //             this.setState(() {
                             
                              
                //             });
                //             // var list = Pharmacylist;
                //             //   searchList = Pharmacylist.where((element) {
                //             //     var treatList = element['pharmacy_name'].toString().toLowerCase();
                //             //     return treatList.contains(text.toLowerCase());
                //             //     return true;
                //             //   }).toList();
                //             //   this.setState(() {});
                //           },
                //           decoration: new InputDecoration(
                //             filled: true,
                //             border: InputBorder.none,
                //             fillColor: Colors.white,
                //             hintText: 'Search Pharmacy List Here...',
                //           ),
                //         ),
                //       ),
                //       Searchcontroller.text.isNotEmpty
                //           ? Container(
                //               width: screenWidth * 0.06,
                //               height: screenHeight,
                //               child: IconButton(
                //                 icon: Icon(
                //                   Icons.close,
                //                   color: Colors.red,
                //                 ),
                //                 onPressed: () {
                //                   setState(() {
                //                     Searchcontroller.clear();
                //                     filterItems(Searchcontroller.text);
                //                       // filterItems(Searchcontroller.text);
                //                     // Searchcontroller.text = '';
                //                     // searchList='';
                //                   });
                //                 },
                //               ))
                //           : Container(),
                //            Container(
                //           width: screenWidth * 0.18,
                //           height: screenHeight,
                //           child: Icon(Icons.search,
                //               color: custom_color.appcolor)),
                //     ],
                //   ),
                // ),),
                SizedBox(height: screenHeight*0.02,),
                Helper().isvalidElement(Pharmacy_List)&&Pharmacy_List.length>0? Container(
                    height: screenHeight * 0.75,
                    width: screenWidth,
                    padding: EdgeInsets.all(5),
                    child: ListView.builder(
                        // shrinkWrap: true,
                        itemCount: Pharmacy_List.length,
                        itemBuilder: (BuildContext context, int index) {
                          list = index + 1;
                          var data=Pharmacy_List[index];
                          return Container(
                            child: Column(
                              children: [
                                Card(
                                    color: index % 2 == 0
                                        ? custom_color.lightcolor
                                        : Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Pharmacy Name :',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(" ${data['pharmacy_name']}"),
                                                  ],
                                                ),
                                                // Row(
                                                //   children: [
                                                //     Text(
                                                //       'Mobile : ${data['mobile_no']}',
                                                //       style: TextStyle(
                                                //           fontWeight:
                                                //               FontWeight.bold),
                                                //     ),
                                                //     // Text("9876543210"),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.spaceBetween,
                                            //   children: [
                                            //     Row(
                                            //       children: [
                                            //         Text(
                                            //           'Email :',
                                            //           style: TextStyle(
                                            //               fontWeight:
                                            //                   FontWeight.bold),
                                            //         ),
                                            //         // Text("Saveetha@gmail.com"),
                                            //       ],
                                            //     ),
                                            //     Row(
                                            //       children: [
                                            //         Text(
                                            //           'City : ',
                                            //           style: TextStyle(
                                            //               fontWeight:
                                            //                   FontWeight.bold),
                                            //         ),
                                            //         // Text("Dharmapuri"),
                                            //       ],
                                            //     ),
                                            //   ],
                                            // ),
                                             SizedBox(
                                              height: 5,
                                            ),
                                           
                                            Row(
                                              children: [
                                                Text(
                                                  'Status : ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(" ${data['status'].toString()}",style: TextStyle(color: data['status'].toString().toLowerCase()=='enabled'?Colors.green:Colors.red),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          );
                        })):Center(child:Text('No Data Found')),
              ],
            ),
          ):Center(child: SpinLoader()),
           floatingActionButton: FloatingActionButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>AddPharmancylist()));
          },
          child: Icon(Icons.add,
          size: 30,
          color: Colors.white,
          ),
          backgroundColor:custom_color.appcolor,
          ),
        ));
  }
  getMediAndLabNameList() async {
    var data = {
      "type":'pharmacy',
    };
    var List = await PatientApi().getMediAndLabNameList(accesstoken, data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        isloading=true;
        Pharmacylist = List['list'];
        filterItems(Searchcontroller.text);
        // var values = MediAndLabNameList;
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }
  void filterItems(String text) {
    // setState(() {
    if (text.isEmpty) {
      setState(() {
        Pharmacy_List = Pharmacylist;
      });
    } else if (text.length >= 2) {
      setState(() {
        Pharmacy_List = Pharmacylist.where((item) => item['pharmacy_name']
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase())).toList();
           
      });
    }
  }
}
