import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({super.key});

  @override
  State<MedicineList> createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
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
 var medicineList;
 var medicine_List;
 bool valid=false;
 bool MedicineLoader=false;

   @override
  void initState() {
    userResponse = storage.getItem('userResponse');
    accesstoken=userResponse['access_token'];
    getMediAndLabNameList();

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
          // backgroundColor: ,
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
                SizedBox(height: 20,),
                 Container(
                                              width: screenWidth *0.9,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Helper().isvalidElement(
                                                            MediNameList) &&
                                                        MediNameList.length > 0
                                                    ? DropdownButtonFormField(
                                                        // validator: (value) => validateDrops(value),
                                                        // decoration: InputDecoration(
                                                        //     enabledBorder: InputBorder.none,
                                                        //     border: UnderlineInputBorder(
                                                        //         borderSide: BorderSide(
                                                        //             color: Colors.white))),
                                                        // decoration:
                                                        //     InputDecoration.collapsed(
                                                        //         hintText: ''),
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              'Pharmacy',
                                                          border:
                                                              OutlineInputBorder(),
                                                          //icon: Icon(Icons.numbers),
                                                        ),
                                                        isExpanded: true,
                                                        hint: Text(
                                                          'Select Pharmacy',
                                                        ),
                                                        // value:patternDropdownvalue,
                                                        onChanged:
                                                            (item) async {
                                                          // medicineDropdownvalue =
                                                          //     item.toString();
                                                          var data = item
                                                              .toString()
                                                              .split('&*');
                                                              setState(() {
                                                                 SelectedPharmacy=data[0];
                                                                 getMedicineList();
                                                                 valid=true;
          
                                                              });
                                                        
                                                        },
                                                        items: MediNameList.map<
                                                            DropdownMenuItem<
                                                                String>>((item) {
                                                          return DropdownMenuItem(
                                                            child: Text(
                                                              item['pharmacy_name']
                                                                  .toString(),
                                                            ),
                                                            value: item['shop_id']
                                                                    .toString() +
                                                                '&*' + item['pharmacy_name']
                                                                    .toString()
                                                                
                                                          );
                                                        }).toList(),
                                                      )
                                                    : DropdownButtonFormField(
                                                        // validator: (value) => validateDrops(value),
                                                        // isExpanded: true,
                                                        hint: Text(
                                                            'NO Pharmacy List'),
                                                        // value:' _selectedState[i]',
                                                        onChanged: (Pharmacy) {
                                                          setState(() {});
                                                        },
                                                        items: [].map<
                                                            DropdownMenuItem<
                                                                String>>((item) {
                                                          return new DropdownMenuItem(
                                                            child: new Text(''),
                                                            value: '',
                                                          );
                                                        }).toList(),
                                                      ),
                                              ),
                                            ),
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
                ),valid?
                Column(
                  children: [
                    Center(child: 
                    Container(
                      height: screenHeight * 0.06,
                      width: screenWidth*0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color.fromARGB(255, 8, 122, 135)),
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                      child: Row(
                        children: [
                          Container(
                              width: screenWidth * 0.1,
                              height: screenHeight,
                              child: Icon(Icons.search,
                                  color: Color.fromARGB(255, 8, 122, 135))),
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
                        MedicineLoader?
          
                        Helper().isvalidElement(medicine_List) && medicine_List.length > 0 ?
                         Container(
                          height:screenHeight * 0.75,
                          
          
                         width: screenWidth,
                          padding:EdgeInsets.all(5),
                          child: 
                          ListView.builder(
                            // shrinkWrap: true,
                            itemCount: medicine_List.length,
                            itemBuilder: (BuildContext context, int index){
                              list=index+1;
                              var data=medicine_List[index];
                              return Container(
                                child: Column(
                                  children: [
                                    Card(
                                      color: index % 2 == 0
                                                    ? Color.fromARGB(
                                                        255, 218, 235, 238)
                                                    : Colors.white,
                                      child: ListTile(
                                        title: SizedBox(child: Text('${data['name']}')),
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
            ):Container(height: screenHeight*0.7,
              child:SpinLoader()
          ),
                             SizedBox(height: 10,),
                  ],
                ):Center(child:Text('Pls select Pharmacy')),
                     ],
            ),
          ):Center(
            child: Container(child:SpinLoader()
          )),));
  }
  getMedicineList() async {
    var data = {
      "shop_id": SelectedPharmacy.toString(),
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