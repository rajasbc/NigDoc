import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import 'package:nigdoc/DischargeSummary/summary.dart';
import '../../AppWidget/common/Colors.dart'as custom_color;

class Addsummary extends StatefulWidget {
  const Addsummary({super.key});

  @override
  State<Addsummary> createState() => _AddsummaryState();
}

class _AddsummaryState extends State<Addsummary> {
  TextEditingController  searchText = TextEditingController();
  TextEditingController groupnamecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController ratecontroller = TextEditingController();
  TextEditingController qtycontroller = TextEditingController();
  TextEditingController totalcontroller = TextEditingController();
  TextEditingController admissiondateController = TextEditingController();
  TextEditingController dischargedateController = TextEditingController();
  TextEditingController billdateController = TextEditingController();
  TextEditingController Finalamountcontroller = TextEditingController();
  TextEditingController summarycomtroller = TextEditingController();
  TextEditingController grandtotalcomtroller = TextEditingController();
  TextEditingController totalqtycomtroller = TextEditingController();
  bool isloading = false;
  var selected_item;
  var title={
       "Mr",
       "Mrs",
       "Miss",
       "Dr",

  };
   bool showAutoComplete = true;
    bool showAutoComplete1 = true;
    var ProductshowAutoComplete = true;
   var selectedPatient;
   var selectedgroup;
   var PatientList;
    var accesstoken;
    var groupList;
    List item = [];
    var select_Category;
    List CategoryListItem = [];
     List Subcategory_List = [];
     bool isLoading = false;
     var CategoryList;
     var select_subCategory;
      // data1=item[];
    @override
  void initState() {
    super.initState();
    accesstoken = storage.getItem('userResponse')['access_token'];
    selectedPatient = storage.getItem('selectedcustomer');
    admissiondateController.text = Helper().getCurrentDate();
    dischargedateController.text = Helper().getCurrentDate();
    billdateController.text = Helper().getCurrentDate();
   

    getpatientlist();
    getgrouplist();
    getCategorylist();
   
  }
  // final DateFormate = "dd-MM-yyyy";
  //  DateTime currentDate = DateTime.now();
  // Future<void> selectDate(BuildContext context, data) async {
  //   var checkfield = data;
  //   // print(data);
  //   final DateTime? pickedDate = await showDatePicker(
  //       context: context,
  //       builder: (context, child) {
  //         return Theme(
  //           data: Theme.of(context).copyWith(
  //             colorScheme: ColorScheme.light(
  //               primary: custom_color.appcolor,
  //               onPrimary: Colors.white, // <-- SEE HERE
  //               onSurface: custom_color.appcolor, // <-- SEE HERE
  //             ),
  //             textButtonTheme: TextButtonThemeData(
  //               style: TextButton.styleFrom(
  //                 foregroundColor: custom_color.appcolor, // button text color
  //               ),
  //             ),
  //           ),
  //           child: child!,
  //         );
  //       },
  //       initialDate: currentDate,
  //       firstDate: DateTime(DateTime.now().year-3, DateTime.now().month, DateTime.now().day),
  //       lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));

  //   if (pickedDate != null && pickedDate != currentDate)
  //     setState(() {
  //       currentDate = pickedDate;
  //     });
  //   if (checkfield == "from") {
  //     // var formatter = new DateFormat('dd-MM-yyyy');
  //     dischargedateController.text =
  //         DateFormat(DateFormate).format(pickedDate!);

  //     // fromdateInputController.text = pickedDate.toString().split(' ')[0];
  //     // getsummaryList();
  //     // get();
  //     // getdoctorlist();
  //   } else {
  //     dischargedateController.text = DateFormat(DateFormate).format(pickedDate!);
     
