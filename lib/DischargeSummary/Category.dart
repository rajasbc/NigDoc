import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SearchBar.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/DischargeSummary/Dischargesummary.dart';
import 'package:nigdoc/DischargeSummary/Viewcategory.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class categorylist extends StatefulWidget {
  const categorylist({super.key});

  @override
  State<categorylist> createState() => _categorylistState();
}

class _categorylistState extends State<categorylist> {
  final LocalStorage storage = new LocalStorage('doctor_store');
  TextEditingController categorynamecontroller = TextEditingController();
  TextEditingController editcategorynamecontroller = TextEditingController();
  TextEditingController searchText = TextEditingController();
  final FocusNode categoryFocusNode = FocusNode();
  final FocusNode editcategoryFocusNode = FocusNode();
  var userResponse;
  var accesstoken;
  List categoryList = [];
  List categoryList1 = [];
  bool isLoading = false;
  var delete = 'yes';
  var searchList;
  @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken = userResponse['access_token'];
    // getMediAndLabNameList();
    getcategorylist();

    // gettreatmentlist();
    // TODO: implement initState
    super.initState();
  }

  void dispose() {
    categoryFocusNode.dispose();
    editcategoryFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // categoryList1 =
    //     Helper().isvalidElement(searchList) && searchText.text.isNotEmpty
    //         ? searchList
    //         : categoryList;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => dischargesummary()));
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Category List',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: custom_color.appcolor,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => dischargesummary(),
                    ));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: isLoading
              ? SafeArea(
                  child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Container(
                      // height: screenHeight,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                           padding: const EdgeInsets.all(5.0),
                           child: SearchBarWithIcons(
                                     controller: searchText,
                                     hintText: 'Search Category List Here...',
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
                          // Center(
                          //   child: Container(
                          //     height: screenHeight * 0.06,
                          //     width: screenWidth,
                          //     decoration: BoxDecoration(
                          //         color: Colors.white,
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
                          //         // Container(
                          //         //   width: screenWidth * 0.71,
                          //         //   child: TextField(
                          //         //     controller: searchText,
                          //         //     onChanged: (text) {
                          //         //       // print(text);

                          //         //       this.setState(() {});
                          //         //       // var list = ProductListItem;
                          //         //       searchList =
                          //         //           categoryList.where((element) {
                          //         //         var groupList1 =
                          //         //             element['category_name']
                          //         //                 .toString()
                          //         //                 .toLowerCase();
                          //         //         return groupList1
                          //         //             .contains(text.toLowerCase());
                          //         //         // return true;
                          //         //       }).toList();
                          //         //       this.setState(() {});
                          //         //     },
                          //         //     decoration: new InputDecoration(
                          //         //       filled: true,
                          //         //       border: InputBorder.none,
                          //         //       fillColor: Colors.white,
                          //         //       hintText:
                          //         //           'Search Category List Here...',
                          //         //     ),
                          //         //   ),
                          //         // ),
                          //         Container(
                          //           width: screenWidth * 0.71,
                          //           child: TextField(
                          //             controller: searchText,
                          //             onChanged: (text) {
                          //               // Ensure the input is at least 3 characters long before filtering
                          //               if (text.length >= 3) {
                          //                 setState(() {
                          //                   searchList =
                          //                       categoryList.where((element) {
                          //                     var groupList1 =
                          //                         element['category_name']
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
                          //               filled: true,
                          //               border: InputBorder.none,
                          //               fillColor: Colors.white,
                          //               hintText:
                          //                   'Search Category List Here...',
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
                          //         // Container(
                          //         //     width: screenWidth * 0.18,
                          //         //     height: screenHeight,
                          //         //     child: Icon(Icons.search,
                          //         //         color: custom_color.appcolor)),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: screenHeight * 0.01),
                          Helper().isvalidElement(categoryList1) &&
                                  categoryList1.length > 0
                              ? Container(
                                  // color: Colors.amber,
                                  height: screenHeight * 0.80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: categoryList1.length,
                                      // itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var data = categoryList1[index];
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Container(
                                              color: index % 2 == 0
                                                  ? custom_color.lightcolor
                                                  : Colors.white,
                                              width: screenWidth,
                                              height: screenHeight * 0.07,
                                              // width: screenWidth * 0.90,
                                              // decoration:
                                              //     BoxDecoration(border: Border.all(color: Colors.grey)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: screenWidth * 0.75,
                                                      // color: Colors.red,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            child: Row(
                                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      screenHeight *
                                                                          0.06,
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      screenWidth *
                                                                          0.02,
                                                                ),
                                                                Container(
                                                                  // color: Colors.purple,
                                                                  width:
                                                                      screenWidth *
                                                                          0.60,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        'Category Name : ${data['category_name'].toString()}',
                                                                        //  'Name : ${data['customer_name'].toString()}',
                                                                        // 'Dr Name : ${data['doc_name'] == null ? data['username'] : data['doc_name']}',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                //   Container(
                                                                //     width: screenWidth * 0.38,
                                                                //    child: Row(
                                                                //      children: [

                                                                //        Text(
                                                                //          // '',
                                                                //          'Mobile No : ${data['phone'].toString()}',
                                                                //          style: TextStyle(
                                                                //              fontWeight:
                                                                //                  FontWeight.bold),
                                                                //        ),
                                                                //      ],
                                                                //    ),
                                                                //  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        PopupMenuButton(
                                                            itemBuilder:
                                                                (context) => [
                                                                      PopupMenuItem(
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.view_agenda,
                                                                              color: custom_color.appcolor,
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 10),
                                                                              child: Text(
                                                                                'View',
                                                                                style: TextStyle(fontSize: 16),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => viewcategory(select_category: data)));
                                                                        },
                                                                      ),
                                                                      PopupMenuItem(
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.edit,
                                                                              color: custom_color.appcolor,
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 10),
                                                                              child: Text(
                                                                                'Edit',
                                                                                style: TextStyle(fontSize: 16),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          var item =
                                                                              {
                                                                            editcategorynamecontroller.text =
                                                                                data['category_name']
                                                                          };
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: ((context) => AlertDialog(
                                                                                    actions: [
                                                                                      Padding(padding: EdgeInsets.all(10)),
                                                                                      Container(
                                                                                        height: screenHeight * 0.04,
                                                                                        width: screenWidth * 0.14,
                                                                                      ),

                                                                                      //  SizedBox(height: screenHeight*0.00,),

                                                                                      Center(child: Text('Edit Category')),
                                                                                      SizedBox(
                                                                                        height: screenHeight * 0.02,
                                                                                      ),
                                                                                      TextFormField(
                                                                                        controller: editcategorynamecontroller,
                                                                                        focusNode: editcategoryFocusNode,
                                                                                        decoration: InputDecoration(
                                                                                          border: OutlineInputBorder(),
                                                                                          labelText: 'Name ',
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: screenHeight * 0.04,
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Container(
                                                                                            width: screenWidth * 0.30,
                                                                                            child: ElevatedButton(
                                                                                              style: ButtonStyle(
                                                                                                  backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                                                                                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                                                    RoundedRectangleBorder(
                                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                                    ),
                                                                                                  )),
                                                                                              child: Text(
                                                                                                'Save',
                                                                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                                                                              ),
                                                                                              onPressed: (() async {
                                                                                                if (editcategorynamecontroller.text.isEmpty) {
                                                                                                  editcategoryFocusNode.requestFocus();
                                                                                                  NigDocToast().showErrorToast('Enter Category Name');
                                                                                                } else {
                                                                                                  var items = {
                                                                                                    'id': data['id'].toString(),
                                                                                                    "category_name": editcategorynamecontroller.text.toString(),
                                                                                                  };
                                                                                                  var list = await PatientApi().editCategory(accesstoken, items);
                                                                                                  if (list['message'] == "updated successfully") {
                                                                                                    NigDocToast().showSuccessToast('updated successfully');
                                                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => categorylist()));
                                                                                                  } else {
                                                                                                    NigDocToast().showErrorToast('Please TryAgain later');
                                                                                                  }
                                                                                                }
                                                                                              }),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(width: screenWidth * 0.07),
                                                                                          Container(
                                                                                            width: screenWidth * 0.30,
                                                                                            child: ElevatedButton(
                                                                                              style: ButtonStyle(
                                                                                                  backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                                                                                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                                                    RoundedRectangleBorder(
                                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                                    ),
                                                                                                  )),
                                                                                              child: Text(
                                                                                                'Cancel',
                                                                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                                                                              ),
                                                                                              onPressed: (() async {
                                                                                                Navigator.pop(context);
                                                                                              }),
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      // SizedBox(height: screenHeight*0.04,),
                                                                                    ],
                                                                                  )));
                                                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>PrescriptionDetails(select_prescription : data)));
                                                                        },
                                                                      ),
                                                                      PopupMenuItem(
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.delete,
                                                                              color: custom_color.appcolor,
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 10),
                                                                              child: Text(
                                                                                'Delete',
                                                                                style: TextStyle(fontSize: 16),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          //       var item1 = {
                                                                          //   editcategorynamecontroller.text = data['category_name']
                                                                          // };
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) => AlertDialog(actions: [
                                                                                    SizedBox(
                                                                                      height: screenHeight * 0.02,
                                                                                    ),
                                                                                    Center(
                                                                                        child: Container(
                                                                                            child: Text(
                                                                                      'DELETE CATEGORY ',
                                                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                                                    ))),
                                                                                    SizedBox(
                                                                                      height: screenHeight * 0.02,
                                                                                    ),
                                                                                    Container(
                                                                                      child: Text(
                                                                                        'Are you sure you want to delete the Category  Details?',
                                                                                        style: TextStyle(fontSize: 16),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: screenHeight * 0.02,
                                                                                    ),
                                                                                    Container(
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                        children: [
                                                                                          Container(
                                                                                            child: ElevatedButton(
                                                                                                style: ButtonStyle(
                                                                                                    backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                                                                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                                                      RoundedRectangleBorder(
                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                      ),
                                                                                                    )),
                                                                                                onPressed: () {
                                                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => categorylist()));
                                                                                                },
                                                                                                child: Text(
                                                                                                  'Cancel',
                                                                                                  style: TextStyle(fontSize: 20, color: Colors.white),
                                                                                                )),
                                                                                          ),
                                                                                          Container(
                                                                                            child: ElevatedButton(
                                                                                                style: ButtonStyle(
                                                                                                    backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                                                                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                                                      RoundedRectangleBorder(
                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                      ),
                                                                                                    )),
                                                                                                onPressed: () async {
                                                                                                  var value = {
                                                                                                    "id": data['id'].toString(),
                                                                                                    'is_delete': delete,
                                                                                                  };
                                                                                                  var list = await PatientApi().deleteCategory(accesstoken, value);
                                                                                                  if (list['message'] == "Deleted successfully") {
                                                                                                    NigDocToast().showSuccessToast('Deleted successfully');
                                                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => categorylist()));
                                                                                                  } else {
                                                                                                    NigDocToast().showErrorToast('Please TryAgain later');
                                                                                                  }
                                                                                                },
                                                                                                child: Text(
                                                                                                  'Confirm',
                                                                                                  style: TextStyle(fontSize: 20, color: Colors.white),
                                                                                                )),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    )
                                                                                  ]));
                                                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>Prescription_List()));
                                                                        },
                                                                      )
                                                                    ]),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  // )
                                )
                              : Container(
                                  child: Center(child: Text('no data')),
                                )
                        ],
                      ),
                    ),
                  ),
                ))
              : Container(
                  child: SpinLoader(),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: (() {
              showDialog(
                  context: context,
                  builder: ((context) => AlertDialog(
                        actions: [
                          Padding(padding: EdgeInsets.all(10)),
                          Container(
                            height: screenHeight * 0.04,
                            width: screenWidth * 0.14,
                          ),
                          SizedBox(
                            height: screenHeight * 0.00,
                          ),
                          Center(child: Text('Add Category')),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          TextFormField(
                            controller: categorynamecontroller,
                            focusNode: categoryFocusNode,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Category Name',
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                          Row(
                            children: [
                              Container(
                                width: screenWidth * 0.30,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              custom_color.appcolor),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      )),
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: (() async {
                                    if (categorynamecontroller.text.isEmpty) {
                                      categoryFocusNode.requestFocus();
                                      NigDocToast().showErrorToast(
                                          'Enter Category Name');
                                    } else {
                                      var data = {
                                        "category_name": categorynamecontroller
                                            .text
                                            .toString(),
                                      };
                                      var list = await PatientApi()
                                          .Adddcategory(accesstoken, data);
                                      if (list['message'] ==
                                          "Category Add successfully") {
                                        NigDocToast().showSuccessToast(
                                            'Category Add successfully');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    categorylist()));
                                      } else {
                                        NigDocToast().showErrorToast(
                                            'Please TryAgain later');
                                      }
                                    }
                                  }),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.07),
                              Container(
                                width: screenWidth * 0.30,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              custom_color.appcolor),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      )),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: (() async {
                                    Navigator.pop(context);
                                  }),
                                ),
                              )
                            ],
                          ),
                          // SizedBox(height: screenHeight*0.04,),
                        ],
                      )));
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Addsummary()));
            }),
            child: Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
            backgroundColor: custom_color.appcolor,
          ),
        ));
  }

  getcategorylist() async {
    var List = await PatientApi().getCategory(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        isLoading = true;
        categoryList = List['list'];
         filterItems(searchText.text);
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }
  void filterItems(String text) {
   
    if (text.isEmpty) {
      setState(() {
        categoryList1 = categoryList;
      });
    } else if (text.length >= 3) {
      setState(() {
        categoryList1 = categoryList
            .where(
              (item) => item['category_name']
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
