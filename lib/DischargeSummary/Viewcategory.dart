import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/DischargeSummary/Category.dart';
import 'package:nigdoc/DischargeSummary/Group.dart';
import 'package:nigdoc/DischargeSummary/viewGroup.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class viewcategory extends StatefulWidget {
  final select_category;
  const viewcategory({super.key, request, this.select_category});

  @override
  State<viewcategory> createState() => _viewcategoryState();
}

class _viewcategoryState extends State<viewcategory> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController ratecontroller = TextEditingController();
  TextEditingController editnamecontroller = TextEditingController();
  TextEditingController editratecontroller = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode rateFocusNode = FocusNode();
  var select_Category;
  List CategoryListItem = [];
  List Subcategory_List = [];
  var CategoryList;
  var select_subCategory;
  var accesstoken;
  bool isLoading = false;
  var data1;
  var delete = 'yes';
  @override
  void initState() {
    super.initState();
    accesstoken = storage.getItem('userResponse')['access_token'];
    // selectedPatient = storage.getItem('selectedcustomer');

    // getpatientlist();
    // getgrouplist();
    getCategorylist();

    data1 = widget.select_category;
    print(data1);
    getSubcategorylist();
  }

  void dispose() {
    nameFocusNode.dispose();
    rateFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => categorylist()));
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Sub Category',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: custom_color.appcolor,
            leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => categorylist()));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Container(
                height: screenHeight,
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        controller: namecontroller,
                        focusNode: nameFocusNode,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Name *'),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      child: TextFormField(
                        controller: ratecontroller,
                        focusNode: rateFocusNode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Rate *'),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                custom_color.appcolor),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        onPressed: () async {
                          if (namecontroller.text.isEmpty) {
                            nameFocusNode.requestFocus();
                            NigDocToast().showErrorToast('Enter Category Name');
                          } else if (ratecontroller.text.isEmpty) {
                            rateFocusNode.requestFocus();
                            NigDocToast().showErrorToast('Enter your Rate');
                          } else {
                            var items = {
                              'category_id': data1['id'].toString(),
                              "subcategory_name":
                                  namecontroller.text.toString(),
                              "rate": ratecontroller.text.toString(),
                            };
                            var list = await PatientApi()
                                .addSubcategory(accesstoken, items);
                            if (list['message'] ==
                                "Subcategory Add successfully") {
                              NigDocToast().showSuccessToast(
                                  'Subcategory Add successfully');

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => categorylist()));
                              namecontroller.clear();
                              ratecontroller.clear();
                              getSubcategorylist();
                            } else {
                              NigDocToast()
                                  .showErrorToast('Please TryAgain later');
                            }
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),

                    //  listview(items),
                    Helper().isvalidElement(Subcategory_List) &&
                            Subcategory_List.length > 0
                        ? Container(
                            // color: Colors.amber,
                            height: screenHeight * 0.60,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: Subcategory_List.length,
                                // itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  var data = Subcategory_List[index];
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
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: screenWidth * 0.75,
                                                // color: Colors.red,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: Row(
                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                                screenHeight *
                                                                    0.06,
                                                          ),
                                                          SizedBox(
                                                            width: screenWidth *
                                                                0.02,
                                                          ),
                                                          Container(
                                                            // color: Colors.purple,
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'Name : ${data['subcategory_name'].toString()}',
                                                                  //  'Name : ',
                                                                  // 'Dr Name : ${data['doc_name'] == null ? data['username'] : data['doc_name']}',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            // color: Colors.deepOrange,
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  // '',
                                                                  'Rate : ${data['rate'].toString()}',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
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
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .edit,
                                                                        color: custom_color
                                                                            .appcolor,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 10),
                                                                        child:
                                                                            Text(
                                                                          'Edit',
                                                                          style:
                                                                              TextStyle(fontSize: 16),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  onTap:
                                                                      () async {
                                                                    var item1 =
                                                                        {
                                                                      editnamecontroller
                                                                              .text =
                                                                          data[
                                                                              'subcategory_name'],
                                                                      editratecontroller
                                                                              .text =
                                                                          data[
                                                                              'rate']
                                                                    };
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder: (context) =>
                                                                            AlertDialog(actions: [
                                                                              SizedBox(
                                                                                height: screenHeight * 0.03,
                                                                              ),
                                                                              Container(
                                                                                child: TextFormField(
                                                                                  controller: editnamecontroller,
                                                                                  decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Name *'),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: screenHeight * 0.02,
                                                                              ),
                                                                              Container(
                                                                                child: TextFormField(
                                                                                  controller: editratecontroller,
                                                                                  keyboardType: TextInputType.number,
                                                                                  decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Rate *'),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: screenHeight * 0.02,
                                                                              ),
                                                                              Container(
                                                                                child: Center(
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
                                                                                          'subcategory_name': editnamecontroller.text.toString(),
                                                                                          'rate': editratecontroller.text.toString(),
                                                                                        };
                                                                                        var list = await PatientApi().editSubcategory(accesstoken, value);
                                                                                        if (list['message'] == "Updated successfully") {
                                                                                          NigDocToast().showSuccessToast('Updated successfully');
                                                                                          // getSubcategorylist();
                                                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => categorylist()));
                                                                                          // getSubcategorylist();
                                                                                        } else {
                                                                                          NigDocToast().showErrorToast('Please TryAgain later');
                                                                                        }
                                                                                      },
                                                                                      child: Text(
                                                                                        'Update',
                                                                                        style: TextStyle(fontSize: 20, color: Colors.white),
                                                                                      )),
                                                                                ),
                                                                              )
                                                                            ]));

                                                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>Prescription_List()));
                                                                  },
                                                                ),
                                                                PopupMenuItem(
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: custom_color
                                                                            .appcolor,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 10),
                                                                        child:
                                                                            Text(
                                                                          'Delete',
                                                                          style:
                                                                              TextStyle(fontSize: 16),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  onTap:
                                                                      () async {
                                                                    var value =
                                                                        {
                                                                      "id": data[
                                                                              'id']
                                                                          .toString(),
                                                                      'is_delete':
                                                                          delete,
                                                                    };
                                                                    var list = await PatientApi()
                                                                        .deleteSubcategory(
                                                                            accesstoken,
                                                                            value);
                                                                    if (list[
                                                                            'message'] ==
                                                                        "Deleted successfully") {
                                                                      NigDocToast()
                                                                          .showSuccessToast(
                                                                              'Deleted successfully');
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => categorylist()));
                                                                      //  getSubcategorylist();
                                                                    } else {
                                                                      NigDocToast()
                                                                          .showErrorToast(
                                                                              'Please TryAgain later');
                                                                    }
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
                            child: Text('no data'),
                          )
                  ],
                ),
              ),
            ),
          )),
        ));
  }

  getCategorylist() async {
    CategoryList = await PatientApi().getCategory(accesstoken);
    if (Helper().isvalidElement(CategoryList) &&
        Helper().isvalidElement(CategoryList['status']) &&
        CategoryList['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      CategoryListItem = CategoryList['list'];
      this.setState(() {
        isLoading = false;
      });
    }
  }

  getSubcategorylist() async {
    var data = {'id': data1['id'].toString()};
    var SubcategoryList =
        await PatientApi().getSubcategory(data, accesstoken, context);
    if (Helper().isvalidElement(SubcategoryList) &&
        Helper().isvalidElement(SubcategoryList['list'])) {
      Subcategory_List = SubcategoryList['list'];
      setState(() {
        isLoading = true;
      });
    } else {}
  }
}
