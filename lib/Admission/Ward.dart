import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/Admission/Admission.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SearchBar.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class Ward extends StatefulWidget {
  const Ward({super.key});

  @override
  State<Ward> createState() => _WardState();
}

class _WardState extends State<Ward> {
  final LocalStorage storage = new LocalStorage('doctor_store');
   TextEditingController searchText = TextEditingController();
   TextEditingController wardnamecontroller = TextEditingController();
   TextEditingController editwardnamecontroller = TextEditingController();
  var searchList;
  var list =0;
  var selected_floor;
  var userResponse;
  var accesstoken;
  bool isLoading = false;
  var wardList;
  var floordropdown;
var data2;
var delete = 'yes';
  List floorList =[];
  var ward_List;
  void initState() {
     userResponse = storage.getItem('userResponse');
    accesstoken =  userResponse['access_token'];
    
     init();
     
  }
  init() async {
    await getDocWardList();
    await getFloorList();

    setState(() {
    
    });

   
  }
   getDocWardList() async {
    var List = await PatientApi().getDocWardList(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        wardList = List['list'];
        isLoading = true;
        filterItems(searchText.text);
      });
    }
  }
  void filterItems(String text) {
    // setState(() {
    if (text.isEmpty) {
      setState(() {
        ward_List = wardList;
      });
    } 
    else if (text.length >= 3) {
      setState(() {
        ward_List = wardList.where((item) =>
            item['ward_name']
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
  getFloorList() async {
    var List = await PatientApi().getDocFloor(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        floorList = List['list'];
        isLoading = true;
        // filterItems(searchText.text);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidht = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Admission(),)
         );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ward List',style: TextStyle(color: Colors.white),),
           backgroundColor:custom_color.appcolor,
          leading: IconButton(onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Admission(),)
         );
          }, icon: Icon(Icons.arrow_back,
          color: Colors.white,),),
        ),
        body:isLoading? SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                     Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: SearchBarWithIcons(
                                     controller: searchText,
                                     hintText: 'Search Ward List Here...',
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
                    //         width: screenWidht*0.95,
                    //         decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             border:
                    //                 Border.all(color: custom_color.appcolor,),
                    //             borderRadius: BorderRadius.all(Radius.circular(4))),
                    //         child: Row(
                    //           children: [
                    //             // Container(
                    //             //     width: screenWidth * 0.1,
                    //             //     height: screenHeight,
                    //             //     child: Icon(Icons.search,
                    //             //         color: custom_color.appcolor,)),
                    //             Container(
                    //               width: screenWidht * 0.65,
                    //               child: TextField(
                    //                 controller: searchText,
                    //                 onChanged: (text) {
                    //                   print(text);
                    //             filterItems(text);
                    //                   this.setState(() {});
                    //                   // var list = ProductListItem;
                    //                     // searchList = medicineList.where((element) {
                    //                     //   var treatList = element['name'].toString().toLowerCase();
                    //                     //   return treatList.contains(text.toLowerCase());
                    //                     //   // return true;
                    //                     // }).toList();
                    //                     // this.setState(() {});
                    //                 },
                    //                 decoration: new InputDecoration(
                    //                   filled: true,
                    //                   border: InputBorder.none,
                    //                   fillColor: Colors.white,
                    //                   hintText: 'Search Ward List Here...',
                    //                 ),
                    //               ),
                    //             ),
                    //             searchText.text.isNotEmpty
                    //                 ? Container(
                    //                     width: screenWidht * 0.06,
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
                    //                           searchList='';
                    //                         });
                    //                       },
                    //                     ))
                    //                 : Container(),
                    //                  Container(
                    //                 width: screenWidht * 0.18,
                    //                 height: screenHeight,
                    //                 child: Icon(Icons.search,
                    //                     color: custom_color.appcolor,)),
                                        
                    //           ],
                    //         ),
                    //       ),),
                          SizedBox(height: screenHeight*0.02,),
                           Helper().isvalidElement(ward_List) && ward_List.length > 0 ?
                           Container(
                            height:screenHeight * 0.85,
                            
                                     
                           width: screenWidht,
                            padding:EdgeInsets.all(5),
                            child: 
                            ListView.builder(
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemCount: ward_List.length,
                              // itemCount: 1,
                              itemBuilder: (BuildContext context, int index){
                                list=index+1;
                                var data=ward_List[index];
                                return Container(
                                  child: Column(
                                    children: [
                                      Card(
                                        color: index % 2 == 0
                                                      ?custom_color.lightcolor
                                                      : Colors.white,
                                        child: ListTile(
                                          // title: SizedBox(child: Text('${data['floor_name']}')),
                                          // subtitle: Text('₹  ${data['mrp']}'),
                                          title: SizedBox(child: Text('Floor Name : ${data['floor_name']}')),
                                          subtitle: Text('Ward Name : ${data['ward_name']}'),
                                          leading: Padding(
                                            padding: const EdgeInsets.only(top:3.0),
                                            child: Text('($list)'),
                                          ),
                            
                  
                             trailing: PopupMenuButton(itemBuilder: (context)=>
                    [
                    PopupMenuItem(
                      child: Row(
                      children: [
                        
                          Icon(Icons.edit,
                          color: custom_color.appcolor,
                          ),
                             Padding(padding: EdgeInsets.only(left:10),
                             child: Center(child: Text('Edit',style: TextStyle(fontSize: 16),)),),
                  
                      ],
                    ),
                   
                    onTap: () {
                        
                      
                    data2 = {
                      
                          editwardnamecontroller.text = data['ward_name'].toString(),
                         
                                  
                         };
                   showDialog(context: context, builder: (context)=>AlertDialog(
                    
                          actions: [
                          IconButton(onPressed: (){
                       Navigator.push(context,MaterialPageRoute(builder: (context) => Ward()));
                        }, icon: Icon(Icons.close,color: Colors.red,)),
                            Padding(padding: EdgeInsets.all(10)),
                    Center(child: Container(child: Text('Edit Ward',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),)),
                     SizedBox(height: screenHeight*0.01,),
                    SizedBox(
            width: screenWidht * 0.95,
            child: DropdownButtonFormField(
              menuMaxHeight: 300,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                isExpanded: true,
                hint: Text(
                  '${data['floor_name']}',
                ),
                // value:patternDropdownvalue,
                onChanged: (item) async {
                  floordropdown = item.toString();
                },
                items: floorList
                    .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                              value: value["id"].toString(),
                              child: Text(value["floor_name"].toString()),
                            ))
                    .toList()

                )),
                 
                  SizedBox(height: screenHeight*0.01,),
                            Container(
                              
                              height: screenHeight*0.01,
                              width:screenWidht*0.8,
                            ),
                            TextFormField(
                    controller: editwardnamecontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Ward Name * "
                    ),
                  
                                  ),
                  
                                   
                  SizedBox(height: screenHeight*0.04,),
                  Row(
                  children: [
                    SizedBox(width: screenWidht*0.05,),
                    ElevatedButton( 
                     
                     style: ButtonStyle(
                         backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                         shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          
                                        )
                                        
                                      ),
                    child:Text('Cancel',
                    style: TextStyle(fontSize: 20,color: Colors.white),),
                    onPressed: (() {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Ward()));
                    }),),
                    SizedBox(width: screenWidht*0.05,),
                    ElevatedButton( 
                    style: ButtonStyle(
                           backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          
                                          RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10),  
                                          ),
                                          
                                        )
                                        
                                      ),
                      child:Text('Update',
                      style: TextStyle(fontSize: 20,color: Colors.white),),
                      onPressed: ()async {
                        if(editwardnamecontroller.text.isEmpty){
                          NigDocToast().showErrorToast('Please Enter Watd Name');
                                      
                       
                        }else{
                          var items={
                              "id":data['id'].toString(),
                              "floor_id":floordropdown,
                              "ward_name":editwardnamecontroller.text.toString(),
                             
                          };
                          var list = await PatientApi()
                                     .DocEditWard(accesstoken, items);
                                 if (list['message'] ==
                                     "updated successfully") {
                                   NigDocToast().showSuccessToast(
                                       'updated successfully');
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) => Ward()));
                                 } else {
                                   NigDocToast()
                                       .showErrorToast('Please TryAgain later');
                                 }
                         // Helper().isvalidElement(data);
                         //   print(data);
                        }
                       
                      }),
                   
                       SizedBox(height: screenHeight*0.04,),
                   ],
                                   ),
                  
                   ],
                  
                   ));
                  
                      
                    }
                                        
                       ),
                                  
                    PopupMenuItem(
                          child: Row(
                          children: [
                        
                          Icon(Icons.delete,
                          color: custom_color.appcolor,
                          ),
                             Padding(padding: EdgeInsets.only(left:10),
                             child: Center(child: Text('Delete',style: TextStyle(fontSize: 16),
                             
                             )),
                             
                             ),
                    
                      ],
                    ),
                   
                    onTap: () {
                       showDialog(context: context, builder: (context)=>AlertDialog(
                    
                          actions: [
                            IconButton(onPressed: (){
                       Navigator.push(context,MaterialPageRoute(builder: (context) => Ward()));
                        }, icon: Icon(Icons.close,color: Colors.red,)),
                            SizedBox(height: screenHeight*0.02,),
                             Center(child: Container(child: Text('DELETE WARD',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))),
                             SizedBox(height: screenHeight*0.02,),
                             Container(
                              child: Text('Are you sure you want to delete the Ward Details?',style: TextStyle(fontSize: 16),),
                             ),
                              SizedBox(height: screenHeight*0.02,),
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
                      
                    )
                    
                  ),
                                      onPressed: (){
                                    
                                      Navigator.pop(context);
                                      }, child: Text('Cancel' ,style: TextStyle(fontSize: 20,color: Colors.white),)),
                                  ),
                                  Container(
                                    child: ElevatedButton(
                                       style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                    )
                    
                  ),
                  
                                      onPressed: ()async{
                                        
                                               var value= {
                                                 "id":data['id'].toString(),
                                                 'is_delete':delete,
                                               };
                                               var list = await PatientApi()
                                        .DocDeleteWard( accesstoken, value);
                                    if (list['message'] ==
                                        "Deleted successfully") {
                                      NigDocToast().showSuccessToast(
                                          'Deleted successfully');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Ward()));
                                    } else {
                                      NigDocToast()
                                          .showErrorToast('Please TryAgain later');
                                    }
                                      }, child: Text('Confirm' ,style: TextStyle(fontSize: 20,color: Colors.white),)),
                                  ),
                                  
                                ],
                              ),
                             )
                          ]
                       ));
                    }
                                        
                    ),
                    // PopupMenuItem(child: Text('Cancel'),
                    // onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder:(context)=>MedicineList()));
                    //            },
                                        
                    //               ),
                    ],            
                               ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                            })
                             )
                             :Container(child:
                              Text('No Data Found')
                              )
                  ],
                ),
              ),
            ),
          ),
         
        ):SpinLoader(),
         floatingActionButton: FloatingActionButton(
            
            onPressed:(){
             showDialog(context: context, builder: (context)=>AlertDialog(
                    
                          actions: [
                        IconButton(onPressed: (){
                       Navigator.push(context,MaterialPageRoute(builder: (context) => Ward()));
                        }, icon: Icon(Icons.close,color: Colors.red,)),

                            Padding(padding: EdgeInsets.all(10)),
                            Center(child: Container(child: Text('Add Ward',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),)),
                  SizedBox(height: screenHeight*0.01,),
                    SizedBox(
            width: screenWidht * 0.95,
            child: DropdownButtonFormField(
              menuMaxHeight: 300,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                isExpanded: true,
                hint: Text(
                  'Select Floor',
                ),
                // value:patternDropdownvalue,
                onChanged: (item) async {
                  floordropdown = item.toString();
                },
                items: floorList
                    .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                              value: value["id"].toString(),
                              child: Text(value["floor_name"].toString()),
                            ))
                    .toList()

                )),
                  SizedBox(height: screenHeight*0.02,),
                            Container(
                              
                              height: screenHeight*0.01,
                              width:screenWidht*0.8,
                            ),
                            TextFormField(
                    controller: wardnamecontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Ward Name * "
                    ),
                    ),
                  
                                   
                  SizedBox(height: screenHeight*0.02,),
               
                  Center(
                    child: ElevatedButton( 
                    style: ButtonStyle(
                           backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          
                                          RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10),  
                                          ),
                                          
                                        )
                                        
                                      ),
                      child:Text('Save',
                      style: TextStyle(fontSize: 20,color: Colors.white),),
                      onPressed: ()async {
                        if(wardnamecontroller.text.isEmpty){
                          NigDocToast().showErrorToast('Please Enter Floor Name');
                        }else{
                          var data= {
                             "floor_id":floordropdown,
                             "ward_name":wardnamecontroller.text.toString(),
                          };
                          var list = await PatientApi()
                                     .DocAddWard(accesstoken, data);
                                 if (list['message'] ==
                                     "Ward Add successfully") {
                                   NigDocToast().showSuccessToast(
                                       'Ward Add successfully');
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) => Ward()));
                                 } else {
                                   NigDocToast()
                                       .showErrorToast('Please TryAgain later');
                                 }
                        }
                       
                      }),
                  ),
                                     
                     SizedBox(height: screenHeight*0.01,),
                  
                   ],
                  
                   ));
             
            },
          child:Icon(Icons.add,
          size: 30,
          color: Colors.white,),
          backgroundColor: custom_color.appcolor,
            
            ),
      ));
  }
  
}