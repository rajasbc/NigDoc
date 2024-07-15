import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/Medicine/AddMedicineList.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
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
 'item1',
 'item2',
 'item3',
 'item4',
 'item5',
];

   @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];
    // getMediAndLabNameList();
    getMedicineList();

    // gettreatmentlist();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    medicine_List=Helper().isvalidElement(searchList)&&searchText.text.isNotEmpty?searchList: medicineList;
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
                // SizedBox(height: 20,),
                //  Container(
                //                               width: screenWidth *0.95,
                //                               child: Padding(
                //                                 padding:
                //                                     const EdgeInsets.all(0.0),
                //                                 child: Helper().isvalidElement(
                //                                             MediNameList) &&
                //                                         MediNameList.length > 0
                //                                     ? DropdownButtonFormField(
                //                                         // validator: (value) => validateDrops(value),
                //                                         // decoration: InputDecoration(
                //                                         //     enabledBorder: InputBorder.none,
                //                                         //     border: UnderlineInputBorder(
                //                                         //         borderSide: BorderSide(
                //                                         //             color: Colors.white))),
                //                                         // decoration:
                //                                         //     InputDecoration.collapsed(
                //                                         //         hintText: ''),
                //                                         decoration:
                //                                             const InputDecoration(
                //                                           labelText:
                //                                               'Pharmacy',
                //                                           border:
                //                                               OutlineInputBorder(),
                //                                           //icon: Icon(Icons.numbers),
                //                                         ),
                //                                         isExpanded: true,
                //                                         hint: Text(
                //                                           'Select Pharmacy',
                //                                         ),
                //                                         // value:patternDropdownvalue,
                //                                         onChanged:
                //                                             (item) async {
                //                                           // medicineDropdownvalue =
                //                                           //     item.toString();
                //                                           var data = item
                //                                               .toString()
                //                                               .split('&*');
                //                                               setState(() {
                //                                                  SelectedPharmacy=data[0];
                //                                                  getMedicineList();
                //                                                  valid=true;
                //                                                  MedicineLoader=false;
          
                //                                               });
                                                        
                //                                         },
                //                                         items: MediNameList.map<
                //                                             DropdownMenuItem<
                //                                                 String>>((item) {
                //                                           return DropdownMenuItem(
                //                                             child: Text(
                //                                               item['pharmacy_name']
                //                                                   .toString(),
                //                                             ),
                //                                             value: item['shop_id']
                //                                                     .toString() +
                //                                                 '&*' + item['pharmacy_name']
                //                                                     .toString()
                                                                
                //                                           );
                //                                         }).toList(),
                //                                       )
                //                                     : DropdownButtonFormField(
                //                                         // validator: (value) => validateDrops(value),
                //                                         // isExpanded: true,
                //                                         hint: Text(
                //                                             'NO Pharmacy List'),
                //                                         // value:' _selectedState[i]',
                //                                         onChanged: (Pharmacy) {
                //                                           setState(() {});
                //                                         },
                //                                         items: [].map<
                //                                             DropdownMenuItem<
                //                                                 String>>((item) {
                //                                           return new DropdownMenuItem(
                //                                             child: new Text(''),
                //                                             value: '',
                //                                           );
                //                                         }).toList(),
                //                                       ),
                //                               ),
                //                             ),
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
                Expanded(
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
                            Container(
                                width: screenWidth * 0.1,
                                height: screenHeight,
                                child: Icon(Icons.search,
                                    color: custom_color.appcolor,)),
                            Container(
                              width: screenWidth * 0.65,
                              child: TextField(
                                controller: searchText,
                                onChanged: (text) {
                                  print(text);
                            
                                  this.setState(() {});
                                  // var list = ProductListItem;
                                    searchList = medicineList.where((element) {
                                      var treatList = element['name'].toString().toLowerCase();
                                      return treatList.contains(text.toLowerCase());
                                      // return true;
                                    }).toList();
                                    this.setState(() {});
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
                         
                            
                          Helper().isvalidElement(medicine_List) && medicine_List.length > 0 ?
                           Container(
                            // height:screenHeight * 0.85,
                            
                                     
                           width: screenWidth,
                            padding:EdgeInsets.all(5),
                            child: 
                            ListView.builder(
                              shrinkWrap: true,
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
                            //               trailing: IconButton(onPressed: (){
                            //                 var List=data;
                                     
                                     
                            //                  showDialog(
                                              
                            //   context: context,
                            //   builder: (ctx) => AlertDialog(
                                
                                
                            //     // backgroundColor: Color.fromARGB(0, 238, 236, 236),
                            //     title:  Text('Product:  ${List['name'].toString()}' ),
                            //     content:Container(
                            //       width: screenWidth*0.8,
                            //       height: screenHeight*0.15,
                                  
                            //       child:Column(
                            //       children:[
                            //         Row(
                            //           children: [
                            //              SizedBox(height: 10,),
                            //             Text('Cost: '),
                            //             Text('${List['cost'].toString()}',style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                            //           ],
                            //         ),
                            //          SizedBox(height: 10,),
                            //          Row(
                            //           children: [
                            //             Text('Price:'),
                            //             Text('${List['sale_price'].toString()}',style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                            //           ],
                            //         ),
                            //          SizedBox(height: 10,),
                            //          Row(
                            //           children: [
                            //             Text('Quantity:'),
                            //             Text('${List['qty'].toString()}',style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                            //           ],
                            //         ),
                            //         SizedBox(height: 10,),
                            //         Row(
                                      
                            //           children: [
                            //             Text('Status:'),
                            //             Text('${List['status'].toString()}',style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                            //           ],
                            //         )
                            //       ],
                            //     )
                                     
                            //     ),
                                    
                            //     actions: <Widget>[
                            //       TextButton(
                            //         onPressed: () {
                            //           Navigator.of(ctx).pop();
                            //           //  Helper().appLogoutCall(context, 'logout');
                            //         },
                            //         child: Container(
                            //           // color: Colors.green,
                            //           padding: const EdgeInsets.all(14),
                            //           child: const Text("Close"),
                            //         ),
                            //       ),
                            //       // TextButton(
                            //       //   onPressed: () {
                            //       //     // Navigator.of(ctx).pop();
                            //       //     Helper().appLogoutCall(context, 'logout');
                            //       //   },
                            //       //   child: Container(
                            //       //     // color: Colors.green,
                            //       //     padding: const EdgeInsets.all(14),
                            //       //     child: const Text("Yes"),
                            //       //   ),
                            //       // ),
                            //     ],
                            //   ),
                            // );
                                            
                            //               }, icon: Icon(Icons.menu)),

                             trailing: PopupMenuButton(itemBuilder: (context)=>
                    [
                    PopupMenuItem(child: Row(
                      children: [
                        
                          Icon(Icons.edit,
                          color: custom_color.appcolor,
                          ),
                             Padding(padding: EdgeInsets.only(left:10),
                             child: Center(child: Text('Edit',style: TextStyle(fontSize: 16),)),),

                      ],
                    ),
                    
                    onTap: () {
                   
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
                      
                      labelText: "Alternative Medicine "
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
                  SizedBox(height: screenHeight*0.04,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                       child: ElevatedButton( 
                       style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(custom_color.appcolor),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
       
      
    ),
    
  )
  
),
                         child:Text('Update',
                         style: TextStyle(fontSize: 20,color: Colors.white),),
                         onPressed: (() {
                           if(medicine_Controller.text.isEmpty){
                             NigDocToast().showErrorToast('Please Enter Medicine Nmae');

                           }else if(Alternative_Controller.text.isEmpty){
                             NigDocToast().showErrorToast('Enter The Alter Medicine');

                           }
                           else if(selected_item==null){
                             NigDocToast().showErrorToast('Select Pattern Type');
                           }else{
                             var data={
                                 "medicin":medicine_Controller.text.toString(),
                                 "altern":Alternative_Controller.text.toString(),
                                 "pattern Type":selected_item.toString(),
                             };
                            Helper().isvalidElement(data);
                              print(data);
                           }
                          
                         }),),
                     ),

                       Padding(
                         padding: const EdgeInsets.only(top: 0,left: 30,right:10),
                         child: ElevatedButton( 
                          
                          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(custom_color.appcolor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    
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
                       ),
                       SizedBox(height: screenHeight*0.04,),
                   ],
                 ),
                  
                            
                            
                          ],

                   ));
                  
                              },
                                        
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
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Add_MedicineList()));
            },
          child:Icon(Icons.add,
          size: 30,
          color: Colors.white,),
          backgroundColor: custom_color.appcolor,
            
            ), 

          )
          );
  }
  getMedicineList() async {
    var data = {
      "shop_id": Helper().isvalidElement(SelectedPharmacy)?  SelectedPharmacy.toString():'',
    };

    var List = await PatientApi().getmedicineList(accesstoken, data);
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
}