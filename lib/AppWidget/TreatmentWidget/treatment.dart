import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/TreatmentWidget/AddTreatment.dart';
import 'package:nigdoc/AppWidget/TreatmentWidget/EditTreatment.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class TreatmentList extends StatefulWidget {
  const TreatmentList({super.key});

  @override
  State<TreatmentList> createState() => _TreatmentListState();
}

class _TreatmentListState extends State<TreatmentList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
   TextEditingController searchText = TextEditingController();
TextEditingController Treatmentcontroller = TextEditingController();
  TextEditingController medicinecontroller = TextEditingController();
  TextEditingController Departmentcontroller = TextEditingController();
  TextEditingController Feescontroller = TextEditingController();

  var accesstoken=null;
  var ProductList;
  var userResponse;
  bool isLoading=false;
  var list=0;
  
  var searchList;
  var treatmentList;
  var Treatment_List;

   String medicinedropdow = "Select Medicine List *";
  String departmentdropdown = "Select Department *";
 var selected_values1;
  var title={
     'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',

  };
  
 
  var SelectedPharmacy;
 var title2={
     'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',

  };

   @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];

    gettreatmentlist();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Treatment_List=Helper().isvalidElement(searchList)&&searchText.text.isNotEmpty?searchList: treatmentList;
    double screenHeight = MediaQuery.of(context).size.height - 50;
    double screenWidth = MediaQuery.of(context).size.width;
      return new WillPopScope(
       onWillPop: () async {
         Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Setting(),)
         );
         return true;
        },
        child:Scaffold(
          appBar: AppBar(title: Text('Treatment List',
          style: TextStyle(color: Colors.white),),
          backgroundColor: custom_color.appcolor ,
          leading: IconButton(onPressed: (){
            Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Setting(),)
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
          body:isLoading? SingleChildScrollView(
            child: Padding(padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                // Container(
                //   width: screenWidth*0.9,
                //   child: TextFormField(decoration: 
                //   InputDecoration(border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(8),
                //   ),hintText: 'Search',
                //   prefixIcon: Container(
                //     padding: EdgeInsets.all(10),
                //     child: Icon(Icons.search),
                //   ),
                //   ),
                //   ),
                //     ),
                 SizedBox(
                  height: 10,
                ),
                Center(child: 
                Container(
                  height: screenHeight * 0.06,
                  width: screenWidth*0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color:custom_color.appcolor),
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  child: Row(
                    children: [
                      Container(
                          width: screenWidth * 0.1,
                          height: screenHeight,
                          child: Icon(Icons.search,
                              color: custom_color.appcolor)),
                      Container(
                        width: screenWidth * 0.65,
                        child: TextField(
                          controller: searchText,
                          onChanged: (text) {
                            print(text);

                            this.setState(() {});
                            // var list = ProductListItem;
                              searchList = treatmentList.where((element) {
                                var treatList = element['treatment'].toString().toLowerCase();
                                return treatList.contains(text.toLowerCase());
                                // return true;
                              }).toList();
                              this.setState(() {});
                          },
                          decoration: new InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            hintText: 'Search Treatment List Here...',
                          ),
                        ),
                      ),
                      searchText.text.isNotEmpty
                          ? Container(
                              width: screenWidth * 0.1,
                              height: screenHeight,
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    searchText.text = '';
                                    searchList='';
                                  });
                                },
                              ))
                          : Container(),
                    ],
                  ),
                ),),


                    // SizedBox(height: screenHeight*0.01),

                    Helper().isvalidElement(Treatment_List) && Treatment_List.length > 0 ?
                     Container(
                      height:screenHeight * 0.86,
                      

                     width: screenWidth,
                      padding:EdgeInsets.all(15),
                      child: 
                      ListView.builder(
                        // shrinkWrap: true,
                        itemCount: Treatment_List.length,
                        itemBuilder: (BuildContext context, int index){
                          list=index+1;
                          var data=Treatment_List[index];
                          return Container(
                            child: Column(
                              children: [
                                Card(
                                  color: index % 2 == 0
                                                ? custom_color.lightcolor
                                                : Colors.white,
                                  child: ListTile(
                                    title: SizedBox(child: Text('${data['treatment']}')),
                                    leading: Text('$list'),

                                    trailing: PopupMenuButton(itemBuilder: (context)=>[
                                      PopupMenuItem(child: Row(
                                              children: [
                                                Icon(Icons.edit,color: custom_color.appcolor,),
                                                Padding(padding: EdgeInsets.only(left: 10),
                                                child: Text('Edit',style: TextStyle(fontSize: 16),),)
                                              ],
                                            ),
                                            onTap: () {
                                               Navigator.push(
          context, MaterialPageRoute(builder: (context)=> Edittreatment(medicinelist:data),)
         );
//                                               showDialog(context: context, builder:(context)=>AlertDialog(
                                               
//                                                actions: [
//                                                  Padding(padding: EdgeInsets.all(10)),
//                                                     Container(
//                                                       height: screenHeight*0.04,
//                                                       width: screenWidth*0.14,
//                                                     ),
                                                    
//                                                                SizedBox(height: screenHeight*0.02,),
//                 TextFormField(
                 
//                   controller: Treatmentcontroller,

//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Treatment Name'
//                   ),
//                 ),
               
//                 SizedBox(
//                   height: screenHeight * 0.02,
//                 ),
                

//                  Padding(
//                    padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
//                       //padding: const EdgeInsets.all(20.0),
//                       child: Container(
//                         height: screenHeight *0.07,
//                         width: screenWidth * 0.96,
//                         decoration: BoxDecoration(border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(5.0)
//                             // border: OutlineInputBorder()
//                             ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Center(
//                             child: DropdownButtonFormField(
                            
//                               decoration: InputDecoration.collapsed(hintText: ''),
//                               isExpanded: true,
//                               hint: Padding(
//                               padding: const EdgeInsets.only(top: 0, left: 2, right: 0,),
//                                 child: Text(
//                                   ' Medicine List*',
                                 
//                                 ),
//                               ),
                             
//                               onChanged: (newvalue) {
//                               //  medicineList=newvalue.toString();
//                               medicinedropdow=newvalue.toString();
//                                 setState(() {
                                 
//                                 });
                             
//                               },
//                               items: title.map<DropdownMenuItem<String>>((item) {
//                                 return new DropdownMenuItem(
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(top: 7, left: 8, right: 8),
//                                     child: new Text(item,style: TextStyle(fontSize: 15),),
//                                   ),
//                                   value: item.toString(),
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                 SizedBox(
//                   height: screenHeight * 0.02,
//                 ),
//                 Padding(
//                    padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                  
//                   child: Container(
//                      height: screenHeight * 0.07,
//                       width: screenWidth * 0.96,

//                    decoration: BoxDecoration(border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(5.0)
                         
//                           ),
                  
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       //padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
//                       child: Center(
//                         child: DropdownButtonFormField(
//                           decoration: InputDecoration.collapsed(hintText: ''),
//                             isExpanded: true,
//                             hint: Padding(
                              
//                               padding: const EdgeInsets.only(top: 0, left: 2, right: 0),
//                               child: Text(
//                                 ' Department*',
                               
//                               ),
//                             ),
                        
//                             onChanged: (newvalue) {
//                               departmentdropdown=newvalue.toString();
//                               setState(() {
                                
//                               });
//                             },
                            
//                             items: title2.map<DropdownMenuItem<String>>((item) {
//                               return new DropdownMenuItem(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top: 7, left: 8, right: 8),
//                                   child: new Text(item,style: TextStyle(fontSize: 15),),
//                                 ),
//                                 value: item.toString(),
//                               );
//                             }).toList(),
                      
//                          ),
//                       ),
//                     ),
//                   ),
//                 ),
          
//                 SizedBox(
//                   height: screenHeight * 0.03,
//                 ),
          
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                       autovalidateMode: AutovalidateMode.always,
                  
//                   controller: Feescontroller,

//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Fees'
//                   ),
//                 ),
               
//                 SizedBox(
//                   height: screenHeight * 0.02,
//                 ),

//                 Row(
//                       children: [

//                         Padding(padding: EdgeInsets.only(left:20),
//                         child: ElevatedButton(
//                           // style: ElevatedButton.styleFrom(
//                           //   backgroundColor: custom_color.appcolor,
//                           // ),
//                             style: ButtonStyle(
//                             backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
//                             shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    
//                             RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
       
      
//                             ),
    
//                             )
  
//                             ),
//                            child: Text('Update',style: TextStyle(color: Colors.white,fontSize: 20),),
//                            onPressed: (() {
//                          if (Treatmentcontroller.text.isEmpty) {
                        
//                         Fluttertoast.showToast(
//                             msg: ' Enter Treatment Name',
                           
//                             textColor: Colors.black,
//                             fontSize: 15.0);
//                       } else if (medicinedropdow == null ||
//                           medicinedropdow == "Select Medicine List *") {
//                         Fluttertoast.showToast(
//                             msg: 'Please Select Medicine List', fontSize: 15.0);
//                       } else if (departmentdropdown == null ||
//                           departmentdropdown == "Select Department *") {
//                         Fluttertoast.showToast(
//                             msg: 'Please Select Department', fontSize: 15.0);
//                       } else if (Feescontroller.text.isEmpty) {
//                         Fluttertoast.showToast(
//                             msg: " Enter Fees", fontSize: 15.0);
//                        }else {
//                         var data = {
//                           "treatmentname": Treatmentcontroller.text.toString(),
//                           "medicine": medicinedropdow.toString(),
//                           "Department": departmentdropdown.toString(),
//                           "consult_fees": Feescontroller.text.toString(),
//                           "description": ""
//                         };
//                       Helper().isvalidElement(data);
                       
//                         print(data);
                       
//                       }
                             
//                            }),
//                            ),
//                         ),

//                         Padding(padding: EdgeInsets.only(left: 20),
                        
//                         child: ElevatedButton( 
//                           // style: ElevatedButton.styleFrom(
//                           //   backgroundColor: custom_color.appcolor,
//                           // ),
//                             style: ButtonStyle(
//             backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
//             shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    
//             RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(10),
       
      
//     ),
    
//   )
  
// ),
//                           child:Text('Cancel',style: TextStyle(color: Colors.white,fontSize: 20),),

//                           onPressed: (() {
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>TreatmentList()));
//                           }),
                          
//                           ),
                          
                          
//                           ),
//                       ],
//                     ),

//                                                ],

//                                               ) );
                                            },
                                            ),

                                            


                                    ]
                                    
                                    ),
                     
                                  ),
                                )
                              ],
                            ),
                          );
                      })
                       ):Container(child:
            Text('No Data Found')
          ),
                         SizedBox(height: 10,),
                     ],
            ),),
          ):Center(
            child: Container(child:SpinLoader()
          )
          ),
          floatingActionButton: FloatingActionButton(onPressed:(){
             Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTretment(),
                          ));
   },
   child: Icon(Icons.add,
   size: 30,
   color: Colors.white,),
   backgroundColor: custom_color.appcolor,
  
   ),
          )
          );
  }
   gettreatmentlist() async {
    var List = await PatientApi().getTreatmentList(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        isLoading=true;
        treatmentList = List['list'];
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
    }
  }
}