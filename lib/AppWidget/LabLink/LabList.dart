import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/LabLink/AddLablist.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart'as custom_color;

class LabList extends StatefulWidget {
  const LabList({super.key});

  @override
  State<LabList> createState() => _LabListState();
}

class _LabListState extends State<LabList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  TextEditingController mobilenocontroller = TextEditingController();
  TextEditingController namecontrollrt = TextEditingController();
  TextEditingController Searchcontroller = TextEditingController();
  var list;
  var accesstoken;
  List lablist = [];
  bool isloading=false;
   var ProductshowAutoComplete = true;
   List labList = [];
   List labListItem = [];
   var searchList;
   List lab_List = [];
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
    //  lab_List=Helper().isvalidElement(searchList)&&Searchcontroller.text.isNotEmpty?searchList: Helper().isvalidElement(lablist) && Helper().isvalidElement(lablist) ? lablist == null ? '' : lablist : '';
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
              'Lab List',
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
                Center(child: 
                Container(
                  height: screenHeight * 0.06,
                  width: screenWidth*0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color:custom_color.appcolor),
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
                          onChanged: (text) {
                             filterItems(text);
                            // print(text);

                            this.setState(() {
                             
                              
                            });
                            // var list = ProductListItem;
                              // searchList = lablist.where((element) {
                              //   var treatList = element['pharmacy_name'].toString().toLowerCase();
                              //   return treatList.contains(text.toLowerCase());
                              //   // return true;
                              // }).toList();
                              // this.setState(() {});
                          },
                          decoration: new InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            hintText: 'Search Lab List Here...',
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
                                    Searchcontroller.clear();
                                    filterItems(Searchcontroller.text);
                                      // filterItems(Searchcontroller.text);
                                    // Searchcontroller.text = '';
                                    // searchList='';
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
                ),),
                SizedBox(height: screenHeight*0.02,),
                Container(
                  child: Helper().isvalidElement(lab_List)&&lab_List.length>0? Container(
                      height: screenHeight * 0.75,
                      width: screenWidth,
                      padding: EdgeInsets.all(5),
                      child: ListView.builder(
                          // shrinkWrap: true,
                          itemCount: lab_List.length,
                          itemBuilder: (BuildContext context, int index) {
                            list = index + 1;
                            var data=lab_List[index];
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
                                              Container(width: screenWidth,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Lab Name:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  Flexible(child: Text("${data['pharmacy_name']}")),
                                                  ],
                                                ),
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
                                              //           'Email : ${data['email']}',
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
                                                    'Status: ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text("${data['status'].toString()}",style: TextStyle(color: data['status'].toString().toLowerCase()=='enabled'?Colors.green:Colors.red),),
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
                ),
              ],
            ),
          ):Center(child: SpinLoader()),
           floatingActionButton: FloatingActionButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>AddLablist()));
          },
          child: Icon(Icons.add,
          size: 30,
          color: Colors.white,
          ),
          backgroundColor:custom_color.appcolor,
          ),
        )
        );
  }
  getMediAndLabNameList() async {
    var data = {
      "type":'lab',
    };
    var List = await PatientApi().getMediAndLabNameList(accesstoken, data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        isloading=true;
        lablist = List['list'];
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
        lab_List = lablist;
      });
    } 
    else if (text.length >= 3) {
      setState(() {
        lab_List = lablist.where((item) =>
            item['pharmacy_name']
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
}
