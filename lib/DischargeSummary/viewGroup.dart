import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/DischargeSummary/Group.dart';
import '../../AppWidget/common/Colors.dart'as custom_color;

class viewgroup extends StatefulWidget {
 final select_group;
  const viewgroup({super.key, required,this.select_group});

  @override
  State<viewgroup> createState() => _viewgroupState();
}

class _viewgroupState extends State<viewgroup> {
  TextEditingController subcategorycontroller = TextEditingController();
  var select_Category;
    List CategoryListItem = [];
     List Subcategory_List = [];
     List Subcategory_List1 = [];
     var CategoryList;
     var select_subCategory;
     var accesstoken;
     bool isLoading = false;
     var data1;
    List categoryList = [];
    List groupwise = [];
    var delete = 'yes';
    List item = [];
    var selectedTest;
     bool Test =true;
     var Testlist;
      @override
  void initState() {
    super.initState();
    accesstoken = storage.getItem('userResponse')['access_token'];
    // selectedPatient = storage.getItem('selectedcustomer');
   

    // getpatientlist();
    // getgrouplist();
    getCategorylist();
     data1 = widget.select_group;
    print(data1);
    getGroupwisecategory();

   
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>grouplist()));
      },
      child:Scaffold(
        appBar: AppBar(
          title: Text('Group Name',style: TextStyle(color: Colors.white),),
          backgroundColor:custom_color.appcolor,
          leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>grouplist()));
          }, icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                            // width: ScreenWidth * 0.69,
                            child: CategoryListItem.length > 0
                                ? DropdownButtonFormField(
                                    //decoration: InputDecoration.collapsed(hintText: ''),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Category'),
                                    isExpanded: true,
                                    onChanged: (selected) async {
                                      select_Category = selected;
                                      await getSubcategorylist();
                                      setState(() {});
                                    },
                                    items: CategoryListItem.map<DropdownMenuItem>(
                                        (item) {
                                      return new DropdownMenuItem(
                                        child: new Text(
                                          '${item['category_name']}',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        value: item,
                                      );
                                    }).toList(),
                                  )
                                : DropdownButtonFormField(
                                    //decoration: InputDecoration.collapsed(hintText: ''),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Category'),
                                    isExpanded: true,
                                    onChanged: (selected) {
                                      select_Category = selected;
                                      setState(() {});
                                    },
                                    items: [].map<DropdownMenuItem<String>>((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(
                                          '${item['category_name']}',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        value: item.toString(),
                                      );
                                    }).toList(),
                                  ),
                          ),
                      SizedBox(height: screenHeight*0.02,),
                       Container(
            child: Helper().isvalidElement(selectedTest)
                ? RenderPatientdata(screenHeight, screenWidth)
                : renderPatientAutoComplete(screenHeight, screenWidth)
                // : renderTesttListWidget(screenHeight, screenWidth)
          ),
          SizedBox(height: screenHeight*0.02),
          Subcategory_List1.length>0?renderTesttListWidget(screenHeight, screenWidth):Container(),
          SizedBox(
            height: 25,
          ),
                        // Container(
                        //     // width: ScreenWidth * 0.69,
                        //     child: Subcategory_List.length > 0
                        //         ? DropdownButtonFormField(
                        //             //decoration: InputDecoration.collapsed(hintText: ''),
                        //             decoration: InputDecoration(
                        //                 border: OutlineInputBorder(),
                        //                 labelText: 'Sub Category'),
                        //             isExpanded: true,
                        //             value: Subcategory_List.isNotEmpty ? Subcategory_List.first : null,
                        //             onChanged: (selected) {
                        //               select_subCategory = selected;
                                      
                        //               setState(() {});
                        //             },
                        //             items: Subcategory_List.map((item) {
                        //               return new DropdownMenuItem(
                        //                 // child: new Text(
                        //                 //   item,
                        //                 //   style: TextStyle(fontSize: 15),
                        //                 // ),
                        //                 child: new Text(
                        //                   '${item['subcategory_name']}',
                        //                   style: TextStyle(fontSize: 15),
                        //                 ),
                        //                 value: item,
                        //               );
                        //             }).toList(),
                        //           )
                        //         : DropdownButtonFormField(
                        //             //decoration: InputDecoration.collapsed(hintText: ''),
                        //             decoration: InputDecoration(
                        //                 border: OutlineInputBorder(),
                        //                 labelText: 'Sub Category'),
                        //             isExpanded: true,
                        //             onChanged: (selected) {
                        //               select_Category = selected;
                                      
                        //               setState(() {});
                        //             },
                        //             items: [].map<DropdownMenuItem<String>>((item){
                        //               return new DropdownMenuItem(
                        //                 child: new Text(
                        //                   '${item['subcategory_name']}',
                        //                   style: TextStyle(fontSize: 15),
                        //                 ),
                        //                 value: item.toString(),
                        //               );
                        //             }).toList(),
                        //           ),
                        //   ),
                          
                       SizedBox(height: screenHeight*0.02,),
                     
                        
                       ElevatedButton(
                         style: ButtonStyle(
                                        backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                               
                                        RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                  
                                 
                                         ),
                               
                                         )
                             
                                         ),
                        onPressed: ()async{
              
                           var data ={
                                    'group_id':data1['id'].toString(),
                                    'category_id':select_Category['id'].toString(),
                                    'sub_category_id':Subcategory_List1,
                 
                                };
                              var list = await PatientApi()
                                      .viewgroup( accesstoken, data);
                                  if (list['message'] ==
                                      "updated successfully") {
                                    NigDocToast().showSuccessToast(
                                        'updated successfully');
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => Discharge_summery()));
                                    getGroupwisecategory();
                                    Subcategory_List1.clear();
                                    
                                  } else {
                                    NigDocToast()
                                        .showErrorToast('Please TryAgain later');
                                  }
              
                       }, child: Text('Save',style: TextStyle(fontSize: 18,color: Colors.white),)),
              
              
                      SizedBox(height: screenHeight*0.02,),
                      Helper().isvalidElement(groupwise) && groupwise.length > 0 ?  
                    Container(
                      // color: Colors.amber,
                        height: screenHeight*0.60,
                         child: Padding(
                           padding: const EdgeInsets.all(5.0),
                           child: ListView.builder(
                             shrinkWrap: true,
                             itemCount: groupwise.length,
                              // itemCount: 1,
                             itemBuilder: (BuildContext context, int index) {
                               var data=groupwise[index];
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
                                             width: screenWidth*0.75,
                                             // color: Colors.red,
                                             child: Column(
                                               children: [
                                               
                                                 Padding(
                                                   padding: const EdgeInsets.all(0.0),
                                                   child: Row(
                                                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     children: [
                                                     
                                                      SizedBox(height: screenHeight*0.06,),
                                                      SizedBox(width: screenWidth*0.02,),
                                                       Container(
                                                        // color: Colors.purple,
                                                         width: screenWidth * 0.50,
                                                         child: Row(
                                                           children: [
                                                             Text(
                                                              // 'Group Name : ${data['group_name'].toString()}',
                                                               'Category Name : ${data['category_name'].toString()}',
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
                                               PopupMenuButton(itemBuilder: (context)=>[
                                                
                                                        
                                                        PopupMenuItem(child: Row(
                                                         children: [
                                                           Icon(Icons.delete,color: custom_color.appcolor,),
                                                           Padding(padding: EdgeInsets.only(left: 10),
                                                           child: Text('Delete',style: TextStyle(fontSize: 16),),)
                                                         ],
                                               
                                                         
                                                       ),
                                                       onTap: () async{
                                                   var value= {
                                                   "group_id":data['group_id'].toString(),
                                                   "category_id":data['category_id'].toString(),
                                                   'is_delete':delete,
                                                 };
                                                 var list = await PatientApi()
                                          .deleteGroupwisecategory( accesstoken, value);
                                      if (list['message'] ==
                                          "Deleted successfully") {
                                        NigDocToast().showSuccessToast(
                                            'Deleted successfully');
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => viewgroup()));
                                        getGroupwisecategory();

                                      } else {
                                        NigDocToast()
                                            .showErrorToast('Please TryAgain later');
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
                       ):Container(child: Text('no data'),)
                  ],
                ),
              ),
            ),
          )),
      ) );
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
    var data = {'id': select_Category['id'].toString()};
    var SubcategoryList =
        await PatientApi().getSubcategory( data, accesstoken, context);
    if (Helper().isvalidElement(SubcategoryList) &&
        Helper().isvalidElement(SubcategoryList['list'])) {
      Subcategory_List = SubcategoryList['list'];
      setState(() {
        isLoading = true;
      });
    } else {}
  }
  getGroupwisecategory() async {
    var data = {'id': data1['id'].toString()};
    var List =
        await PatientApi().getGroupwisecategory( data, accesstoken, context);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['list'])) {
      groupwise = List['list'];
      setState(() {
        isLoading = true;
      });
    } else {}
  }
  renderTesttListWidget(screenHeight, screenWidth){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: custom_color.appcolor),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // color: Colors.green,
                 width: screenWidth*0.86,
                                      child: ListView.builder(
                                         shrinkWrap: true,
                                          itemCount: Subcategory_List1.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var data = Subcategory_List1[index];
                                              return Container(
                                                  child: Column(children: [
                                                ListTile(
                                                  title: Text("${data["subcategory_name"].toString()}"),
                                                 trailing: IconButton(onPressed: (){
              if(Subcategory_List1.contains(data)){
                 Subcategory_List1.remove(data);
                 setState(() {
                     print('exists');

                 });
                                print('exists');

                                }else{
                                  // Group_TestList.add(selectedTest);
                                  // setState(() {
                                  //   Test = false;
                                  //   selectedTest = null;
                                  // });
                                }

              
            }, icon: Icon(Icons.close,),color: Colors.red),
                        //                         title:  Text(
                        //   Helper().isvalidElement(data)
                        //       ? "${data["test_name"].toString()}"
                        //       : '',
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // ),
                                                )
                                                  ])
                                              );
                                              }
                                      )
                // child: Row(
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           Helper().isvalidElement(Group_TestList)
                //               ? "${Group_TestList[0]['test_name'].toString()}"
                //               : '',
                //           style: TextStyle(fontWeight: FontWeight.bold),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ),
              // Container(
              //   color: Colors.red,
              //    width: screenWidth*0.30,
              //     child: IconButton(
              //   onPressed: () {
              //     // storage.setItem('selectedPatient', null);
              //     // this.setState(() {
              //     //   // selectedPatient = null;
              //     //   // clearProduct();
              //     //   // ProductshowAutoComplete = true;
              //     // });
              //   },
              //   icon: Icon(
              //     Icons.close,
              //   ),
              //   color: CustomColors.error_color,
              // ))
            ],
          ),
        ),
      ),
    );
  }
  RenderPatientdata(screenHeight, screenWidth) {
    return Card(
        elevation: 20,
        child: Container(
          width: screenWidth * 0.95,
          child: ListTile(
            trailing: IconButton(onPressed: (){
              if(Subcategory_List1.contains(selectedTest)){
                                print('exists');
                                NigDocToast().showErrorToast('Already Added');
                                setState(() {
                                    selectedTest = null;
                                });
                               
                                }else{
                                  Subcategory_List1.add(selectedTest);
                                  setState(() {
                                    Test = false;
                                    selectedTest = null;
                                  });
                                }

              
            }, icon: Icon(Icons.send,color: custom_color.appcolor,)),
            
            title: Text('${selectedTest['subcategory_name'].toString().toUpperCase()}',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        )
        
        );
  }

  renderPatientAutoComplete(screenHeight, screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Autocomplete<List>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isNotEmpty) {
            var matches = [];
            setState(() {});
            matches.addAll(Subcategory_List);
            matches.retainWhere((s) {
              return s['subcategory_name']
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
            return [matches];
          } else {
            return const Iterable<List>.empty();
          }
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return Container(
            height: screenHeight * 0.07,
            width: screenWidth * 0.95,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: custom_color.appcolor,
                width: 2.0,
              ),
            ),
            child: Center(
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: '  SubCategory'),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onChanged: (text) {
                    subcategorycontroller.text = text;
                  },
                ),
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
          return options.toList()[0].isNotEmpty
              ? Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: Container(
                      width: screenWidth * 0.95,
                      // height: screenHeight * 0.78,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(5.0),
                          itemCount: options.toList()[0].length,
                          itemBuilder: (BuildContext context, int index) {
                            var option = options.toList()[0].elementAt(index);

                            return ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                      selectedTest= option;
                                  });
                              
                                // // select_test = option;
                                
                                },
                                
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            OutlinedBorder?>(
                                        ContinuousRectangleBorder()),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            custom_color.appcolor)),
                                child: Container(
                                  color: custom_color.appcolor,
                                 
                                  child: Row(
                                    
                                    children: [
                                      SizedBox(
                                        
                                        width: screenWidth * 0.5,
                                        child: Text(
                                            '${options.toList()[0][index]['subcategory_name'].toString().toUpperCase()} ',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                      )
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ),
                    ),
                  ),
                )
              : Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: screenWidth * 0.9,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder?>(
                                ContinuousRectangleBorder()),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                custom_color.appcolor)),
                        child: Container(
                          child: const Text(
                            'Search List Empty',
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                        )),
                  ),
                );
        },
      ),
    );
  }
}