import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/InjectionList/AddInjectionList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class InjectionList extends StatefulWidget {
  const InjectionList({super.key});

  @override
  State<InjectionList> createState() => _InjectionListState();
}

class _InjectionListState extends State<InjectionList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
   TextEditingController searchText = TextEditingController();
   TextEditingController injectionnamecontroller = TextEditingController();
   TextEditingController injectionamountcontroller = TextEditingController();
   TextEditingController injectionqtycontroller = TextEditingController();
   TextEditingController expdatecontroller = TextEditingController();


  var accesstoken=null;
  var ProductList;
  var userResponse;
  bool isLoading=false;
  var list=0;
  
  var searchList;
  var treatmentList;
  var Injection_List;
  var injectionList;
 var data2;
   @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];

    getInjectionList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    // Injection_List=Helper().isvalidElement(searchList)&&searchText.text.isNotEmpty?searchList: injectionList;
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
          appBar: AppBar(title: Text('Injection List',
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
                          controller: searchText,
                          onChanged: (text) {
                            print(text);
 filterItems(text);
                            this.setState(() {});
                            // var list = ProductListItem;
                          
                              // searchList = Injection_List.where((element) {
                              //   var treatList = element['injections_name'].toString().toLowerCase();
                              //   return treatList.contains(text.toLowerCase());
                              //   // return true;
                              // }).toList();
                              this.setState(() {});
                          },
                          decoration: new InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            hintText: 'Search Injection List Here...',
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
                                    // searchText.text = '';
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


                    // SizedBox(height: screenHeight*0.01),

                    Helper().isvalidElement(Injection_List) && Injection_List.length > 0 ?
                     Container(
                      height:screenHeight * 0.86,
                      

                     width: screenWidth,
                      padding:EdgeInsets.all(15),
                      child: 
                      ListView.builder(
                        // shrinkWrap: true,
                        itemCount: Injection_List.length,
                        itemBuilder: (BuildContext context, int index){
                          list=index+1;
                          var data=Injection_List[index];
                          return Container(
                            child: Column(
                              children: [
                                Card(
                                  color: index % 2 == 0
                                                ? custom_color.lightcolor
                                                : Colors.white,
                                  child: ListTile(
                                    title: SizedBox(child: Text('${data['injections_name']}')),
                                    leading: Text('$list'),
                                   trailing: PopupMenuButton(itemBuilder: (context)=>[
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
                      //   if(commonmedicine == 'YES'){
                      //  Navigator.push(
                      //  context, MaterialPageRoute(builder: (context)=> Edit_MedicineList(selected_medicine :data,)));
                      //   }
                        
                      //   else{

                        
                      data2 = {
                            injectionnamecontroller.text = data['injections_name'].toString(),
                            injectionamountcontroller.text = data['injection_amount'].toString(),
                            injectionqtycontroller.text= data['injection_qty'].toString(),
                            expdatecontroller.text= data['injection_exp_date'].toString(),

                           };
                           print(data2);
                     showDialog(context: context, builder: (context)=>AlertDialog(
                      
                            actions: [
                           
                              Padding(padding: EdgeInsets.all(10)),
                    
                              Container(
                                
                                height: screenHeight*0.04,
                                width:screenWidth*0.8,
                              ),
                              TextFormField(
                      controller: injectionnamecontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        
                        labelText: "Injection Name "
                      ),
                    
                                    ),
                    
                                     SizedBox(height: screenHeight*0.02,),
                                     TextFormField(
                    controller: injectionamountcontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        
                        labelText: "Injection Amount"
                      ),
                     
                       ),
                       SizedBox(height: screenHeight*0.02,),
                       TextFormField(
                    controller: injectionqtycontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        
                        labelText: "Injection Qty"
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>InjectionList()));
                      }),),
                      SizedBox(width: screenWidth*0.10,),
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
                          if(injectionnamecontroller.text.isEmpty){
                            NigDocToast().showErrorToast('Please Enter Injection Nmae');
                                          
                          }else if(injectionamountcontroller.text.isEmpty){
                            NigDocToast().showErrorToast(' Please Enter Injection Amount');
                                          
                          }
                          else if(injectionqtycontroller.text.isEmpty){
                            NigDocToast().showErrorToast('Please Enter Injection Qty');
                            }else if(expdatecontroller.text.isEmpty){
                            NigDocToast().showErrorToast('Please Select Exp Date');
                          }else{
                            var items={
                                "id":data['id'],
                                "injections_name":injectionnamecontroller.text.toString(),
                                "injection_amount":injectionamountcontroller.text.toString(),
                                "injection_qty":injectionqtycontroller.text.toString(),
                                "injection_exp_date":expdatecontroller.text.toString(),
                            };
                            var list = await PatientApi()
                                       .Editinjection( accesstoken, items);
                                   if (list['message'] ==
                                       "updated successfully") {
                                     NigDocToast().showSuccessToast(
                                         'updated successfully');
                                     Navigator.push(
                                         context,
                                         MaterialPageRoute(
                                             builder: (context) => InjectionList()));
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
                    
                       // }
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
                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>InjectionList()));
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
                                                  //  'is_delete':delete,
                                                 };
                                                 var list = await PatientApi()
                                          .Deleteinjection( accesstoken, value);
                                      if (list['message'] ==
                                          "Deleted successfully") {
                                        NigDocToast().showSuccessToast(
                                            'Deleted successfully');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => InjectionList()));
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
                                   ])
                                     
                     
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
                    floatingActionButton: FloatingActionButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>Add_injection()));
          },
          child: Icon(Icons.add,
          size: 30,
          color: Colors.white,
          ),
          backgroundColor:custom_color.appcolor,
          ),
          ));
  }
    getInjectionList() async {
    var List = await PatientApi().getinjectionList(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        
        
        injectionList = List['list'];
        isLoading=true;
        filterItems(searchText.text);
        
      });
     
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
        Injection_List = injectionList;
      });
    } 
    else if (text.length >= 3) {
      setState(() {
        Injection_List = injectionList.where((item) =>
            item['injections_name']
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