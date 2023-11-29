import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/Setting/Setting.dart';
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
    gettestList();

    // gettreatmentlist();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    test_List=Helper().isvalidElement(searchList)&&searchText.text.isNotEmpty?searchList: testList;
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
                SizedBox(height: 20,),
               
              
                Column(
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
                                  searchList = testList.where((element) {
                                    var treatList = element['test_name'].toString().toLowerCase();
                                    return treatList.contains(text.toLowerCase());
                                    // return true;
                                  }).toList();
                                  this.setState(() {});
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
                       
          
                        Helper().isvalidElement(test_List) && test_List.length > 0 ?
                         Container(
                          height:screenHeight * 0.85,
                          
          
                         width: screenWidth,
                          padding:EdgeInsets.all(5),
                          child: 
                          ListView.builder(
                            // shrinkWrap: true,
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
                     ],
            ),
          ):Center(
            child: Container(child:SpinLoader()
          )),));
  }
  gettestList() async {
    var data = {
      "shop_id": Helper().isvalidElement(SelectedPharmacy)?SelectedPharmacy.toString():'',
    };

    var List = await PatientApi().getLabtestList(accesstoken,data);
    if (Helper().isvalidElement(List) &&
        Helper().isvalidElement(List['status']) &&
        List['status'] == 'Token is Expired') {
      Helper().appLogoutCall(context, 'Session expeired');
    } else {
      setState(() {
        //  MediAndLabNameList = List['list'];
        testList = List['list'];
        isLoading=true;
        MedicineLoader=true;
        valid=true;
      });
      // TreatmentList = List['list'];
      //  storage.setItem('diagnosisList', diagnosisList);
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
}