  //     // getsummaryList();
  //     // get();
  //     // getdoctorlist();
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Discharge_summery()));
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: custom_color.appcolor,
          title: Text('Add Summary',style: TextStyle(color: Colors.white),),
           leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Discharge_summery(),
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
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight*0.02,),
                    Container(
                      width: screenWidth,
                     
                       height: screenHeight * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: screenWidth * 0.42,
                             
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Admission Date',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                labelText: 'Admission Date',
                                suffixIcon: Icon(
                                  Icons.date_range,
                                  color: custom_color.appcolor,
                                ),
                              ),
                              controller: admissiondateController,
                              readOnly: true,
                              onTap: () async {
                                // selectDate(context, 'Admission Date');
                                selectAdmissionDate();
                              },
                            ),
                          ),
                          SizedBox(width: screenWidth*0.06,),
                          Container(
                            width: screenWidth * 0.42,
                            
                            child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Discharge Date',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  labelText: 'Discharge Date',
                                  suffixIcon: Icon(
                                    Icons.date_range,
                                    color: custom_color.appcolor,
                                  ),
                                ),
                                controller: dischargedateController,
                                readOnly: true,
                                onTap: () async {
                                  selectDischargeDate();
                                  // selectDate(context, 'Discharge Date');
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight*0.02,),
                    showAutoComplete
                   ? Container(
                     child: Center(
                        child: renderAutoComplete(
                         screenWidth, screenHeight),
                      ),
                   )
                    : Container(
                        child: Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                Icon(Icons.people,
                                    color: custom_color.appcolor),
                                Text(
                                  '     ${selectedPatient['customer_name'].toString()}',
                                ),
                              ],
                            ),
                            // subtitle: Text(
                            //     '             ${selectedPatient['phone'].toString()}'),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedPatient = null;
                                  showAutoComplete = true;
                                });
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        // ListTile(title: Text('Test name'),
                        // trailing: IconButton(onPressed: (){} ,icon: Icon(Icons.add)),),
                      ],
                    )),
                  // Center(child: 
                  // Container(
                  //   // height: screenHeight * 0.06,
                  //    height: screenHeight * 0.07,
                  //   // width: screenWidth*0.9,
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       border:
                  //           Border.all(color:custom_color.appcolor),
                  //       borderRadius: BorderRadius.all(Radius.circular(5))),
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //           width: screenWidth * 0.1,
                  //           height: screenHeight,
                  //           child: Icon(Icons.search,
                  //               color: custom_color.appcolor)),
                  //       Container(
                  //         width: screenWidth * 0.65,
                  //         child: TextField(
                  //           controller: searchText,
                  //           onChanged: (text) {
                  //             print(text);
              
                  //             this.setState(() {});
                  //             // var list = ProductListItem;
                  //               // searchList = Injection_List.where((element) {
                  //               //   var treatList = element['injections_name'].toString().toLowerCase();
                  //               //   return treatList.contains(text.toLowerCase());
                  //               //   // return true;
                  //               // }).toList();
                  //               this.setState(() {});
                  //           },
                  //           decoration: new InputDecoration(
                  //             filled: true,
                  //             border: InputBorder.none,
                  //             fillColor: Colors.white,
                  //             hintText: 'Search Patient List Here...',
                  //           ),
                  //         ),
                  //       ),
                  //       searchText.text.isNotEmpty
                  //           ? Container(
                  //               width: screenWidth * 0.1,
                  //               height: screenHeight,
                  //               child: IconButton(
                  //                 icon: Icon(
                  //                   Icons.close,
                  //                   color: Colors.red,
                  //                 ),
                  //                 onPressed: () {
                  //                   setState(() {
                  //                     searchText.text = '';
                  //                     // searchList='';
                  //                   });
                  //                 },
                  //               ))
                  //           : Container(),
                  //     ],
                  //   ),
                  // ),),
                  SizedBox(height: screenHeight*0.02,),
                  Container(
                            // width: screenWidth * 0.42,
                            width: screenWidth ,
                            
                            child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Bill Date',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  labelText: 'Bill Date',
                                  suffixIcon: Icon(
                                    Icons.date_range,
                                    color: custom_color.appcolor,
                                  ),
                                ),
                                controller: billdateController,
                                readOnly: true,
                                onTap: () async {
                                  selectBillDate();
                                  // selectDate(context, 'Discharge Date');
                                }),
                          ),
                  SizedBox(height: screenHeight*0.02,),
                  showAutoComplete1
                   ? Container(
                     child: Center(
                        child: renderAutoComplete1(
                         screenWidth, screenHeight),
                      ),
                   )
                    : Container(
                        child: Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                // Icon(Icons.people,
                                //     color: custom_color.appcolor),
                                Text(
                                  // '     ${selectedgroup['group_name'].toString()}',
                                   '     ${ Helper().isvalidElement(selectedgroup) && Helper().isvalidElement(selectedgroup) ? selectedgroup['group_name'] == null ? '' : selectedgroup['group_name'].toString() :''}',
                                ),
                              ],
                            ),
                            // subtitle: Text(
                            //     '             ${selectedPatient['phone'].toString()}'),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedgroup = null;
                                  showAutoComplete1 = true;
                                });
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        // ListTile(title: Text('Test name'),
                        // trailing: IconButton(onPressed: (){} ,icon: Icon(Icons.add)),),
                      ],
                    )),
                  // TextFormField(
                  //   controller: groupnamecontroller,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: 'Group Name',
                  //   ),
                  // ),
                    
                    SizedBox(height: screenHeight*0.02,),
                  //  Container(
                  //    height: screenHeight * 0.07,
                  //    decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                  //    borderRadius: BorderRadius.circular(5.0)
                  //       //  border: OutlineInputBorder()
                  //        ),
                  //    child: Padding(
                  //      padding: const EdgeInsets.all(10.0),
                  //      child: Center(
                  //        child: DropdownButtonFormField(
                         
                  //          decoration: InputDecoration.collapsed(hintText: ''),
                  //          isExpanded: true,
                  //          hint: Text(
                  //            'Category',
                            
                  //          ),
                          
                  //          onChanged: (selectedDoctor) {
                  //            selected_item=selectedDoctor;
                  //            setState(() {
                              
                  //            });
                  //             selected_item=selectedDoctor.toString();
                  //          setState(() {
                             
                  //          });
                  //          },
                  //          items: title.map<DropdownMenuItem<String>>((item) {
                  //            return new DropdownMenuItem(
                  //              child: Padding(
                  //                padding: const EdgeInsets.only(top: 7, left: 8, right: 8),
                  //                child: new Text(item,style: TextStyle(fontSize: 15),),
                  //              ),
                  //              value: item.toString(),
                  //            );
                  //          }).toList(),
                  //        ),
                  //      ),
                  //    ),
                  //  ),
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
                        // width: ScreenWidth * 0.69,
                        child: Subcategory_List.length > 0
                            ? DropdownButtonFormField(
                                //decoration: InputDecoration.collapsed(hintText: ''),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Sub Category'),
                                isExpanded: true,

                                onChanged: (selected) {
                                  select_subCategory = selected;
                                  setState(() {});
                                },
                                items: Subcategory_List.map((item) {
                                  return new DropdownMenuItem(
                                    // child: new Text(
                                    //   item,
                                    //   style: TextStyle(fontSize: 15),
                                    // ),
                                    child: new Text(
                                      '${item['subcategory_name']}',
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
                                    labelText: 'Sub Category'),
                                isExpanded: true,
                                onChanged: (selected) {
                                  select_Category = selected;
                                  setState(() {});
                                },
                                items: [].map<DropdownMenuItem<String>>((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(
                                      '${item['subcategory_name']}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    value: item.toString(),
                                  );
                                }).toList(),
                              ),
                      ),
                   SizedBox(height: screenHeight*0.02,),
                   TextFormField(
                    controller: descriptioncontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description *',
                    ),
                  ),
                  SizedBox(height: screenHeight*0.02,),
                   TextFormField(
                    controller: ratecontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Rate *',
                      
                    ),
                    onChanged: (value) {
                            calculation();
                          },
                  ),
                   SizedBox(height: screenHeight*0.02,),
                  TextFormField(
                    controller: qtycontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Quantity *',
                    ),
                     onChanged: (value) {
                          calculation();
                          },
                  
                  ),
                    SizedBox(height: screenHeight*0.02,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: totalcontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Total *',
                    ),
                  ),
                  SizedBox(height: screenHeight*0.02,),
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     /// drugprioritycontroller.text != ''
                      Container(
                        
                       width: screenWidth*0.40,
                       child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ElevatedButton(
                        style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                           
                                    RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                              
                             
                                     ),
                           
                                     )
                         
                                     ),
                        child: Text("Add",style: TextStyle(fontSize: 18,color: Colors.white),),
                                 
                        onPressed: (() async {
                         Add();
                         
                        }),
                                                        
                        ),
                       ),
                       ),
                     
                    ],
                  ),
                    item.length > 0
                      ? Container(
                          // width: Helper().Windows() == 'Windows'
                              // ? screenWidth * 0.40
                              // : screenWidth,
                          width: screenWidth,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: custom_color.appcolor)),
                          child: ListView.builder(
                              shrinkWrap: true,
                              // physics: PageScrollPhysics(),
                              itemCount: item.length,
                              itemBuilder: (BuildContext context, int index) {
                                var data = item[index];
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      //decoration:
                                      // Helper().ContainerShowdow(0, 'no'),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(

                                                      children: [
                                                        Container(
                                                          // color: Colors.amber,
                                                          width: screenWidth*0.35,
                                                          child: Text('Group : ${data['group_name']}')),
                                                        
                                                        Container(
                                                          // color: Colors.purple,
                                                          width: screenWidth*0.35,
                                                          child: Text('Category : ${data['category_name']}')),
                                                        // Text('Sub Category :${data['category_name']}'),
                                                      ],
                                                    ),
                                                    SizedBox(height: screenHeight*0.02,),
                                                     Row(

                                                      children: [
                                                        Container(
                                                          // color: Colors.amber,
                                                          width: screenWidth*0.35,
                                                          child: Text('Sub Category : ${data['sub_category_name']}')),
                                                        
                                                        Container(
                                                          // color: Colors.purple,
                                                          width: screenWidth*0.35,
                                                          child: Text('Description : ${data['description']}')),
                                                        // Text('Sub Category :${data['category_name']}'),
                                                      ],
                                                    ),
                                                     SizedBox(height: screenHeight*0.02,),
                                                     Row(

                                                      children: [
                                                        Container(
                                                          // color: Colors.amber,
                                                          width: screenWidth*0.35,
                                                          child: Text('Rate : ${data['rate']}')),
                                                        
                                                        Container(
                                                          // color: Colors.purple,
                                                          width: screenWidth*0.35,
                                                          child: Text('Quantity : ${data['qty']}')),
                                                        // Text('Sub Category :${data['category_name']}'),
                                                      ],
                                                    ),
                                                     SizedBox(height: screenHeight*0.02,),
                                                     Row(

                                                      children: [
                                                        Container(
                                                          // color: Colors.amber,
                                                          width: screenWidth*0.70,
                                                          child: Text('Total : ${data['total'].toString()}')),
                                                        
                                                        // Container(
                                                        //   // color: Colors.purple,
                                                        //   width: screenWidth*0.35,
                                                        //   child: Text('Action : ${data['category_name']}')),
                                                        // Text('Sub Category :${data['category_name']}'),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                // Flexible(
                                                //   child: Text('Group :${data['category_name']}'),
                                                // ),
                                                //  Flexible(
                                                //   child: Text('Category :${data['category_name']}'),
                                                // ),
                                                // Column(
                                                //   children: [
                                                //     Flexible(
                                                //   child: Text('Sub Category :${data['category_name']}'),
                                                // ),
                                                //   ],
                                                // ),
                                                // Flexible(
                                                //   child: Text('Sub Category :${data['category_name']}'),
                                                // ),
                                                Container(
                                                  height: screenHeight * 0.05,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      this.setState(() {
                                                        item.removeAt(index);
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            
                                            
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : Container(
                          child: Text(""),
                        ),
                        SizedBox(height: screenHeight*0.02,),
                        SizedBox(width: screenWidth*0.03,),
                        Container(
                         
                          child: Row(
                            children: [
                              Container(
                                width: screenWidth*0.47,
                                
                                child: Text('Grand Total ₹ : ${grandtotalcomtroller.text}'),
                              ),
                            
                              Container(
                                 width: screenWidth*0.47,
                                child: TextField(
                                  controller: Finalamountcontroller,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Final AMount'
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight*0.02,),

                        Container(
                          child:TextFormField(
                            maxLines: 3,
                            controller: summarycomtroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Summary Reaview :'
                            ),
                          ) ,
                        ),
                        SizedBox(height: screenHeight*0.02,),
                    Container(
                      width: screenWidth,
                      child: ElevatedButton(
                        style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                             
                                      RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                
                               
                                       ),
                             
                                       )
                           
                                       ),
                        onPressed: () async {
                         
                          //  Savedata();
                          if(item.isEmpty){
                            NigDocToast().showErrorToast('Add Patient Summarys');

                          }
                          // else if( == null){
                          //   NigDocToast().showErrorToast('Select Gorup');

                          // }
                         
                            var data={
                                  'patient_id':selectedPatient['cid'].toString(),
                                  'admission_date':admissiondateController.text.toString(),
                                  'discharge_date':dischargedateController.text.toString(),
                                  'bill_date':billdateController.text.toString(),   
                                  'total_qty':totalqtycomtroller.text.toString(),
                                  'grand_total':grandtotalcomtroller.text.toString(),
                                  'balance':grandtotalcomtroller.text.toString(),
                                  'check_in_status':'OUT',
                                  'final_amount':Finalamountcontroller.text.toString(),
                                  'summary_review':summarycomtroller.text.toString(),
                                  'items':item,

                              };
                            var list = await PatientApi()
                                    .addSummary( accesstoken, data);
                                if (list['message'] ==
                                    "Successfully") {
                                  NigDocToast().showSuccessToast(
                                      'Summary Add successfully');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Discharge_summery()));
                                } else {
                                  NigDocToast()
                                      .showErrorToast('Please TryAgain later');
                                }

                      },  child: Text("Save",style: TextStyle(fontSize: 18,color: Colors.white),),
                      ),
                    ),
                    SizedBox(height: screenHeight*0.04,),
                  ],
                ),
              ),
            ),
          )),
      ));
  }
  calculation(){
     var rate = ratecontroller.text.toString();
     var qty = qtycontroller.text.toString();
     if(rate.isNotEmpty){
      var totalamount = double.parse(rate)* double.parse(qty);
      totalcontroller.text= totalamount.toStringAsFixed(2);
     }
  }
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  Future<void>selectAdmissionDate() async {
      DateTime? _picked =  await showDatePicker(
        
        context: context,
        
      initialDate: fromDate,
      firstDate: DateTime(1980), 
      lastDate: DateTime.now(),
      );
      if(_picked != null){
       setState(() {
         fromDate = _picked;
         admissiondateController.text=Helper().formateDate(_picked);// _picked.toString().split(" ")[0];
       });
      
      }
    }
    Future<void>selectDischargeDate() async {
      DateTime? _picked =  await showDatePicker(
        context: context,
      initialDate: toDate,
      firstDate: DateTime(1980), 
      lastDate: DateTime.now(),
      );
      if(_picked != null){
       setState(() {
        toDate=_picked;
         dischargedateController.text= Helper().formateDate(_picked);// _picked.toString().split(" ")[0];
       });
      //  await getpendingbilllist();
      }
    }
    Future<void>selectBillDate() async {
      DateTime? _picked =  await showDatePicker(
        context: context,
      initialDate: toDate,
      firstDate: DateTime(1980), 
      lastDate: DateTime.now(),
      );
      if(_picked != null){
       setState(() {
        toDate=_picked;
         billdateController.text= Helper().formateDate(_picked);// _picked.toString().split(" ")[0];
       });
      //  await getpendingbilllist();
      }
    }
     renderAutoComplete(screenWidth, screenHeight) {
    return Autocomplete<List>(
      optionsBuilder: (TextEditingValue textEditingValue) {
      

        if (textEditingValue.text == '') {
          return  const Iterable<List>.empty();
        } else {
          var matches = [];
          matches.addAll(PatientList);
          matches.retainWhere((s) {
            return s['customer_name']
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()) ||
                 s['phone']
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
                
          });
          setState(() {});
          return [matches];
        }
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
                 decoration: InputDecoration(
                  suffixIcon:Icon(Icons.search,color: custom_color.appcolor,),
                  
                  hintText: 'Search Patient Name *',
                  
                  
                  
                  
                  enabledBorder: OutlineInputBorder(
                    
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: custom_color.appcolor,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: custom_color.appcolor,
                      width: 1.0,
                    ),
                  ),
                ),
                
            
            // decoration:  InputDecoration(
            //     border: OutlineInputBorder(),
            //     // prefix: Icon(Icons.search),
            //     prefixIcon: Icon(Icons.search),
            //     hintText: ' Search Patient Name'),
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            });
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<List> onSelected, Iterable<List> options) {
        return options.toList()[0].isNotEmpty ?
         Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: SizedBox(
              width: screenWidth ,
              // height: screenHeight * 0.8,
              // color:Colors.transparent,
              // color: Colors.white,
              child: Card(
                 color: Colors.transparent,
                      elevation: 30,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
             
                  child: Column(
                    children: [
                     
                
                      ListView.builder(
                        shrinkWrap: true,
                        padding:  const EdgeInsets.all(5.0),
                        itemCount: options.toList()[0].length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                                final option =
                                    options.toList()[0].elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    storage.setItem('selectedPatient',
                                        options.toList()[0][index]);
                                    setState(() {
                                      showAutoComplete = false;
                                      selectedPatient =
                                          options.toList()[0][index];
                                    });
                                  },
                                  child: Card(
                                    color: Colors.grey,
                                    // color: custom_color.app_color,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Padding(
                                    padding:  EdgeInsets.all(5),
                                    child: Text(
                                        '${options.toList()[0][index]['customer_name'].toString()}',
                                        style:  TextStyle(color: Colors.black)),
                                                              ),
                                                              Text(
                                        ' ${options.toList()[0][index]['phone'].toString()}',
                                        style:  TextStyle(color: Colors.black)),
                                                              // Divider(
                                                              //   thickness: 1,
                                                              // )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ):Align(
                alignment: Alignment.topCenter,
                child: Material(
                  child: Container(
                    width: screenWidth * 0.5,
                    color: Colors.blue.shade100,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5.0),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   selectedPatient = options.toList()[0][index];
                              //   showAutoComplete = false;
                              // });
                            },
                            child: const Card(
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text('Search List Empty'),
                              ),
                            ));
                      },
                    ),
                  ),
                ),
              );
      },
    );
  }

  renderAutoComplete1(screenWidth, screenHeight) {
    return Autocomplete<List>(
      optionsBuilder: (TextEditingValue textEditingValue) {
      

        if (textEditingValue.text == '') {
          return  const Iterable<List>.empty();
        } else {
          var matches = [];
          matches.addAll(groupList);
          matches.retainWhere((s) {
            return s['group_name']
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
          setState(() {});
          return [matches];
        }
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
                 decoration: InputDecoration(
                  hintText: 'Group Name',
                  
                  suffixIcon: Icon(Icons.search,color: custom_color.appcolor,),
                  
                  
                  enabledBorder: OutlineInputBorder(
                    
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: custom_color.appcolor,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: custom_color.appcolor,
                      width: 1.0,
                    ),
                  ),
                ),
                
            
            // decoration:  InputDecoration(
            //     border: OutlineInputBorder(),
            //     // prefix: Icon(Icons.search),
            //     prefixIcon: Icon(Icons.search),
            //     hintText: ' Search Patient Name'),
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            });
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<List> onSelected, Iterable<List> options1) {
        return options1.toList()[0].isNotEmpty ?
         Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: SizedBox(
              width: screenWidth ,
              // height: screenHeight * 0.8,
              // color:Colors.transparent,
              // color: Colors.white,
              child: Card(
                 color: Colors.transparent,
                      elevation: 30,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
             
                  child: Column(
                    children: [
                     
                
                      ListView.builder(
                        shrinkWrap: true,
                        padding:  const EdgeInsets.all(5.0),
                        itemCount: options1.toList()[0].length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                                final option =
                                    options1.toList()[0].elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    storage.setItem('selectedgroup',
                                        options1.toList()[0][index]);
                                    setState(() {
                                      showAutoComplete1 = false;
                                      selectedgroup =
                                          options1.toList()[0][index];
                                    });
                                  },
                                  child: Card(
                                    color: Colors.grey,
                                    // color: custom_color.app_color,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Padding(
                                    padding:  EdgeInsets.all(8.0),
                                    child: Text(
                                        '${options1.toList()[0][index]['group_name'].toString()}',
                                        style:  TextStyle(color: Colors.black)),
                                                              ),
                                                              // Divider(
                                                              //   thickness: 1,
                                                              // )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ):Align(
                alignment: Alignment.topCenter,
                child: Material(
                  child: Container(
                    width: screenWidth * 0.5,
                    color: Colors.blue.shade100,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5.0),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   selectedPatient = options.toList()[0][index];
                              //   showAutoComplete = false;
                              // });
                            },
                            child: const Card(
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text('Search List Empty'),
                              ),
                            ));
                      },
                    ),
                  ),
                ),
              );
      },
    );
  }
  
   getpatientlist() async {
    // this.setState(() {
    //   isloading = true;
    // });
    var list = await PatientApi().getpatientlist(accesstoken);
    if (Helper().isvalidElement(list) &&
        Helper().isvalidElement(list['status']) &&
        list['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      //  storage.setItem('diagnosisList', diagnosisList);
      setState(() {
        PatientList = list['Customer_list'];
        isloading = true;
      });
    }
  }
   getgrouplist() async {
    // this.setState(() {
    //   isloading = true;
    // });
    var list = await PatientApi().getgrouplist(accesstoken);
    if (Helper().isvalidElement(list) &&
        Helper().isvalidElement(list['status']) &&
        list['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      //  storage.setItem('diagnosisList', diagnosisList);
      setState(() {
        groupList = list['list'];
        isloading = true;
      });
    }
  }
  var total;
  var totalqtyvalue;
  Add(){
if(selectedPatient == null){
    NigDocToast().showErrorToast('Select Patient');

  }
  else if(select_Category == null){
    NigDocToast().showErrorToast('Select Category');

  }
   else if(select_subCategory == null){
    NigDocToast().showErrorToast('Select SubCategory');

  }
  else if(selectedgroup == null){
    NigDocToast().showErrorToast('Select Group');

  }
  

    var data={
        'patient_id':selectedPatient['cid'].toString(),
        'patient_name':selectedPatient['customer_name'].toString(),
        'group_name':selectedgroup['group_name'].toString(),
        'group_id':selectedgroup['id'].toString(),
        'category_name':select_Category['category_name'].toString(),
        'category_id':select_Category['id'].toString(),
        'sub_category_name':select_subCategory['subcategory_name'].toString(),
        'sub_category_id':select_subCategory['id'].toString(),
        'description':descriptioncontroller.text.toString(),
        'rate':ratecontroller.text.toString(),
        'qty':qtycontroller.text.toString(),
        'total':totalcontroller.text.toString(),

      };

      item.add(data);
      clearProduct();
      ProductshowAutoComplete = true;
      print(item);
double grandtotal = 0.0;
int totalqty = 0;
     for (var product in item) {
       grandtotal += double.tryParse(product['total']) ?? 0.0;
       total = grandtotal;
         grandtotalcomtroller.text=total.toString();
     
        totalqty += int.tryParse(product['qty']) ?? 0;
           totalqtyvalue=totalqty;
        totalqtycomtroller.text=totalqtyvalue.toString();
}

// print('Grand Total: $grandtotal');
// print('Total Quantity: $totalqty');

  }
  // Add(){
  //   if(descriptioncontroller.text.isEmpty){
  //     NigDocToast().showErrorToast('Please discription');
  //   }
  //   var data = {

  //     'patient_id':selectedPatient['cid'].toString(),
  //     'admission_date':admissiondateController.text.toString(),
  //     'discharge_date':dischargedateController.text.toString(),
  //     'bill_date':billdateController.text.toString(),   
  //     'total_qty':qtycontroller.text.toString(),
  //     'grand_total':totalcontroller.text.toString(),
  //     'balance':totalcontroller.text.toString(),
  //     'check_in_status':'OUT',
  //     'final_amount':Finalamountcontroller.text.toString(),
  //     'summary_review':summarycomtroller.text.toString(),
// test:item;

  //     "items":[{
  //       'patient_id':selectedPatient['cid'].toString(),
  //       'patient_name':selectedPatient['customer_name'].toString(),
  //       'group_name':selectedgroup['group_name'].toString(),
  //       'category_name':select_Category['category_name'].toString(),
  //       'category_id':select_Category['id'].toString(),
  //       'sub_category_name':select_subCategory['subcategory_name'].toString(),
  //       'sub_category_id':select_subCategory['id'].toString(),
  //       'description':descriptioncontroller.text.toString(),
  //       'rate':ratecontroller.text.toString(),
  //       'qty':qtycontroller.text.toString(),
  //       'total':totalcontroller.text.toString(),

  //     }]



     

      
      
  //   };
  //   print(data);

  // if (item.length > 0) {
  //         int i = 0;
  //         for (var checkitem in item) {
  //           if (checkitem == null) {
  //             // Helper().Windows() == 'Windows'
  //             //     ? NigToast().displayErrorMotionToast(
  //             //         context, 'Already this Product added')
  //             //     : NigToast().showErrorToast('Already this Product added');
  //             //NigToast().showErrorToast('Already this Product added');

  //             return;
  //           } 
  //           else {
  //             i++;

  //             if (item.length == i) {
  //               this.setState(() {
  //                 item.add(data['items']);
  //                 clearProduct();
  //                 ProductshowAutoComplete = true;
  //                 print(item);
  //               });
  //               return;
  //             }
  //           }
  //         }
  //       } else {
  //         this.setState(() {
  //           item.add(data['items']);
  //           clearProduct();
  //           ProductshowAutoComplete = true;
  //           print(item);
  //         });
  //         return;
  //       }
  // }
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

  clearProduct(){
    this.setState(() {
      FocusScope.of(context).unfocus();
      // select_Category='';
      // select_subCategory = '';
      // selectedgroup = '';
      descriptioncontroller.text = '';
      ratecontroller.text ='';
      qtycontroller.text = '';
      totalcontroller.text ='';
      
    });

  }
}