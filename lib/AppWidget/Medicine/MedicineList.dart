import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineList.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineold.dart';
import 'package:nigdoc/AppWidget/Medicine/EditMedicinenew.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/Shop/Api.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class MedicineList extends StatefulWidget {
  const MedicineList({super.key});

  @override
  State<MedicineList> createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
   TextEditingController searchText = TextEditingController();
    TextEditingController medicine_Controller=TextEditingController();
TextEditingController Alternative_Controller=TextEditingController();
TextEditingController pattrn_Controller=TextEditingController();
TextEditingController expdatecontroller =  TextEditingController();

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
 var medicineList;
 var medicine_List;
 bool valid=false;
 bool MedicineLoader=false;

 var selected_item;
var item =[
 '0-0-0-1',
 '0-0-1-0',
 '0-0-1-1',
 '0-1-0-1',
 '0-1-1-0',
 '1-0-0-1',
 '1-0-1-0',
 '1-1-0-0',
 '0-1-1-1',
 '1-0-1-1',
 '1-1-0-1',
 '1-1-1-0',
 '1-1-1-1',
 '0-0-0-2',
 '0-0-2-0',
 '0-2-0-0',
 '2-0-0-0',
 '0-0-2-2',
 '0-2-0-2',
 '0-2-2-0',
 '2-0-0-2',
 '2-0-2-0',
 '2-2-0-0',
 '0-2-2-2',
 '2-0-2-2',
 '2-2-0-2',
 '2-2-2-0',
 '2-2-2-2',
];
var clinicconfig;
var configDetails = null;
var commonmedicine;
var delete = 'yes';
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
    await getMedicineList();
    
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
          context, MaterialPageRoute(builder: (context)=> Dash(),)
         );
         return true;
        },
        child:Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: Text('Medicine List',
          style: TextStyle(color: Colors.white),),
          backgroundColor:custom_color.appcolor,
          leading: IconButton(onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Dash(),)
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
                      Center(child: 
                      Container(
                        height: screenHeight * 0.06,
                        width: screenWidth*0.95,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: custom_color.appcolor,),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Row(
                          children: [
                            // Container(
                            //     width: screenWidth * 0.1,
                            //     height: screenHeight,
                            //     child: Icon(Icons.search,
                            //         color: custom_color.appcolor,)),
                            Container(
                              width: screenWidth * 0.65,
                              child: TextField(
                                controller: searchText,
                                onChanged: (text) {
                                  print(text);
                            filterItems(text);
                                  this.setState(() {});
                                  // var list = ProductListItem;
                                    // searchList = medicineList.where((element) {
                                    //   var treatList = element['name'].toString().toLowerCase();
                                    //   return treatList.contains(text.toLowerCase());
                                    //   // return true;
                                    // }).toList();
                                    // this.setState(() {});
                                },
                                decoration: new InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  hintText: 'Search Medicine List Here...',
                                ),
                              ),
                            ),
                            searchText.text.isNotEmpty
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
                                          searchText.clear();
                                          filterItems(searchText.text);
                                          searchList='';
                                        });
                                      },
                                    ))
                                : Container(),
                                 Container(
                                width: screenWidth * 0.18,
                                height: screenHeight,
                                child: Icon(Icons.search,
                                    color: custom_color.appcolor,)),
                          ],
                        ),
                      ),),
                            
                            
                          // SizedBox(height: screenHeight*0.01),
                         
                            
                          Helper().isvalidElement(medicine_List) && medicine_List.length > 0 ?
                           Container(
                            height:screenHeight * 0.85,
                            
                                     
                           width: screenWidth,
                            padding:EdgeInsets.all(5),
                            child: 
                            ListView.builder(
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemCount: medicine_List.length,
                              itemBuilder: (BuildContext context, int index){
                                list=index+1;
                                var data=medicine_List[index];
                                return Container(
                                  child: Column(
                                    children: [
                                      Card(
                                        color: index % 2 == 0
                                                      ?custom_color.lightcolor
                                                      : Colors.white,
                                        child: ListTile(
                                          title: SizedBox(child: Text('${data['name']}')),
                                          subtitle: Text('₹  ${data['mrp']}'),
                                          leading: Padding(
                                            padding: const EdgeInsets.only(top:3.0),
                                            child: Text('$list'),
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
                      if(commonmedicine == 'YES'){
                     Navigator.push(
                     context, MaterialPageRoute(builder: (context)=> Edit_MedicineList(selected_medicine :data,)));
                      }else{
                                  
                      
                    data2 = {
                          medicine_Controller.text = data['name'].toString(),
                          Alternative_Controller.text = data['aname'].toString(),
                          selected_item= data['pattern'].toString(),
                                  
                         };
                   showDialog(context: context, builder: (context)=>AlertDialog(
                    
                          actions: [
                         
                            Padding(padding: EdgeInsets.all(10)),
                  
                            Container(
                              
                              height: screenHeight*0.04,
                              width:screenWidth*0.8,
                            ),
                            TextFormField(
                    controller: medicine_Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Medicine Name "
                    ),
                  
                                  ),
                  
                                   SizedBox(height: screenHeight*0.02,),
                                   TextFormField(
                  controller: Alternative_Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      
                      labelText: "Alternative Medicine"
                    ),
                   
                     ),
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
                                'Pattern Type ',
                               
                              ),
                              
                            ),
                           
                            onChanged: (selected) {
                              selected_item=selected;
                              setState(() {
                               
                              });
                            },
                            items: item.map<DropdownMenuItem<String>>((item) {
                              return new DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 7, left: 8, right: 8),
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
                   Container(
                                // width: screenWidth*0.49,
                                child: TextField(
                                   controller: expdatecontroller,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  //filled: true,
                                  prefixIcon: Icon(Icons.calendar_today,color: custom_color.appcolor,),
                        
                                  labelText: "Exp Date"
                                ),
                        
                                readOnly: true,
                                onTap: (() {
                                  _selectDate();
                                }),
                                
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MedicineList()));
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
                        if(medicine_Controller.text.isEmpty){
                          NigDocToast().showErrorToast('Please Enter Medicine Nmae');
                                      
                        }else if(Alternative_Controller.text.isEmpty){
                          NigDocToast().showErrorToast('Enter The Alter Medicine');
                                      
                        }
                        else if(selected_item==null){
                          NigDocToast().showErrorToast('Select Pattern Type');
                        }else{
                          var items={
                              "id":data['id'],
                              "name":medicine_Controller.text.toString(),
                              "aname":Alternative_Controller.text.toString(),
                              "pattern":selected_item.toString(),
                              "exp_date":expdatecontroller.text.toString(),
                          };
                          var list = await PatientApi()
                                     .Editmedicine( accesstoken, items);
                                 if (list['message'] ==
                                     "updated successfully") {
                                   NigDocToast().showSuccessToast(
                                       'updated successfully');
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) => MedicineList()));
                                 } else {
                                   NigDocToast()
                                       .showErrorToast('Please TryAgain later');
                                 }
                         // Helper().isvalidElement(data);
                         //   print(data);
                        }
                       
                      }),
                     
                  
                  //      Padding(
                  //        padding: const EdgeInsets.only(top: 0,left: 30,right:10),
                  //        child: ElevatedButton( 
                          
                  //         style: ButtonStyle(
                  //             backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                  //             shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      
                  //     RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                      
                  //   )
                    
                  // ),
                  //        child:Text('Cancel',
                  //        style: TextStyle(fontSize: 20,color: Colors.white),),
                  //        onPressed: (() {
                  //        Navigator.push(context, MaterialPageRoute(builder: (context)=>MedicineList()));
                  //        }),),
                  //      ),
                       SizedBox(height: screenHeight*0.04,),
                   ],
                                   ),
                  
                   ],
                  
                   ));
                  
                      }
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
                           
                            SizedBox(height: screenHeight*0.02,),
                             Center(child: Container(child: Text('DELETE PRODUCT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))),
                             SizedBox(height: screenHeight*0.02,),
                             Container(
                              child: Text('Are you sure you want to delete the Medicine Details?',style: TextStyle(fontSize: 16),),
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
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>MedicineList()));
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
                                                "id":data['id'],
                                                 'is_delete':delete,
                                               };
                                               var list = await PatientApi()
                                        .Deletemedicine( accesstoken, value);
                                    if (list['message'] ==
                                        "Deleted successfully") {
                                      NigDocToast().showSuccessToast(
                                          'Deleted successfully');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MedicineList()));
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
              if(commonmedicine == 'YES'){
               Navigator.push(context,MaterialPageRoute(builder: (context)=>Add_MedicineList()));
              }
              else{
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>AddMedicineold()));
              }
             
            },
          child:Icon(Icons.add,
          size: 30,
          color: Colors.white,),
          backgroundColor: custom_color.appcolor,
            
            ), 

          )
          );
  }
  // getMedicineList() async {
  //   var data = {
  //     "shop_id": Helper().isvalidElement(SelectedPharmacy)?  SelectedPharmacy.toString():'',
  //   };

  //   var List = await PatientApi().getmedicineList(accesstoken, data);
  //   if (Helper().isvalidElement(List) &&
  //       Helper().isvalidElement(List['status']) &&
  //       List['status'] == 'Token is Expired') {
  //     Helper().appLogoutCall(context, 'Session expeired');
  //   } else {
  //     setState(() {
  //       //  MediAndLabNameList = List['list'];
  //       medicineList = List['list'];
  //       MedicineLoader=true;
  //       valid=true;
  //       isLoading=true;
  //     });
  //     // TreatmentList = List['list'];
  //     //  storage.setItem('diagnosisList', diagnosisList);
  //   }
  // }

 getMedicineList() async {
    var data = {
      "shop_id": Helper().isvalidElement(SelectedPharmacy)?  SelectedPharmacy.toString():'',
    };

    var List = await PatientApi().medicineList(accesstoken, data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        //  MediAndLabNameList = List['list'];
        medicineList = List['list'];
        MedicineLoader=true;
        valid=true;
        isLoading=true;
        filterItems(searchText.text);
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }
  getMediAndLabNameList() async {
    var data = {
      "type": 'pharmacy',
    };
    var List = await PatientApi().getMediAndLabNameList(accesstoken, data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        MediNameList = List['list'];
        isLoading=true;
        
        // var values = MediAndLabNameList;
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }
   Future<void>_selectDate() async {
      DateTime? _picked =  await showDatePicker(
        context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980), 
      lastDate: DateTime(2050),
      );
      if(_picked != null){
       setState(() {
         expdatecontroller.text=_picked.toString().split(" ")[0];
       });
      }
    }
    void filterItems(String text) {
    // setState(() {
    if (text.isEmpty) {
      setState(() {
        medicine_List = medicineList;
      });
    } 
    else if (text.length >= 3) {
      setState(() {
        medicine_List = medicineList.where((item) =>
            item['name']
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