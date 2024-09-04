import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
import 'package:nigdoc/AppWidget/TestList/AddNewTest.dart';
import 'package:nigdoc/AppWidget/common/NigDocToast.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';
import '../../AppWidget/common/Colors.dart' as custom_color;

class TestList extends StatefulWidget {
  const TestList({super.key});

  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
   TextEditingController searchText = TextEditingController();
   TextEditingController testnamecontroller=TextEditingController();
   TextEditingController testamountcontroller=TextEditingController();

  
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
 var testList;
 var test_List;
 bool valid=false;
 bool MedicineLoader=false;

   @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];
    // getMediAndLabNameList();
    // gettestList();
    gettestlist();

    // gettreatmentlist();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // test_List=Helper().isvalidElement(searchList)&&searchText.text.isNotEmpty?searchList: testList;
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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: Text('Test List',
          
          style: TextStyle(color: Colors.white),),
          backgroundColor: custom_color.appcolor,
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
          body:isLoading? Container(
            height: screenHeight,
            child: Column(
              children: [
                SizedBox(height: 15,),
               
              
                Expanded(
                  child: SingleChildScrollView(
                    //physics: BouncingScrollPhysics(),
                    
                    child: Column(
                      children: [
                        Center(child: 
                        Container(
                          height: screenHeight * 0.06,
                          width: screenWidth*0.931,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: custom_color.appcolor),
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
                                      // searchList = testList.where((element) {
                                      //   var treatList = element['test_name'].toString().toLowerCase();
                                      //   return treatList.contains(text.toLowerCase());
                                      //   // return true;
                                      // }).toList();
                                      // this.setState(() {});
                                  },
                                  decoration: new InputDecoration(
                                    filled: true,
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    hintText: 'Search Test List Here...',
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
                                            searchText.clear();
                                            filterItems(searchText.text);
                                            // searchList='';
                                          });
                                        },
                                      ))
                                  : Container(),
                                   Container(
                                  width: screenWidth * 0.16,
                                  height: screenHeight,
                                  child: Icon(Icons.search,
                                      color: custom_color.appcolor)),
                            ],
                          ),
                        ),),
                              
                              
                            SizedBox(height: screenHeight*0.01),
                           
                              
                            Helper().isvalidElement(test_List) && test_List.length > 0 ?
                             Container(
                              //height:screenHeight * 0.80,
                              
                              
                             width: screenWidth,
                              padding:EdgeInsets.all(0),
                              child: 
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: test_List.length,
                                itemBuilder: (BuildContext context, int index){
                                  list=index+1;
                                  var data=test_List[index];
                                  return Container(
                                    child: Column(
                                      children: [
                                        Card(
                                          color: index % 2 == 0
                                                        ? custom_color.lightcolor
                                                        : Colors.white,
                                          child: ListTile(
                                            title: SizedBox(child: Text('${data['test_name']}')),
                                            subtitle:  Text('₹ ${data['test_amount']}'),
                                            leading: Padding(
                                              padding: const EdgeInsets.only(top:3.0),
                                              child: Text('$list'),
                                            ),
                                            
                                            trailing: PopupMenuButton(itemBuilder: (context)=>[
                                           PopupMenuItem(child: Row(
                                                   children: [
                                                     Icon(Icons.edit,color: custom_color.appcolor,),
                                                     Padding(padding: EdgeInsets.only(left: 10),
                                                     child: Text('Edit',style: TextStyle(fontSize: 16),),)
                                                   ],
                                  
                                                   
                                                 ),
                                                 onTap: () {
                                                  var item = {
                                                    testnamecontroller.text = data['test_name'].toString(),
                                                    testamountcontroller.text = data['test_amount'].toString(),
                                                  };
                                                   showDialog(context: context, builder: ((context) => AlertDialog(
                                                     actions: [
                                                         Padding(padding: EdgeInsets.all(10)),
                                                         Container(
                                                           height: screenHeight*0.04,
                                                           width: screenWidth*0.14,
                                                         ),                                        
                                  
                                               TextFormField(
                                               controller: testnamecontroller,
                                               decoration: InputDecoration(
                                               border: OutlineInputBorder(),
                                               labelText: 'Test Name',
                                                 ),
                                                ),
                                                SizedBox(height: screenHeight*0.02,),
                                                 TextFormField(
                                               controller: testamountcontroller,
                                               keyboardType: TextInputType.number,
                                               decoration: InputDecoration(
                                               border: OutlineInputBorder(),
                                               labelText: 'Test Amount',
                                                 ),
                                                ),
                                                SizedBox(height: screenHeight*0.04,),
                                                Row(
                                                children: [
                                                Padding(padding: EdgeInsets.only(left: 20),
                                                         
                                                         child: ElevatedButton( 
                               style: ButtonStyle(
                                 backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                 shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                    
                                 RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10),
                                                       
                                                      
                                  ),
                                                    
                                  )
                                            
                                  ),
                               child:Text('Cancel',style: TextStyle(color: Colors.white,fontSize: 20),),
                                  
                               onPressed: (() {
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>TestList()));
                               }),
                               
                               ),
                               
                               
                               ),
                                                         Padding(padding: EdgeInsets.only(left:20),
                                                         child: ElevatedButton(
                                style: ButtonStyle(
                                 backgroundColor: WidgetStateProperty.all<Color>(custom_color.appcolor),
                                 shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                    
                                 RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10),
                                                       
                                                      
                                  ),
                                                    
                                  )
                                            
                                  ),
                                child: Text('Update',style: TextStyle(color: Colors.white,fontSize: 20),),
                                onPressed: (() async{
                                       if(testnamecontroller.text.isEmpty){
                                                      NigDocToast().showErrorToast('Enter Test Name');
                                                     }else if(testamountcontroller.text.isEmpty){
                                                       NigDocToast().showErrorToast('Enter Test Amount');
                                                     }
                                                     
                                                     else{
                                             
                                                     var value={
                                                         'test_id':data['test_id'].toString(),
                                                         "test_name":testnamecontroller.text.toString(),
                                                         'test_amount':testamountcontroller.text.toString(),
                                                                                                                                                         
                                                      };
                                                      var list = await PatientApi()
                                                         .Edittest( accesstoken, value);
                                           if (list['message'] ==
                                               "updated successfully") {
                                             NigDocToast().showSuccessToast(
                                                 'updated successfully');
                                             Navigator.push(
                                                 context,
                                                 MaterialPageRoute(
                                                     builder: (context) => TestList()));
                                           } else {
                                             NigDocToast()
                                                 .showErrorToast('Please TryAgain later');
                                           }
                                             }                         
                                                      
                                  
                                }),
                                ),
                                                         ),
                                  
                                                         
                               ],
                              ),
                               SizedBox(height: screenHeight*0.04,),
                                                     ],
                                                   )));
                                                 },
                                                 
                                                 )
                                         ]),
                                               
                                          ),
                                        ),
                                         
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
                ),
                     ],
            ),
          ):Center(
            child: Container(child:SpinLoader()
          )
          ),
           floatingActionButton: FloatingActionButton(onPressed: (){

            
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_TestList()));

          },
          child: Icon(Icons.add,
          size: 30,
          color: Colors.white,),
          backgroundColor: custom_color.appcolor,
          ),
          )
          );
  }
  // gettestList() async {
  //   var data = {
  //     "shop_id": Helper().isvalidElement(SelectedPharmacy)?SelectedPharmacy.toString():'',
  //   };

  //   var List = await PatientApi().getLabtestList(accesstoken,data);
  //   if (Helper().isvalidElement(List) &&
  //       Helper().isvalidElement(List['status']) &&
  //       List['status'] == 'Token is Expired') {
  //     Helper().appLogoutCall(context, 'Session expeired');
  //   } else {
  //     setState(() {
  //       //  MediAndLabNameList = List['list'];
  //       testList = List['list'];
  //       isLoading=true;
  //       MedicineLoader=true;
  //       valid=true;
  //     });
  //     // TreatmentList = List['list'];
  //     //  storage.setItem('diagnosisList', diagnosisList);
  //   }
  // }
  gettestlist() async {
    var List = await PatientApi().getlinklablist(accesstoken);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        isLoading=true;
        testList = List['list'];
        print(testList);
        filterItems(searchText.text);
      });
     
    }
  }


  getMediAndLabNameList() async {
    var data = {
      "type": 'lab',
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
  void filterItems(String text) {
    // setState(() {
    if (text.isEmpty) {
      setState(() {
        test_List = testList;
      });
    } 
    else if (text.length >= 3) {
      setState(() {
        test_List = testList.where((item) =>
            item['test_name']
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