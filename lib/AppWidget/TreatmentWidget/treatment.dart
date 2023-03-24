import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nigdoc/AppWidget/DashboardWidget/Dash.dart';
import 'package:nigdoc/AppWidget/PatientsWidget/Api.dart';
import 'package:nigdoc/AppWidget/common/SpinLoader.dart';
import 'package:nigdoc/AppWidget/common/utils.dart';

class TreatmentList extends StatefulWidget {
  const TreatmentList({super.key});

  @override
  State<TreatmentList> createState() => _TreatmentListState();
}

class _TreatmentListState extends State<TreatmentList> {
  final LocalStorage storage = new LocalStorage('doctor_store');
   TextEditingController searchText = TextEditingController();


  var accesstoken=null;
  var ProductList;
  var userResponse;
  bool isLoading=false;
  var list=0;
  
  var searchList;
  var treatmentList;
  var Treatment_List;

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
          context, MaterialPageRoute(builder: (context)=> Dash(),)
         );
         return true;
        },
        child:Scaffold(
          appBar: AppBar(title: Text('Treatment List',
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
                          Border.all(color: Color.fromARGB(255, 8, 122, 135)),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
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
                              searchList = treatmentList.where((element) {
                                var treatList = element['treatment_name'].toString().toLowerCase();
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
                                                ? Color.fromARGB(
                                                    255, 218, 235, 238)
                                                : Colors.white,
                                  child: ListTile(
                                    title: SizedBox(child: Text('${data['treatment_name']}')),
                                    leading: Text('$list'),
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
          ),
                         SizedBox(height: 10,),
                     ],
            ),),
          ):Center(
            child: Container(child:SpinLoader()
          ))));
  }
   gettreatmentlist() async {
    var List = await PatientApi().gettreatmentlist(accesstoken);
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