import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/Admission/Admission.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineList.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineold.dart';
import 'package:nigdoc/AppWidget/Medicine/EditMedicinenew.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/Shop/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SearchBar.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class FloorList extends StatefulWidget {
  const FloorList({super.key});

  @override
  State<FloorList> createState() => _FloorListState();
}

class _FloorListState extends State<FloorList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
   TextEditingController searchText = TextEditingController();
   TextEditingController editfloornamecontroller=TextEditingController();
   TextEditingController floornamecontroller = TextEditingController();


   String medicineDropdownvalue="empty";


  var accesstoken=null;
  var ProductList;
  var userResponse;
  bool isLoading=false;
  var list=0;
  var SelectedPharmacy;
  
  var searchList;
  var treatmentList;
  var Treatment_List;
 var MediNameList;
 
 bool valid=false;
 bool MedicineLoader=false;

var clinicconfig;
var configDetails = null;
var commonmedicine;
var delete = 'yes';
var shop_id;
var floorList;
var floor_List;
   @override
  void initState(){
    // userResponse = storage.getItem('userResponse');
    // accesstoken=userResponse['access_token'];
    
    // // getMediAndLabNameList();
    // getMedicineList();
    
    

    // gettreatmentlist();
    // TODO: implement initState
    super.initState();
     initilzeMethod();
  }
  initilzeMethod() async {
    await storage.ready;
    userResponse = await storage.getItem('userResponse');
    accesstoken = await userResponse['access_token'];
    shop_id = userResponse['clinic_profile'];
    await getFloorList();
    
    var config_details =
        await ShopApi().getclinicconfig(accesstoken);

    this.setState(() {
      configDetails = config_details['list'];
      commonmedicine = configDetails[0]['medicine_price'];
      print(commonmedicine);
    });
   
  }
  //  get()async{
  //    await storage.ready;
  //     userResponse = storage.getItem('userResponse');
  //   accesstoken=userResponse['access_token'];
  //   var clinicconfig = await ShopApi().getclinicconfig(accesstoken);
  //   this.setState(() {
      
  //     configDetails = clinicconfig['list'];
  //     commonmedicine = configDetails[0]['medicine_price'];
      
  //   });
  //  print(commonmedicine);
  // }
 var data2;
  @override
  Widget build(BuildContext context) {
    // medicine_List=Helper().isvalidElement(searchList)&&searchText.text.isNotEmpty?searchList: medicineList;
    double screenHeight = MediaQuery.of(context).size.height - 50;
    double screenWidth = MediaQuery.of(context).size.width;
      return new WillPopScope(
       onWillPop: () async {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Admission(),)
         );
         return true;
        },
        child:Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: Text('Floor List',
          style: TextStyle(color: Colors.white),),
          backgroundColor:custom_color.appcolor,
          leading: IconButton(onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Admission(),)
         );
          }, icon: Icon(Icons.arrow_back,
          color: Colors.white,),),
          // actions: [TextButton(onPressed: (){
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => const Add()),);
          // }, child: 
          // Row(
          //   children: [
          //     Icon(Icons.add, color: Colors.black,),
          //     Text('Add',style: TextStyle(fontSize: 18, color:Colors.black),),
          //   ],
          // )),
          // ],
          ),
          body:isLoading? Container(
            height: screenHeight,
            child: Column(
              children: [            
                 SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                       Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: SearchBarWithIcons(
                                     controller: searchText,
                                     hintText: 'Search Floor List Here...',
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
                      // Container(
                      //   height: screenHeight * 0.06,
                      //   width: screenWidth*0.95,
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       border:
                      //           Border.all(color: custom_color.appcolor,),
                      //       borderRadius: BorderRadius.all(Radius.circular(4))),
                      //   child: Row(
                      //     children: [
                      //       // Container(
                      //       //     width: screenWidth * 0.1,
                      //       //     height: screenHeight,
                      //       //     child: Icon(Icons.search,
                      //       //         color: custom_color.appcolor,)),
                      //       Container(
                      //         width: screenWidth * 0.65,
                      //         child: TextField(
                      //           controller: searchText,
                      //           onChanged: (text) {
                      //             print(text);
                      //       filterItems(text);
                      //             this.setState(() {});
                      //             // var list = ProductListItem;
                      //               // searchList = medicineList.where((element) {
                      //               //   var treatList = element['name'].toString().toLowerCase();
                      //               //   return treatList.contains(text.toLowerCase());
                      //               //   // return true;
                      //               // }).toList();
                      //               // this.setState(() {});
                      //           },
                      //           decoration: new InputDecoration(
                      //             filled: true,
                      //             border: InputBorder.none,
                      //             fillColor: Colors.white,
                      //             hintText: 'Search Floor List Here...',
                      //           ),
                      //         ),
                      //       ),
                      //       searchText.text.isNotEmpty
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
                      //                     searchText.clear();
                      //                     filterItems(searchText.text);
                      //                     searchList='';
                      //                   });
                      //                 },
                      //               ))
                      //           : Container(),
                      //            Container(
                      //           width: screenWidth * 0.18,
                      //           height: screenHeight,
                      //           child: Icon(Icons.search,
                      //               color: custom_color.appcolor,)),
                      //     ],
                      //   ),
                      // ),),
                            
                            
                          // SizedBox(height: screenHeight*0.01),
                         
                            
                          Helper().isvalidElement(floor_List) && floor_List.length > 0 ?
                           Container(
                            height:screenHeight * 0.85,
                            
                                     
                           width: screenWidth,
                            padding:EdgeInsets.all(5),
                            child: 
                            ListView.builder(
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemCount: floor_List.length,
                              itemBuilder: (BuildContext context, int index){
                                list=index+1;
                                var data=floor_List[index];
                                return Container(
                                  child: Column(
                                    children: [
                                      Card(
                                        color: index % 2 == 0
                                                      ?custom_color.lightcolor
                                                      : Colors.white,
                                        child: ListTile(
                                          title: SizedBox(child: Text('${data['floor_name']}')),
                                          // subtitle: Text('₹  ${data['mrp']}'),
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
                          editfloornamecontroller.text = data['floor_name'].toString(),
                         
                                  
                         };
                   showDialog(context: context, builder: (context)=>AlertDialog(
                    
                          actions: [
                          IconButton(onPressed: (){
                       Navigator.push(context,MaterialPageRoute(builder: (context) => FloorList()));
                        }, icon: Icon(Icons.close,color: Colors.red,)),
                            Padding(padding: EdgeInsets.all(10)),
                    Center(child: Container(child: Text('Edit Floor',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),)),
                  SizedBox(height: screenHeight*0.01,),
                            Container(
                              
                              height: screenHeight*0.01,
                              width:screenWidth*0.8,
                            ),
                            TextFormField(
                    controller: editfloornamecontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Floor Name * "
                    ),
                  
                                  ),
                  
                                   
                  SizedBox(height: screenHeight*0.04,),
                  Row(
                  children: [
                    SizedBox(width: screenWidth*0.05,),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FloorList()));
                    }),),
                    SizedBox(width: screenWidth*0.05,),
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
                        if(editfloornamecontroller.text.isEmpty){
                          NigDocToast().showErrorToast('Please Enter Floor Name');
                                      
                       
                        }else{
                          var items={
                              "id":data['id'].toString(),
                              "floor_name":editfloornamecontroller.text.toString(),
                             
                          };
                          var list = await PatientApi()
                                     .DocEditFloor(accesstoken, items);
                                 if (list['message'] ==
                                     "updated successfully") {
                                   NigDocToast().showSuccessToast(
                                       'updated successfully');
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) => FloorList()));
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
                       Navigator.push(context,MaterialPageRoute(builder: (context) => FloorList()));
                        }, icon: Icon(Icons.close,color: Colors.red,)),
                            SizedBox(height: screenHeight*0.02,),
                             Center(child: Container(child: Text('DELETE FLOOR',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))),
                             SizedBox(height: screenHeight*0.02,),
                             Container(
                              child: Text('Are you sure you want to delete the Floor Details?',style: TextStyle(fontSize: 16),),
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
                                        .DocDeleteFloor( accesstoken, value);
                                    if (list['message'] ==
                                        "Deleted successfully") {
                                      NigDocToast().showSuccessToast(
                                          'Deleted successfully');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => FloorList()));
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
                             ):Container(child:
                              Text('No Data Found')
                              )
                              
                    ],
                  ),
                ),
                     ],
            ),
          ):Center(
            child: Container(child:SpinLoader()
          )
          ),
               floatingActionButton: FloatingActionButton(
            
            onPressed:(){
             showDialog(context: context, builder: (context)=>AlertDialog(
                    
                          actions: [
                        IconButton(onPressed: (){
                       Navigator.push(context,MaterialPageRoute(builder: (context) => FloorList()));
                        }, icon: Icon(Icons.close,color: Colors.red,)),

                            Padding(padding: EdgeInsets.all(10)),
                            Center(child: Container(child: Text('Add Floor',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),)),
                  SizedBox(height: screenHeight*0.01,),
                            Container(
                              
                              height: screenHeight*0.01,
                              width:screenWidth*0.8,
                            ),
                            TextFormField(
                    controller: floornamecontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Floor Name * "
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
                        if(floornamecontroller.text.isEmpty){
                          NigDocToast().showErrorToast('Please Enter Floor Name');
                        }else{
                          var data= {
                             "floor_name":floornamecontroller.text.toString(),
                          };
                          var list = await PatientApi()
                                     .DocAddFloor(accesstoken, data);
                                 if (list['message'] ==
                                     "Floor Add successfully") {
                                   NigDocToast().showSuccessToast(
                                       'Floor Add successfully');
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) => FloorList()));
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

          )
          );
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
        filterItems(searchText.text);
      });
    }
  }
 
    void filterItems(String text) {
    // setState(() {
    if (text.isEmpty) {
      setState(() {
        floor_List = floorList;
      });
    } 
    else if (text.length >= 3) {
      setState(() {
        floor_List = floorList.where((item) =>
            item['floor_name']
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